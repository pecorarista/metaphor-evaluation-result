import csv
from enum import unique, Enum
import itertools
import json
from pathlib import Path
from typing import List, Tuple

from sqlalchemy.engine import create_engine
from sqlalchemy.orm import Session
from sqlalchemy.orm.session import sessionmaker
from sqlalchemy.sql import func

from meteval.database.model import create_tables, Result


@unique
class Metric(Enum):
    Metaphoricity = 'metaphoricity'
    Novelty = 'novelty'
    Comprehensibility = 'comprehensibility'


def calc_means(session: Session) -> List[Tuple[str, str, str, str]]:
    query = session \
        .query(Result.metric,
               Result.noun,
               Result.verb,
               func.avg(Result.vote).label('average')) \
        .group_by(Result.metric,
                  Result.noun,
                  Result.verb)
    return [(r.noun, r.verb, r.metric, r.average) for r in query.all()]


def sort(session: Session, pos: str, metric: Metric) -> List[Tuple[str, str, str, str]]:
    subquery = session \
        .query(Result.noun,
               Result.verb,
               func.avg(Result.vote).label('average')) \
        .filter(Result.metric == metric.value) \
        .group_by(Result.metric,
                  Result.noun,
                  Result.verb) \
        .subquery()

    column = subquery.c.noun \
        if pos == 'noun' \
        else subquery.c.verb

    results = session \
        .query(column,
               func.sum(subquery.c.average).label('score')) \
        .group_by(column) \
        .order_by(func.sum(subquery.c.average)) \
        .all()

    return [(getattr(m, pos), m.score) for m in results]


def main() -> None:

    output_dir = Path('output')
    output_dir.mkdir(parents=True, exist_ok=True)

    engine = create_engine('sqlite://')
    SessionMaker = sessionmaker(bind=engine)
    session = SessionMaker()
    create_tables(engine)

    result_csv = Path('results/result.csv')
    results = []
    with result_csv.open(mode='r') as f:
        reader = csv.reader(f, delimiter=',')
        next(reader)
        for fields in reader:
            metric = fields[0]
            noun = fields[1]
            verb = fields[2]
            vote = fields[3]
            user_id = fields[4]
            results.append(Result(metric, noun, verb, vote, user_id).to_dict())
    session.execute(Result.__table__.insert(), results)

    with Path('resources/translation.json').open(mode='r') as f:
        t = json.load(f)

    ja_rows = calc_means(session)
    with Path('output/mean-ja.csv').open(mode='w') as ja:
        ja_writer = csv.writer(ja)
        ja_writer.writerows(ja_rows)
    with Path('output/mean-en.csv').open(mode='w') as en:
        en_writer = csv.writer(en)
        en_writer.writerows([(t[j[0]], t[j[1].replace('X', '')], j[2], j[3]) for j in ja_rows])

    for (pos, metric) in itertools.product(['noun', 'verb'], list(Metric)):
        ja_rows = sort(session, pos, metric)
        with Path('output/{}s-sorted-by-{}-ja.csv'.format(pos, metric.value)).open(mode='w') as ja:
            ja_writer = csv.writer(ja)
            ja_writer.writerows(ja_rows)

        with Path('output/{}s-sorted-by-{}-en.csv'.format(pos, metric.value)).open(mode='w') as en:
            en_writer = csv.writer(en)
            en_writer.writerows([(t[j[0].replace('X', '')], j[1]) for j in ja_rows])


if __name__ == '__main__':
    main()

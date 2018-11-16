from typing import Any, Dict, Union

from sqlalchemy import Column, Integer, String
from sqlalchemy.engine.base import Engine
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()


class Result(Base):

    __tablename__ = 'results'

    metric = Column(String, primary_key=True)
    noun = Column(String, primary_key=True)
    verb = Column(String, primary_key=True)
    vote = Column(Integer)
    user_id = Column(String, primary_key=True)

    def __init__(self,
                 metric: str,
                 noun: str,
                 verb: str,
                 vote: Union[None, int],
                 user_id: str):

        self.metric = metric
        self.noun = noun
        self.verb = verb
        self.vote = vote
        self.user_id = user_id

    def to_dict(self) -> Dict[str, Any]:
        return {'metric': self.metric,
                'noun': self.noun,
                'verb': self.verb,
                'vote': self.vote,
                'user_id': self.user_id}


def create_tables(engine: Engine) -> None:
    Base.metadata.create_all(engine, tables=[Result.__table__])

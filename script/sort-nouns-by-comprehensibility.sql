select
  noun,
  sum(average) as score
from (
  select
    noun,
    verb,
    avg(vote) as average
  from
    results
  where
    metric = 'comprehensibility'
  group by
    noun,
    verb,
    metric
) subquery
group by
  noun
order by
  score desc

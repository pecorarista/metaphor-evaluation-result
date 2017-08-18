select
  verb,
  sum(average) as score
from (
  select
    noun,
    verb,
    avg(vote) as average
  from
    results
  where
    metric = 'metaphoricity'
  group by
    noun,
    verb,
    metric
) subquery
group by
  verb
order by
  score desc

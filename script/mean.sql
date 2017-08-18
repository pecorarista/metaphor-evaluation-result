select
  noun,
  verb,
  metric,
  avg(vote) as mean
from
  results
group by
  noun,
  verb,
  metric

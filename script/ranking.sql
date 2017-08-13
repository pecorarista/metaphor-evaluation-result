select
  metric,
  rank() over (order by sum(vote) desc),
  noun,
  verb,
  trunc(avg(vote), 1) as average
from
  results
where
  metric = 'metric'
group by
  noun,
  verb,
  metric
order by
  average desc,
  noun,
  verb

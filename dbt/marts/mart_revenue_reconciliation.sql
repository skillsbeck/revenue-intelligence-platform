with recognized as (
  select month, sum(recognized_revenue) as recognized_revenue
  from {{ ref('int_subscription_monthly_mrr') }}
  group by 1
),
invoiced as (
  select month, sum(invoiced_amount) as invoiced_revenue
  from {{ ref('int_monthly_invoiced') }}
  group by 1
),
collected as (
  select month, sum(collected_amount) as collected_revenue
  from {{ ref('int_monthly_collections') }}
  group by 1
),
months as (
  select month from recognized
  union
  select month from invoiced
  union
  select month from collected
)
select
  m.month,
  coalesce(i.invoiced_revenue, 0) as invoiced_revenue,
  coalesce(c.collected_revenue, 0) as collected_revenue,
  coalesce(r.recognized_revenue, 0) as recognized_revenue,
  coalesce(i.invoiced_revenue, 0) - coalesce(r.recognized_revenue, 0) as invoiced_minus_recognized,
  coalesce(i.invoiced_revenue, 0) - coalesce(c.collected_revenue, 0) as invoiced_minus_collected
from months m
left join invoiced i on m.month = i.month
left join collected c on m.month = c.month
left join recognized r on m.month = r.month
order by 1

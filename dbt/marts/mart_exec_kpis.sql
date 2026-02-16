with rev as (
  select month, recognized_revenue
  from {{ ref('mart_recognized_revenue_company_month') }}
),
nrr as (
  select
    month,
    prior_mrr,
    current_mrr,
    churn_mrr,
    expansion_mrr,
    contraction_mrr,
    new_mrr,
    net_revenue_retention
  from {{ ref('mart_nrr_company_month') }}
),
recon as (
  select month, invoiced_revenue, collected_revenue
  from {{ ref('mart_revenue_reconciliation') }}
),
months as (
  select month from rev
  union select month from nrr
  union select month from recon
)
select
  m.month,
  coalesce(r.recognized_revenue, 0) as recognized_revenue,
  coalesce(rc.invoiced_revenue, 0) as invoiced_revenue,
  coalesce(rc.collected_revenue, 0) as collected_revenue,
  coalesce(n.prior_mrr, 0) as prior_mrr,
  coalesce(n.current_mrr, 0) as current_mrr,
  coalesce(n.new_mrr, 0) as new_mrr,
  coalesce(n.expansion_mrr, 0) as expansion_mrr,
  coalesce(n.contraction_mrr, 0) as contraction_mrr,
  coalesce(n.churn_mrr, 0) as churn_mrr,
  n.net_revenue_retention as nrr
from months m
left join rev r on m.month = r.month
left join nrr n on m.month = n.month
left join recon rc on m.month = rc.month
order by 1

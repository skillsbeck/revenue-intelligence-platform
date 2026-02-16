with cust_month as (
  select
    customer_id,
    month,
    sum(recognized_revenue) as mrr
  from {{ ref('int_subscription_monthly_mrr') }}
  group by 1,2
),
joined as (
  select
    cur.customer_id,
    cur.month,
    coalesce(prior.mrr, 0) as prior_mrr,
    cur.mrr as current_mrr
  from cust_month cur
  left join cust_month prior
    on cur.customer_id = prior.customer_id
   and prior.month = dateadd(month, -1, cur.month)
),
classified as (
  select
    month,
    customer_id,
    prior_mrr,
    current_mrr,
    case when prior_mrr > 0 and current_mrr = 0 then prior_mrr else 0 end as churn_mrr,
    case when prior_mrr > 0 and current_mrr > prior_mrr then current_mrr - prior_mrr else 0 end as expansion_mrr,
    case when prior_mrr > 0 and current_mrr < prior_mrr then prior_mrr - current_mrr else 0 end as contraction_mrr,
    case when prior_mrr = 0 and current_mrr > 0 then current_mrr else 0 end as new_mrr
  from joined
)
select
  month,
  sum(prior_mrr) as prior_mrr,
  sum(current_mrr) as current_mrr,
  sum(churn_mrr) as churn_mrr,
  sum(expansion_mrr) as expansion_mrr,
  sum(contraction_mrr) as contraction_mrr,
  sum(new_mrr) as new_mrr,
  case
    when sum(prior_mrr) = 0 then null
    else (sum(current_mrr) - sum(new_mrr)) / nullif(sum(prior_mrr), 0)
  end as net_revenue_retention
from classified
group by 1
order by 1

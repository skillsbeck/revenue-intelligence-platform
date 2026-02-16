-- Fails if an invoice references a customer not found in subscriptions (relationship integrity)
select
  i.invoice_id,
  i.customer_id
from {{ ref('stg_billing_invoices') }} i
left join {{ ref('stg_billing_subscriptions') }} s
  on i.customer_id = s.customer_id
where i.customer_id is not null
  and s.customer_id is null

select
  customer_id,
  date_trunc('month', invoice_date) as month,
  sum(invoice_amount) as invoiced_amount
from {{ ref('stg_billing_invoices') }}
where invoice_date is not null
group by 1,2

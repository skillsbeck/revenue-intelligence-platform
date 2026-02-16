-- Fails if invoice_id appears more than once in RAW invoices
select
  invoice_id,
  count(*) as cnt
from {{ source('raw','invoices') }}
group by 1
having count(*) > 1

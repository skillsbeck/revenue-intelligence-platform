with src as (
  select * from {{ source('raw', 'invoices') }}
),
transform as (
  select
    customer_id,
    invoice_id,
    try_to_date(invoice_date) as invoice_date,
    try_to_decimal(invoice_amount, 18, 2) as invoice_amount
  from src
),
deduped as (
  select *
  from transform
  qualify row_number() over (partition by invoice_id order by invoice_date desc) = 1
)
select * from deduped


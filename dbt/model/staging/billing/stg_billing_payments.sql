select
  customer_id,
  try_to_date(payment_date) as payment_date,
  try_to_decimal(payment_amount, 18, 2) as payment_amount
from {{ source('raw', 'payments') }}

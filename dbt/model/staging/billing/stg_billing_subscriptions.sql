select
  customer_id,
  try_to_date(start_date) as start_date,
  try_to_date(end_date) as end_date,
  try_to_decimal(contract_value, 18, 2) as contract_value,
  try_to_number(term_months) as term_months
from {{ source('raw', 'subscriptions') }}

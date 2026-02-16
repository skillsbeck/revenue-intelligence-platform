select
  customer_id,
  try_to_decimal(amount, 18, 2) as amount,
  stage
from {{ source('raw', 'crm_opportunities') }}

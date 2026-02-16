-- Note: the synthetic CRM table doesn't include close dates.
-- This mart produces a single "bookings total" row for demo purposes.
select
  date_trunc('month', current_date()) as month,
  sum(amount) as bookings
from {{ ref('stg_crm_opportunities') }}
where stage = 'Closed Won'

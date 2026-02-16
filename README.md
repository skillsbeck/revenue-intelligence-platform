# Revenue Intelligence Platform

Finance-grade revenue modeling architecture built using SQL and dbt principles.

## Problem

Finance and RevOps often report different revenue numbers due to inconsistent metric definitions and fragmented data sources.

This project demonstrates how to design a canonical logic layer that reconciles:

## Bookings

* Invoiced Revenue

* Recognized Revenue

* Net Revenue Retention (NRR)

## Architecture

## Key Capabilities

* Ratable revenue recognition modeling

* Churn / expansion classification logic

* Duplicate invoice detection

* CRM to Billing reconciliation

* Data validation patterns

## Example Logic
case 
  when prior_mrr = 0 and current_mrr > 0 then 'New'
  when current_mrr = 0 then 'Churn'
  when current_mrr > prior_mrr then 'Expansion'
  when current_mrr < prior_mrr then 'Contraction'
  else 'Retained'
end as revenue_classification

## Tech Stack

* SQL

* dbt-style layered modeling

* Snowflake-style warehouse

* Power BI (reporting layer)

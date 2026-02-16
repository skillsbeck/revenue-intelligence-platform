# Revenue Intelligence Platform

Finance & RevOps Single Source of Truth

## Overview

This project demonstrates the design of a finance-grade revenue modeling architecture for a high-growth SaaS environment.

The objective was to build a trusted logic layer that reconciles Bookings, Invoiced Revenue, Recognized Revenue, and Net Revenue Retention (NRR) — ensuring that Finance, RevOps, and Executive stakeholders operate from a consistent source of truth.

Rather than focusing on dashboards, this project focuses on the transformation and modeling layer that makes board-level reporting reliable.

## Business Problem

In many SaaS organizations:

* CRM reports “Bookings”

* Billing systems report “Invoiced Revenue”

* Finance reports “Recognized Revenue”

* RevOps reports “Churn” and “NRR”

These metrics often diverge due to inconsistent definitions, timing differences, and fragmented data pipelines.

This project addresses that gap by engineering canonical revenue definitions and centralized modeling logic.

## Architecture

Data flows from multiple operational systems into a layered transformation architecture:

### Operational Sources

* CRM (Closed Won Opportunities)

* Subscription Contracts

* Invoices (intentionally includes duplicates)

* Payments (includes missing records)

### Transformation Layers

* Staging: Standardize data types, handle nulls, deduplicate

* Intermediate: Build monthly revenue schedules and subscription logic

* Mart: Recognized revenue, churn classification, NRR metrics

The final output is a governed revenue mart suitable for Finance and Executive reporting.

## Core Capabilities
### Revenue Recognition Modeling

* Ratable recognition across subscription term

* Contract expansion and contraction handling

* Multi-month billing normalization

### Net Revenue Retention (NRR)

* Classification of:

- New revenue

- Expansion revenue

- Contraction

- Churn

* Monthly MRR comparisons

### Data Quality & Validation

* Duplicate invoice detection

* Orphan invoice checks

* Relationship testing between subscriptions and customers

* Guardrails to prevent reporting drift

### Business-to-Data Translation

* Canonical definitions for:

- Bookings vs Revenue

- Invoiced vs Recognized

- Active vs Churned Accounts

* Modeled to support board-level reporting accuracy

## Example Revenue Classification Logic
case 
  when prior_mrr = 0 and current_mrr > 0 then 'New'
  when current_mrr = 0 then 'Churn'
  when current_mrr > prior_mrr then 'Expansion'
  when current_mrr < prior_mrr then 'Contraction'
  else 'Retained'
end as revenue_classification


This logic ensures consistent NRR reporting across Finance and RevOps.

## Tech Stack

* SQL (advanced modeling, window functions, CTEs)

* dbt-style layered transformations

* Snowflake-style data warehouse architecture

* Power BI (reporting layer)

* Git-based version control

## Impact

This architecture:

* Eliminates ambiguity between bookings and revenue

* Reduces reconciliation cycles for Finance

* Establishes a durable logic layer for growth and M&A

* Enables trusted executive reporting

The focus is not just data movement — it is metric integrity.

## Why This Matters

Revenue metrics drive board discussions, investor confidence, and operational strategy.

Small inconsistencies in modeling can create significant business risk.

This project demonstrates how to engineer revenue data intentionally — with clarity, governance, and scalability in mind.

# Olist E-Commerce: End-to-End Sales \& Customer Analytics

An end-to-end analytics project on \~100K orders from Olist, a Brazilian e-commerce marketplace. It answers three business questions: where does revenue come from, why don't customers come back, and how does delivery performance affect customer satisfaction.

## Tech Stack

BigQuery (SQL) | Python (Pandas, SciPy, Scikit-learn) | Power BI | Tableau Public | Google Colab

## Pipeline

`Raw CSVs -> BigQuery (8 tables) -> SQL analysis -> Python statistics + K-Means -> Power BI \& Tableau dashboards`

## Key Insights

|Finding|Detail|
|-|-|
|Revenue|\~13.4M (Jan 2017 - Aug 2018, delivered orders)|
|Peak month|Nov 2017: 987K, +52% MoM (Black Friday)|
|Category concentration|Top 10 categories = 63% of revenue; `health\_beauty` leads at 9.4%|
|Retention|Only \~3% of customers placed a repeat order|
|Delivery impact|Late orders (6.7%) average 2.27 stars vs 4.29 on-time (Welch t-test p < 0.001, Cohen's d = 1.47)|
|Segments|K-Means on log-scaled RFM gives 4 segments; \~40% are "Lost high-value" one-time buyers (avg spend 237)|

## Recommendations

1. Set realistic delivery estimates and prioritise orders at risk of a 1-7 day delay (largest satisfaction drop happens in the first week).
2. Send follow-up offers within 7-14 days of a first purchase to the 16K recent buyers.
3. Run a targeted winback campaign for the Lost high-value segment; use low-cost email only for Lost low-value.

## Methods

* **SQL:** multi-table JOINs, CTEs, window functions (`LAG`, `RANK`, cumulative `SUM() OVER`), `HAVING`, `COUNTIF`
* **Statistics:** Spearman correlation, Welch's t-test, Cohen's d, 95% confidence interval
* **ML:** K-Means (k=4) on log-transformed, standardised RFM features
* **Note:** findings are observational associations, not proven causation.

## Challenges Faced

* BigQuery auto-detect misread CSV headers (columns became `string\_field\_0/1`); handled by mapping columns explicitly in queries.
* A wrong CSV was loaded into a table; caught by inspecting the schema with `SELECT \* LIMIT 5` and reloaded.
* Review text contains line breaks; fixed with the "Quoted newlines" load option.
* Two Power BI tables had no relationship, so each chart uses fields from one table only.

## Dashboards

**Executive dashboard (Power BI)**: monthly revenue, top 10 categories, KPIs

!\[Executive Dashboard](images/dashboard\_powerbi.png)

**Customer segments (Tableau Public)**: RFM + K-Means

!\[Customer Segments](images/dashboard\_tableau.png)

[Live Tableau dashboard](PASTE_YOUR_TABLEAU_PUBLIC_LINK_HERE) : 

https://public.tableau.com/app/profile/rajshree.potphode/viz/OlistCustomerSegmentsRFMK-Means/OlistCustomerSegmentsRFMK-Means?publish=yes

**Delivery delay vs review score**

!\[Delay vs Review](images/delay\_vs\_review.png)

## Project Structure

```
sql/          BigQuery queries (01-05)
notebooks/    Python: statistics and K-Means (add your .ipynb here)
images/       Charts and dashboard screenshots
```

## Dataset

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle).


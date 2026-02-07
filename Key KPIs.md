Key KPIs



Primary

1\. Total Closed Revenue

SUM(closed\_value)

Only Closed Won



2\. Average Price Realization Ratio

AVG(closed\_value / (srp \* quantity))

Core pricing metric



Note:No quantity column exist, most likely, there only 1 product per opportunity, so can I remove the quantity?



3.Average Discount / Premium Rate

AVG(price\_adjuctment\_percentage) or separate AVG(discount) and AVG(Premiun)



Feature: Price adjustment column in fact talble if + its premiun if - its discount

(closed\_value − expected\_srp) / expected\_srp



Note: Only for Won



Secondary



1\. Win Rate

Aggregated as a ratio

Not an average of rows, but a calculated aggregate:



Win Rate = COUNT(Closed Won) / COUNT(All Opportunities)



Question: Does the opportuniites in prospecting and engaging srtrate not included? I think on won and loss only needed for all opportinites(exclud from fact table)



2\. Average Deal Duration



Aggregated as an average

But only after calculating row-level duration:

deal\_duration\_days = close\_date - created\_date

AVG(deal\_duration\_days)



Need to add count of deal\_duration\_days feature column in fact table?



3\. Revenue per Sales Rep



Aggregated, but not necessarily an average



Common forms:



**Median revenue per rep (often better) (what does this mean?)**



Example:



Revenue per Rep = Total Closed Revenue / Number of Reps ?


Clarification Needed: In the KPI card will it show all rep r can this be put in a Bar chart?









KPIs.



Avg Price Adjustment Percentage

AVG(price\_adjustment\_pct) - Bench Mark: SRP (%0 price adjustment)



Total Closed Revenue

SUM(closed\_revenue) - need target



Closed Win Rate

(COUNT(Won Opportunities)/(CONUNT (won + loss opportunities))) - excludes engaging and prospecting stage -need target win rate





Visuals to answer why



AVG pricing/adjustment per Sales Rep - I think adjeustment percentage makes more sense since price varies greatly per product

AVG(price\_adjustment\_pct) BY sales\_rep



AVG Pring/adjustment per Product - same here

AVG(price\_adjustment\_pct) BY product



Total closed opportuniy by sales rep(stacked bar chart for won and loss)

Scatter Plot (Deal duration (Count of days) VS Pricing) need to normalize pricing? since it varies per product

Features to add to fact table:



price\_adj\_pct = % of deveation from SRP (+ sold in premiun, - is discounted)

deal\_duration\_day = count of day from start and end of deal

what else?















Final KPI, Visual, and Data Model Definition



Price Realization Analysis of Closed-Won Opportunities



1\. KPI Definitions (Final)

KPI 1: Average Price Adjustment Percentage



Purpose: Measure pricing discipline relative to SRP



Formula



AVG(price\_adjustment\_pct)





Benchmark



0% (Suggested Retail Price)



0% = premium pricing



< 0% = discounting



Notes



Benchmark, not a forced target



Normalized across products with different price points



KPI 2: Total Closed Revenue



Purpose: Measure realized revenue impact of pricing decisions



Formula



SUM(closed\_value)

WHERE stage = 'Closed Won'





Target



SUM(SRP\_value)

WHERE stage = 'Closed Won'





Notes



Target excludes lost opportunities



Isolates pricing performance from win/loss dynamics



Difference between actual and target quantifies revenue leakage or uplift



KPI 3: Closed Win Rate



Purpose: Measure sales effectiveness (contextual KPI)



Formula



COUNT(stage = 'Closed Won')

/

COUNT(stage IN ('Closed Won', 'Closed Lost'))





Target (Baseline)



Manager-level average win rate



If manager hierarchy is unavailable, use overall dataset average



Notes



Excludes Prospecting and Engaging stages



Used for context, not pricing evaluation



2\. Supporting Visuals (Final)

Visual 1: Average Price Adjustment by Sales Representative



Metric



AVG(price\_adjustment\_pct) BY sales\_rep





Purpose



Identify pricing discipline by rep



Compare premium vs discounting behavior



Reference



0% SRP benchmark line



Visual 2: Average Price Adjustment by Product



Metric



AVG(price\_adjustment\_pct) BY product





Purpose



Identify products driving discounting or premium pricing



Answer product-level pricing behavior question



Reference



0% SRP benchmark line



Visual 3: Total Opportunities by Sales Rep (Won vs Lost)



Metric



Count of Closed-Won and Closed-Lost opportunities by sales rep



Purpose



Provide volume and conversion context



Support interpretation of pricing behavior



Visual 4: Deal Duration vs Price Adjustment (Scatter Plot)



Axes



X-axis: deal\_duration\_days

Y-axis: price\_adjustment\_pct





Purpose



Evaluate relationship between sales cycle length and pricing outcomes



Normalized pricing enables cross-product comparison



Optional Enhancements



Trendline



Duration buckets (0–30, 31–60, 60+)



3\. Features to Add to Fact Table (Final)

Required Features

price\_adjustment\_pct

= (closed\_value - SRP\_value) / SRP\_value



deal\_duration\_days

= close\_date - open\_date



Strongly Recommended Features

is\_won

= stage = 'Closed Won'





Simplifies filtering



Improves SQL and BI model clarity



deal\_duration\_bucket

= CASE

&nbsp; WHEN deal\_duration\_days <= 30 THEN '0–30'

&nbsp; WHEN deal\_duration\_days <= 60 THEN '31–60'

&nbsp; ELSE '60+'

END





Improves storytelling and executive readability



4\. Final Notes (Why This Works)



Pricing KPIs are isolated from sales effectiveness



All pricing visuals use normalized metrics



Targets are data-driven and defensible



Model is clean, scalable, and interview-ready



If you want next, I can convert this into:



A Methodology section



A Power BI dashboard spec



A one-page executive summary




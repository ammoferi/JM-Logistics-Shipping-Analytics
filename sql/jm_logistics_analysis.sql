/* ==================================================
   JM LOGISTICS — SHIPMENT ANALYSIS
   ================================================== */

CREATE DATABASE IF NOT EXISTS jm_logistics;

USE jm_logistics;

CREATE TABLE shipments (
    Shipment_ID VARCHAR(10) PRIMARY KEY,
    Shipment_Date DATE,
    Carrier VARCHAR(30),
    Transport_Mode VARCHAR(10),
    Distance_Miles INT,
    Freight_Cost DECIMAL(10,2),
    Delivery_Status VARCHAR(10)
);

-- Count the rows to confirm all 1,000 shipments were imported
SELECT COUNT(*) AS total_shipments
FROM shipments;

select * 
from shipments
order by Shipment_ID
limit 5;

-- HOW MUCH DID JM LOGISTICE SPEND ON SHIPPING?
-- Here, we add all the freight costs of all shipping
select sum(Freight_Cost) as total_freight_cost
from shipments;

-- WHAT WAS THE AVERAGE COST PER SHIPMENT?
-- calculate the average freight cost and run to 2 decimal places
select round(avg(Freight_Cost),2) as avg_shipment_cost
from shipments;

-- HOW MANY SHIPMENTS ARRIVED ON TIME OR LATE?
-- Group shipments by delivery status and count each group
select Delivery_Status,count(*) as total_shipments
from shipments
group by Delivery_Status;

-- HOW MANY SHIPMENTS ARRIVED ON TIME OR LATE?
-- Group shipments by delivery status and count each group
select Delivery_Status, count(*) as total_shipments
from shipments
group by Delivery_Status;

-- HOW MANY SHIPMENTS ARRIVED ON TIME?
-- Add the on-time flags to count on-time shipments
select sum(
    case when Delivery_Status = 'On Time' then 1 else 0 end
) as on_time_shipments
from shipments;


-- WHAT % OF SHIPMENTS ARRIVED ON TIME?
-- Divide on-time shipment by all shipments and convert to a percentage
select round (
100 * sum(case when delivery_status = 'On Time' then 1 else 0 end) / count(*),2
) as on_time_delivery_pct
from shipments;


-- HOW MANY SHIPMENTS DID EACH CARRIER HANDLE, AND WHAT DID THEY COST?
-- Group shipments by carrier and calculate shipment counts and total costs
select carrier, count(*) as total_shipment, sum(freight_cost) as total_freight_cost
from shipments
group by carrier
order by total_freight_cost desc;


-- WHAT IS THE AVERAGE SHIPMENT COST FOR EACH CARRIER?
-- Group shipments by carrier and round the average cost to 2 decimal places
select carrier, round(avg(Freight_Cost),2) as avg_shipment_cost
from shipments
group by carrier
order by avg_shipment_cost desc;

-- WHAT PERCENTAGE OF EACH CARRIER'S SHIPMENTS ARRIVED ON TIME?
-- Calculate the on-time percentage for each carrier and round to 2 decimal places
select Carrier, count(*) as total_shipment,round(100 * sum(case when Delivery_Status = 'On Time' then 1 else 0 end)/count(*),2) as on_time_delivery_pct
from shipments
group by carrier
order by on_time_delivery_pct desc;


-- HOW MANY SHIPMENTS DID WE HANDLE AND HOW MUCH DID WE SPEND EACH MONTH?
-- Group shipments by year and month, then count shipments and add freight costs
select date_format(Shipment_Date, '%Y-%m') as shipment_month, count(*) as total_shipments, sum(Freight_Cost) as total_shipment_cost
from shipments
group by date_format(Shipment_Date, '%Y-%m')
order by shipment_month;

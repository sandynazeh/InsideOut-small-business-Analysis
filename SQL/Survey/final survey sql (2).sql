create database surveyy;
use surveyy;
SELECT * FROM surveyy.`customerfeedback`;
-- data cleaning
-- delete time column 
ALTER TABLE `surveyy`.`customerfeedback`
DROP COLUMN `ï»¿Timestamp`;

-- delete age group

ALTER TABLE `surveyy`.`customerfeedback`
DROP COLUMN `Age_Group`;
 -- delete gender
 ALTER TABLE `surveyy`.`customerfeedback`
DROP COLUMN `Gender`;

SET SQL_SAFE_UPDATES = 0;
UPDATE `surveyy`.`customerfeedback`
SET Satisfaction = 'Unknown'
WHERE Satisfaction IS NULL;

-- Update Purchase_Barrier column
UPDATE `surveyy`.`customerfeedback`
SET Purchase_Barrier = 'Unknown'
WHERE Purchase_Barrier IS NULL;

-- Update Encountered_Problems column
UPDATE `surveyy`.`customerfeedback`
SET Encountered_Problems = 'Unknown'
WHERE Encountered_Problems IS NULL;

-- Update Buy_Again column
UPDATE `surveyy`.`customerfeedback`
SET Buy_Again = 'Unknown'
WHERE Buy_Again IS NULL;

UPDATE `surveyy`.`customerfeedback`
SET `If yes, please specify the issue` = 'Unknown'
WHERE `If yes, please specify the issue` IS NULL;

--  Check Data Types
DESCRIBE `surveyy`.`customerfeedback`;


-- 📍 **Location Representation**: How are customers distributed by geographic location?
SELECT 
    Location, 
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
GROUP BY Location
ORDER BY count DESC;


--  **Occupation Analysis**: What is the distribution of occupations among respondents?
SELECT 
    Occupation, 
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
GROUP BY Occupation
ORDER BY count DESC;

--  **Platform Suitability**: Which platforms are most suitable for customer interaction with the brand?
SELECT 'TikTok' AS platform, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Platform_Suitability LIKE '%TikTok%'
UNION ALL
SELECT 'Facebook' AS platform, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Platform_Suitability LIKE '%Facebook%'
UNION ALL
SELECT 'Instagram' AS platform, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Platform_Suitability LIKE '%Instagram%';

--  **How Customers Heard About InsideOut**: How did customers first learn about the brand?
SELECT 
    First_Heard, 
    COUNT(*) AS count
FROM `survey`.`customer feedback`
GROUP BY First_Heard
ORDER BY count DESC;

--  **Interest in Additional Products**: How interested are customers in purchasing additional products?

SELECT 'Planner Accessories' AS product, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Interested_Products LIKE '%Planner accessories%'
UNION ALL
SELECT 'Notebooks' AS product, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Interested_Products LIKE '%Notebooks%'
UNION ALL
SELECT 'To-do Lists' AS product, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Interested_Products LIKE '%To-do lists%'
UNION ALL
SELECT 'Memos' AS product, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Interested_Products LIKE '%Memos%'
UNION ALL
SELECT 'Weekly Planners' AS product, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Interested_Products LIKE '%Weekly planners%'
UNION ALL
SELECT 'Not Interested' AS product, COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Interested_Products LIKE '%Not interested%';


--   How much are customers willing to pay for the planner?
SELECT 
    Willing_to_Pay, 
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
GROUP BY Willing_to_Pay
ORDER BY count DESC;

-- 🔁 **Repurchase Intent**: What are the results regarding customers' intent to repurchase?
SELECT 
    Buy_Again, 
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Buy_Again IN ('yes', 'no')
GROUP BY Buy_Again
ORDER BY count DESC;


-- **Willingness to Pay and Repeat Purchase**: What is the relationship between payment values and repeat purchase decisions?
SELECT 
    Willing_to_Pay, 
    Buy_Again,
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Willing_to_Pay != 'Unknown' AND Buy_Again != 'Unknown'
GROUP BY Willing_to_Pay, Buy_Again
ORDER BY count DESC;

--  **Preferred Planner Features**: What features do customers value the most in the planner?
SELECT 
    Planner_Feature, 
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
GROUP BY Planner_Feature
ORDER BY count DESC;

-- 🎁 **Preferred Promotions**: What types of promotions encourage customers to make a purchase?
SELECT 
    Promotion_Encouragement, 
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
GROUP BY Promotion_Encouragement
ORDER BY count DESC;

--  : What are the reasons preventing customers from making a purchase?
SELECT 
    Purchase_Barrier, 
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Purchase_Barrier IS NOT NULL AND Purchase_Barrier <> 'unknown'
GROUP BY Purchase_Barrier
ORDER BY count DESC;

-- How do purchase barriers vary by geographic location?
SELECT 
    Location,
    COUNT(*) AS count
FROM 
    `surveyy`.`customerfeedback`
WHERE 
    `Purchase_Barrier` = 'Shipping costs'
GROUP BY 
    Location
ORDER BY 
    count DESC;
    
-- Which occupations are most affected by the product's price as a purchase barrier
SELECT 
    Occupation, 
    COUNT(*) AS product_price_count
FROM 
    `surveyy`.`customerfeedback`
WHERE 
    `Purchase_Barrier` = 'Product price'
GROUP BY 
    Occupation
ORDER BY 
    product_price_count DESC;


-- How does customer satisfaction correlate with the occurrence of encountered problems?
SELECT 
    Satisfaction, 
    COUNT(*) AS problem_count
FROM `surveyy`.`customerfeedback`
WHERE Encountered_Problems = 'Yes'
GROUP BY Satisfaction;





-- 🧮 **Total and Repeat Customers**: What is the total number of customers, and how many are likely to purchase again?
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Buy_Again = 'Yes' THEN 1 ELSE 0 END) AS repeat_customers,
    (SUM(CASE WHEN Buy_Again = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100) AS repeat_customer_percentage
FROM `surveyy`.`customerfeedback`;


--  **Reasons for Not Buying Again**: What reasons lead customers to not make a repeat purchase?
SELECT 
    Purchase_Barrier, 
    COUNT(*) AS count
FROM `survey`.`customer feedback`
WHERE Purchase_Barrier != 'Unknown'
  AND Buy_Again != 'Unknown'  -- Exclude 'Unknown' from Buy_Again
  AND Buy_Again != 'I bought already.'  -- Exclude 'I bought already.' (with the dot)
GROUP BY Purchase_Barrier
ORDER BY count DESC;


-- ⚠️ **Issue Analysis**: What issues have customers encountered, excluding unknown values?
SELECT 
    `If yes, please specify the issue`, 
    COUNT(*) AS count
FROM `surveyy`.`customerfeedback`
WHERE Purchased = 'Yes' 
  AND Encountered_Problems = 'Yes' 
  AND `If yes, please specify the issue` != 'Unknown'
GROUP BY `If yes, please specify the issue`
ORDER BY count DESC;




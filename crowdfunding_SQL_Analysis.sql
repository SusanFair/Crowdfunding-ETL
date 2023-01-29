-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

-- Deliverable 4: SQL Analysis, Step 2
-- Join Campaign and Backer,live events
SELECT c.cf_id,
    c.outcome,
	b.backer_id
INTO backer_campaigns
FROM campaign as c
LEFT JOIN backers as b
ON c.cf_id = b.cf_id
WHERE c.outcome = ('live')

SELECT * FROM backer_campaigns

-- Count Backers per campaign based on join
SELECT COUNT(bc.backer_id), bc.cf_id
INTO backer_campain_count
FROM backer_campaigns as bc
GROUP BY bc.cf_id
ORDER BY bc.count DESC;

SELECT * FROM backer_campain_count



-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
-- Challenge - Deliverable 4: SQL Analysis, Step 3
-- Validate assumption using backers table - Total match
SELECT COUNT(b.backer_id), b.cf_id
INTO backer_count_backers
FROM backers as b
GROUP BY b.cf_id
ORDER BY b.count DESC;

SELECT * FROM backer_count_backers


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT c.goal,
	c.pledged,
	ct.first_name,
	ct.last_name,
	ct.email
INTO goal_remaining
FROM campaign as c
INNER JOIN contacts as ct
ON c.contact_id = ct.contact_id
WHERE c.outcome = ('live')

SELECT * FROM goal_remaining

-- Get delta of goal outstanding
SELECT gr.first_name,
	gr.last_name,
	gr.email,
	(gr.goal - gr.pledged) AS goal_remaining
INTO email_contacts_remaining_goal
FROM goal_remaining as gr
ORDER BY goal_remaining DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT b.email,
	b.first_name,
	b.last_name,
	b.cf_id,
	c.company_name,
	c.description,
	c.end_date,
	(c.goal - c.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as b
INNER JOIN campaign as c
ON b.cf_id = c.cf_id
ORDER BY email DESC;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount


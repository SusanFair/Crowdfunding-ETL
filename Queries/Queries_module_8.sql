-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/dlKkBe
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "campaign" (
    "cf_id" int   NOT NULL,
    "contact_id" int   NOT NULL,
    "company_name" varchar(100)   NOT NULL,
    "description" text   NOT NULL,
    "goal" numeric(10,2)   NOT NULL,
    "pledged" numeric(10,2)   NOT NULL,
    "outcome" varchar(50)   NOT NULL,
    "backers_count" int   NOT NULL,
    "country" varchar(10)   NOT NULL,
    "currency" varchar(10)   NOT NULL,
    "launch_date" date   NOT NULL,
    "end_date" date   NOT NULL,
    "category_id" varchar(10)   NOT NULL,
    "subcategory_id" varchar(10)   NOT NULL,
    CONSTRAINT "pk_campaign" PRIMARY KEY (
        "cf_id"
     )
);

CREATE TABLE "category" (
    "category_id" varchar(10)   NOT NULL,
    "category_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_category" PRIMARY KEY (
        "category_id"
     )
);

CREATE TABLE "subcategory" (
    "subcategory_id" varchar(10)   NOT NULL,
    "subcategory_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_subcategory" PRIMARY KEY (
        "subcategory_id"
     )
);

CREATE TABLE "contacts" (
    "contact_id" int   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "pk_contacts" PRIMARY KEY (
        "contact_id"
     )
);


ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_contact_id" FOREIGN KEY("contact_id")
REFERENCES "contacts" ("contact_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_category_id" FOREIGN KEY("category_id")
REFERENCES "category" ("category_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_subcategory_id" FOREIGN KEY("subcategory_id")
REFERENCES "subcategory" ("subcategory_id");

SELECT * FROM contacts

SELECT * FROM subcategory

SELECT * FROM category

SELECT * FROM campaign


-- Module 8 Challenge
-- Create Backers schema
CREATE TABLE "backers" (
    "backer_id" varchar(5)   NOT NULL,
	"cf_id" int   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "cf_id" PRIMARY KEY (
        "backer_id"
     )
);

ALTER TABLE "backers" ADD CONSTRAINT "fk_backers_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");

SELECT * FROM backers


-- Challenge - Deliverable 4: SQL Analysis, Step 2
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



-- Challenge - Deliverable 4: SQL Analysis, Step 3
-- Validate assumption using backers table - Total match
SELECT COUNT(b.backer_id), b.cf_id
INTO backer_count_backers
FROM backers as b
GROUP BY b.cf_id
ORDER BY b.count DESC;

SELECT * FROM backer_count_backers

--Challenge - Deliverable 4: SQL Analysis, Step 4
-- New table with first_name, last_name, email and remaining goal amount
-- in descending order for each live campaign
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

SELECT * FROM email_contacts_remaining_goal
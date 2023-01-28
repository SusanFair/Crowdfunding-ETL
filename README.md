# Crowdfunding-ET


## Note from Kobert


TA - Kobert
  9:42 PM
@here In doing Challenge #8 Deliverable #4 1st question, you may wonder where to find the campaign information.
In fact, the  campaign information comes from the campaign.csv file in module 8.5.1.  What you need to do is to load this csv file into the database table campaign.  Then you will have all the information to finish the rest of the assignment. (edited) 





Module 8 - ETL
Independent Funding is a crowdfunding platform for funding independent projects or ventures.

Independent Funding has been growing, so now it needs to move all their accessible data from one large Excel file onto a PostgreSQL database. This way, the analytics team will be able to perform analysis and create reports for company stakeholders as well as individuals who donate to projects.

Britta, a junior SQL developer, has been tasked with the following:

Extracting and transforming the data from the large Excel file into four separate CSV files

Creating a PostgreSQL database and tables by using an ERD

Loading the CSV files into the database

Performing SQL queries to generate reports for stakeholders

For the ETL project, you’ll first help Britta with the extract phase. Specifically, you’ll write the code to read each worksheet of the crowdfunding.xlsx file into a Pandas DataFrame. In later lessons, you’ll help Britta with the transform and load phases. Specifically, you’ll create the following DataFrames, export each as a CSV file, and then upload the CSV files into the appropriate tables in the PostgreSQL database:

A category_df DataFrame
* A column named "category" that contains each category from the "category & sub-category" column of the crowdfunding_info worksheet.

* A column named "category_id" that contains a unique number for each category in the "category & sub-category" column of the crowdfunding_info worksheet, which we’ll use as the primary key for the category table in our crowdfunding_db database.


A subcategory_df DataFrame
* A column named "subcategory" that contains each subcategory from the "category & sub-category" column of the crowdfunding_info worksheet.

* A column named "subcategory_id" that contains a unique number for each subcategory in "category & sub-category" column of the crowdfunding_info worksheet, which we’ll use as the primary key for the subcategory table in our crowdfunding_db database.
A campaign_df DataFrame

A contacts_df DataFrame
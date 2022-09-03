# data_cleaning
An SQL data cleaning project

## Introduction
A faux dataset of club member information gathered via an online form.

## Problem Statement

In Data Analysis, the analyst must ensure that the data is 'clean' before doing any analysis.  'Dirty' data can lead to unreliable, inaccurate and/or misleading results.  Garbage in = garbage out.

These are the some steps that can be taken to properly prepare your dataset for analysis.

- Check for duplicate entries and remove them.
- Remove extra spaces and/or other invalid characters.
- Separate or combine values as needed.
- Ensure that certain values (age, dates...) are within certain range.
- Check for outliers.
- Correct incorrect spelling or inputted data.
- Adding new and relevant rows or columns to the new dataset.
- Check for null or empty values.

Using the criteria above, create a new SQL table with the properly formatted data.

- Create a key id.
- Remove special characters, ensure all entries are lowercase and free of extra whitespace.
- Separate full name to individual columns (firstname, last_name).
- Some ages have an extra digit at the end only show the first 2 digits.
- Email addresses are unique.  Use this column when searching for duplicates and remove duplicate entries.
- Convert all empty fields to NULL.
- Separate address to three different columns (street_address, city, state)
- All membership_dates were in the 2000's. 

## Datasets used
This dataset contains one csv file named 'club_member_info'.

The initial columns and their type in the provided CSV file are:
- full_name : text
- age : int
- matial_status : text
- email : text
- phone : text
- full_address : text
- job_title : text
- membership_date : date


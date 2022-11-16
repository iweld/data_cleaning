# data_cleaning
An SQL data cleaning project

## Introduction
A faux dataset of club member information gathered via an online form.

[Data Cleaning Walk-Through](https://github.com/iweld/data_cleaning/blob/main/club_member_info/DATA_CLEANING.md)

## Problem Statement

In Data Analysis, the analyst must ensure that the data is 'clean' before doing any analysis.  'Dirty' data can lead to unreliable, inaccurate and/or misleading results.  Garbage in = garbage out.

- Create a key id.
- Remove special characters, ensure all entries are lowercase and free of extra whitespace.
- Separate full name to individual columns (firstname, last_name).
- Some ages have an extra digit at the end only show the first 2 digits.
- Email addresses are unique.  Use this column when searching for duplicates and remove duplicate entries.
- Convert all empty fields to NULL.
- Separate address to three different columns (street_address, city, state)
- All membership_dates were in the 2000's. 

## Datasets used
This dataset contains one csv file named '[club_member_info.csv](https://github.com/iweld/data_cleaning/blob/main/club_member_info/DATA_CLEANING.md)'.

The initial columns and their type in the provided CSV file are:
- full_name : text
- age : int
- matial_status : text
- email : text
- phone : text
- full_address : text
- job_title : text
- membership_date : date


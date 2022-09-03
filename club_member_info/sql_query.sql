/* 
 * Club Member Info
 * An SQL exercise for practicing data cleaning by Jaime M. Shaker jaime.m.shaker@gmail.com
 *   

For this project, you play a role as a Data Analyst the must clean and restructure a dirty dataset.

A survey was done of current club members and we would like to restructure the data to a more organized and usable form.

In this project, we will 

1. Check for duplicate entries and remove them.
2. Remove extra spaces and/or other invalid characters.
3. Separate or combine values as needed.
4. Ensure that certain values (age, dates...) are within certain range.
5. Check for outliers.
6. Correct incorrect spelling or inputted data.
7. Adding new and relevant rows or columns to the new dataset.
8. Check for null or empty values.

Lets take a look at the first few rows to examine the data in its original form.

*/

SELECT 
	*
FROM club_member_info
LIMIT 10;

-- Results:

full_name            |age|maritial_status|email                   |phone       |full_address                                |job_title                   |membership_date|
---------------------+---+---------------+------------------------+------------+--------------------------------------------+----------------------------+---------------+
addie lush           | 40|married        |alush0@shutterfly.com   |254-389-8708|3226 Eastlawn Pass,Temple,Texas             |Assistant Professor         |     2013-07-31|
ROCK CRADICK         | 46|married        |rcradick1@newsvine.com  |910-566-2007|4 Harbort Avenue,Fayetteville,North Carolina|Programmer III              |     2018-05-27|
???Sydel Sharvell    | 46|divorced       |ssharvell2@amazon.co.jp |702-187-8715|4 School Place,Las Vegas,Nevada             |Budget/Accounting Analyst I |     2017-10-06|
Constantin O Sullivan| 35|               |co3@bloglines.com       |402-688-7162|6 Monument Crossing,Omaha,Nebraska          |Desktop Support Technician  |     2015-10-20|
  Gaylor Redhole     | 38|married        |gredhole4@japanpost.jp  |917-394-6001|88 Cherokee Pass,New York City,New York     |Legal Assistant             |     2019-05-29|
Wanda Kunzel         | 44|single         |wkunzel5@slideshare.net |937-467-6942|10864 Buhler Plaza,Hamilton,Ohio            |Human Resources Assistant IV|     2015-03-24|
Jo-ann Kenealy       | 41|married        |jkenealy6@bloomberg.com |513-726-9885|733 Hagan Parkway,Cincinnati,Ohio           |Accountant IV               |     2013-04-17|
Joete Cudiff         | 51|separated      |jcudiff7@ycombinator.com|616-617-0965|975 Dwight Plaza,Grand Rapids,Michigan      |Research Nurse              |     2014-11-16|
mendie alexandrescu  | 46|single         |malexandrescu8@state.gov|504-918-4753|34 Delladonna Terrace,New Orleans,Louisiana |Systems Administrator III   |     2021-03-12|
fey kloss            | 52|married        |fkloss9@godaddy.com     |808-177-0318|8976 Jackson Park,Honolulu,Hawaii           |Chemical Engineer           |     2014-11-05|

/*

Lets create a temp table where we can manipulate and restructure the data without altering the original.     
 
 */

DROP TABLE IF EXISTS cleaned_club_member_info;
CREATE TABLE cleaned_club_member_info AS (
	SELECT 
		-- Some of the names have extra spaces and special characters.  Trim access whitespace, remove special characters 
		-- and convert to lowercase.
		-- In this particular dataset, special characters only occur in the first name that can be removed using a simple regex.
		regexp_replace(split_part(trim(lower(full_name)), ' ', 1), '\W+', '', 'g') AS first_name,
		-- Some last names have multiple words ('de palma' or 'de la cruz'). Convert the string to an array to calculate its length and use a 
		-- case statement to find entries with those particular types of surnames.
		CASE
			WHEN array_length(string_to_array(trim(lower(full_name)), ' '), 1) = 3 THEN concat(split_part(trim(lower(full_name)), ' ', 2) || ' ' || split_part(trim(lower(full_name)), ' ', 3))
			WHEN array_length(string_to_array(trim(lower(full_name)), ' '), 1) = 4 THEN concat(split_part(trim(lower(full_name)), ' ', 2) || ' ' || split_part(trim(lower(full_name)), ' ', 3) || ' ' || split_part(trim(lower(full_name)), ' ', 4))
			ELSE split_part(trim(lower(full_name)), ' ', 2)
		END AS last_name,
		-- During data entry, some ages have an additional digit at the end.  Remove the last digit when a 3 digit age value occurs.
		CASE
			-- First cast the integer to a string and test the character length.
			-- If condition is true, cast the integer to text, extract first 2 digits and cast back to numeric type.
			WHEN length(age::text) = 3 THEN substr(age::text, 1, 2)::numeric
			ELSE age
		END age
	FROM club_member_info
);



SELECT * FROM cleaned_club_member_info LIMIT 10;












# Club Member Information
## An SQL Data Cleaning Project
### by jaime.m.shaker@gmail.com

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

## A. Create a one column table and use that column as the primary key
````sql
COPY WORDS
FROM
'** Path to your **/csv/words.csv'
DELIMITER ',';
````
### Test table by randomly grabbing an awesome word from the table

````sql
SELECT
	WORD AS great_word
FROM
	WORDS
WHERE
	WORD = 'shaker';
````

**Results:**

great_word|
----------|
shaker    |

### How many words are in our table?

````sql
SELECT
	COUNT(*) AS word_count
FROM
	WORDS;
````

**Results:**

word_count|
----------|
370103|

### How many words start with the letter 'j'?

````sql
SELECT
	COUNT(*) AS j_count
FROM
	WORDS
WHERE
	WORD LIKE 'j%';
````

**Results:**

j_count|
-------|
2840|


### How many words are x letters long?

````sql
SELECT
	char_length(word) AS word_length,
	count(*) AS word_count
FROM
	words
WHERE char_length(word) > 1
GROUP BY
	word_length
ORDER BY
	word_length
````

**Results:**

word_length|word_count|
-----------|----------|
2|       427|
3|      2130|
4|      7186|
5|     15918|
6|     29874|
7|     41998|
8|     51627|
9|     53402|
10|     45872|
11|     37539|
12|     29125|
13|     20944|
14|     14149|
15|      8846|
16|      5182|
17|      2967|
18|      1471|
19|       760|
20|       359|
21|       168|
22|        74|
23|        31|
24|        12|
25|         8|
27|         3|
28|         2|
29|         2|
31|         1|

### How many words contain 'jaime'?

````sql
SELECT
	COUNT(*) as jaime_count
FROM
	WORDS
WHERE
	WORD LIKE '%jaime%';
````

**Results:**

jaime_count|
-----------|
1|

### How many words contain 'shaker'?

````sql
SELECT
	COUNT(*) AS shaker_count
FROM
	WORDS
WHERE
	WORD LIKE '%shaker%';
````

**Results:**

shaker_count|
------------|
13|

### What are those words?

````sql
SELECT
	WORD
FROM
	WORDS
WHERE
	WORD LIKE '%shaker%';
````

**Results:**

word        |
------------|
boneshaker  |
earthshaker |
hallanshaker|
handshaker  |
headshaker  |
saltshaker  |
shaker      |
shakerag    |
shakerdom   |
shakeress   |
shakerism   |
shakerlike  |
shakers     |

### What is the longest word in this table and how many characters does it contain?

````sql
SELECT 
	WORD AS "Longest Word", 
	length(word) AS "Word Length"
FROM
	WORDS
WHERE
	LENGTH(WORD) =
		(
	SELECT
		MAX(LENGTH(WORD))
	FROM
		WORDS);
````

**Results:**

Longest Word                   |Word Length|
-------------------------------|-----------|
dichlorodiphenyltrichloroethane|         31|

### What is the average length of a word?

````sql
SELECT
	AVG(LENGTH(WORD)) avg_length
FROM
	WORDS;
````

**Results:**

avg_length        |
------------------|
9.4424984396235643|

### That returned a floating point value.  Can you round that number to zero decimal places?

````sql
SELECT
	ROUND(AVG(LENGTH(WORD)))
FROM
	WORDS;
````

**Results:**

rounded_length|
--------------|
9|

### What is the 25th percentile, Median and 90th percentile length?

````sql
SELECT
	PERCENTILE_CONT(0.25) WITHIN GROUP(
	ORDER BY length(word)) AS "25th_percentile",
	PERCENTILE_CONT(0.5) WITHIN GROUP(
	ORDER BY length(word)) AS median_length,
	PERCENTILE_CONT(0.9) WITHIN GROUP(
	ORDER BY length(word)) AS "90th_percentile"
FROM
	words;
````

**Results:**

25th_percentile|median_length|90th_percentile|
---------------|-------------|---------------|
7.0|          9.0|           13.0|


### What is the word count for every letter in the words table  and what is the percentage of the total? Sort by letter in ascending order.

````sql
SELECT 
	letter,
	word_count,
	round((word_count::float / (SELECT count(*) FROM words)*100)::NUMERIC, 2) AS total_percentage
from
	(SELECT
		SUBSTRING(LOWER(word), 1, 1) AS letter,
		COUNT(*) AS word_count
	FROM
		words
	GROUP BY
		letter) AS tmp
GROUP BY 
	letter,
	word_count
ORDER BY
	letter;
````

**Results:**

letter|word_count|total_percentage|
------|----------|----------------|
a     |     25416|            6.87|
b     |     18413|            4.98|
c     |     32107|            8.68|
d     |     18733|            5.06|
e     |     14197|            3.84|
f     |     11893|            3.21|
g     |     10953|            2.96|
h     |     13743|            3.71|
i     |     13199|            3.57|
j     |      2840|            0.77|
k     |      3952|            1.07|
l     |     10002|            2.70|
m     |     19805|            5.35|
n     |     13458|            3.64|
o     |     12681|            3.43|
p     |     34860|            9.42|
q     |      1793|            0.48|
r     |     16783|            4.53|
s     |     38764|           10.47|
t     |     18819|            5.08|
u     |     22767|            6.15|
v     |      5329|            1.44|
w     |      6559|            1.77|
x     |       507|            0.14|
y     |      1143|            0.31|
z     |      1387|            0.37|

### What row number is the word 'shaker' in?

````sql
SELECT
	ROW_NUM AS "Row Number",
	WORD AS "Cool Last Name"
FROM
	(
	SELECT
		WORDS.*,
			ROW_NUMBER() OVER() AS ROW_NUM
	FROM
		WORDS) AS ROW
WHERE
	WORD = 'shaker';
````

**Results:**

Row Number|Cool Last Name|
----------|--------------|
287206|shaker        |

### Find the count of all the palindromes (Excluding single and two letter words)

````sql
SELECT
	COUNT(*) AS n_palindromes
FROM
	WORDS
WHERE
	WORD = REVERSE(WORD)
	AND LENGTH(WORD) >= 3;
````

**Results:**

n_palindromes|
-------------|
193|

### Find the first 10 of all the palindromes that begin with the letter 'r' (Excluding single and two letter words)

````sql
SELECT
	WORD AS s_palindromes
FROM
	WORDS
WHERE
	WORD = REVERSE(WORD)
	AND LENGTH(WORD) >= 3
	AND word LIKE 'r%'
ORDER BY
	WORD
LIMIT 10;
````

**Results:**

r_palindromes|
-------------|
radar        |
redder       |
refer        |
reifier      |
renner       |
repaper      |
retter       |
rever        |
reviver      |
rotator      |

### Return the 15th palindrome (Excluding single and double letter words) of words that start with the letter 's'

````sql
SELECT
	WORD AS "15th_s_palindrome"
FROM
	WORDS
WHERE
	WORD = REVERSE(WORD)
	AND LENGTH(WORD) >= 3
	AND word LIKE 's%'
ORDER BY
	WORD
LIMIT 1 
OFFSET 14;
````

**Results:**

15th_s_palindrome|
-----------------|
sooloos          |

### Find the row number for every month of the year and sort them in chronological order

````sql
SELECT
	ROW_NUM AS "Row Number",
	WORD AS "Month"
FROM
	(
	SELECT
		WORDS.*,
			ROW_NUMBER() OVER() AS ROW_NUM
	FROM
		WORDS) AS ROW
WHERE
	WORD IN (
	'january',
	'february',
	'march',
	'april',
	'may',
	'june',
	'july',
	'august',
	'september',
	'october',
	'november',
	'december')
ORDER BY
	TO_DATE(WORD, 'Month');
````

**Results:**

Row Number|Month    |
----------|---------|
160354|january  |
110743|february |
179890|march    |
18069|april    |
177740|may      |
162341|june     |
162225|july     |
23405|august   |
285651|september|
211036|october  |
209152|november |
78173|december |

















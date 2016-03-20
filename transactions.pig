-- Comparing SQL with Pig Latin Script.
-- CREATE TEMP TABLE t1 AS
-- SELECT customer, sum(purchase) AS total_purchases
-- FROM transactions
-- GROUP BY customer;

-- SELECT customer, total_purchases, zipcode
-- FROM t1, customer_profile
-- WHERE t1.customer = customer_profile.customer;

-- Load the transactions file, group it by customer, and sum their total purchases
transactions = load 'transactions' as (customer,purchase);
grouped_by_customers = group transactions by customer;
customer_total = foreach grouped_by_customers generate group, SUM(transactions.purchase) as total_purchase;
customer_profile = load 'customer_profile' as (customer, zipcode);
-- join the grouped and summed transactions and customer_profile data
out = join customer_total by group, customer_profile by customer;
dump out;

/* original script.
txns    = load 'transactions' as (customer, purchase);
grouped = group txns by customer;
total   = foreach grouped generate group, SUM(txns.purchase) as tp;
-- Load the customer_profile file
profile = load 'customer_profile' as (customer, zipcode);
-- join the grouped and summed transactions and customer_profile data
answer  = join total by group, profile by customer;
-- Write the results to the screen
dump answer;
*/

-- extrcating top 5 urls visted by users between age 18 - 25.
users = load 'users' as (name, age);
users_filtered_by_age = filter users by age >= 18 and age <= 25;
pages = load 'pages' as (user, url);
users_join_Pages = join users_filtered_by_age by name, Pages by user;
-- The line url_grouped = group collects records together by URL. So for each value of url, 
-- such as pignews.com/frontpage, there will be one record with a collection of all
-- records that have that value in the url field.
url_grouped = group users_join_Pages by url;
url_count = foreach url_grouped generate group, COUNT(users_join_Pages) as num_of_clicks;
sorted_by_clicks = order url_count by num_of_clicks desc;
top5urls = limit sorted_by_clicks 5;
store top5urls into 'top5sites';
dump top5urls

/* original script.
Users = load 'users' as (name, age);
Fltrd = filter Users by age >= 18 and age <= 25;
Pages = load 'pages' as (user, url);
Jnd   = join Fltrd by name, Pages by user;
Grpd  = group Jnd by url;
Smmd  = foreach Grpd generate group, COUNT(Jnd) as clicks;
Srtd  = order Smmd by clicks desc;
Top5  = limit Srtd 5;
store Top5 into 'top5sites';
*/

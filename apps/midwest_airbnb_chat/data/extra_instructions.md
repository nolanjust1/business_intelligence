# Extra Instructions

Rules the LLM follows when it writes SQL for `listings`.

- `price` is the nightly price in U.S. dollars. When the user asks what something costs, use `price` and round money to whole dollars in the answer.


     
1. When asked about pricing, filter out records where `price` is NULL or equal to 0.
2. For queries comparing cities or neighborhoods, group by `neighbourhood` or `city` and aggregate using `AVG(price)` or `COUNT(id)`.
3. When users request top listings by capacity, order by `accommodates` DESC and limit results to the top 10.
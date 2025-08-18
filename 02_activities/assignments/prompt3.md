#### Prompt 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2? 

**HINT:** search type 1 vs type 2 slowly changing dimensions. 

CUSTOMER_ADDRESS table can either update the original row every time there are changes in the table, i.e., type 1 slowly changing dimension. It is the fastest and the simplest way to load dimension data. 
Or, table can retain the history and save the changes made in new row, i.e., type 2 slowy changing dimension. Old record is assigned a non active effective address and the new record is assigned an active effective address. And the new record is assigned a new and unique surrogate key. Hence, it is able to retain the other records depending on the old record. This methods adds a new row for the new value and maintains the existing/ previous row for historical and reporting purposes.
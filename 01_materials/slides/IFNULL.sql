SELECT * 
,IFNULL(product_size,'Unknown')

,IFNULL(product_size, product_qty_type)
,coalesce(product_size, product_qty_type,'missing')
,ifnull(IFNULL(product_size, product_qty_type),'missing')

FROM product


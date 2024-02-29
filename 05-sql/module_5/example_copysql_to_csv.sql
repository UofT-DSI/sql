CREATE TEMP TABLE high_low_inventory
(vendor_id INT
,product_id INT
,original_price REAL(10,2)
,rn_min INT);
INSERT INTO high_low_inventory ("vendor_id", "product_id", "original_price", "rn_min") VALUES ('4', '16', '0.5', '1');
INSERT INTO high_low_inventory ("vendor_id", "product_id", "original_price", "rn_min") VALUES ('7', '1', '6.99', '1');
INSERT INTO high_low_inventory ("vendor_id", "product_id", "original_price", "rn_min") VALUES ('7', '2', '3.49', '1');
INSERT INTO high_low_inventory("vendor_id", "product_id", "original_price", "rn_min") VALUES ('7', '3', '0.5', '1');
INSERT INTO high_low_inventory ("vendor_id", "product_id", "original_price", "rn_min") VALUES ('7', '4', '4', '1');
INSERT INTO high_low_inventory ("vendor_id", "product_id", "original_price", "rn_min") VALUES ('8', '5', '6.5', '1');
INSERT INTO high_low_inventory ("vendor_id", "product_id", "original_price", "rn_min") VALUES ('8', '7', '18', '1');
INSERT INTO high_low_inventory ("vendor_id", "product_id", "original_price", "rn_min") VALUES ('8', '8', '18', '1');

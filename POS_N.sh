
'Point of Sale' (POS).

#
https://www.aronium.com/en/download/lite


June2025

-can i integrate an digital kitchen scale to Aronium? 
2. Direct USB/Serial Connection (Less Common for "Kitchen" Scales with Aronium):
if you're looking for seamless integration, your best bet is a retail weighing scale that prints barcodes compatible with Aronium's barcode settings. Generic digital kitchen scales, while accurate for weighing, are often not designed with direct POS integration in mind.



#Point of Sale
https://docs.frappe.io/erpnext/v14/user/manual/en/accounts/point-of-sales

https://github.com/frappe/erpnext
git clone https://github.com/frappe/frappe_docker
cd frappe_docker
docker compose -f pwd.yml up -d
Username: Administrator
Password: admin

#
https://www.odoo.com/trial

#
3. Open Source Point of Sale (OSPOS):

    Overview: A web-based POS system built with PHP and MySQL. It''s designed for small and medium-sized businesses to manage sales, inventory, and customer data
	
#NexoPOS
ytb: NexoPOS



#uniCenta POS
Retail and hospitality with a need for direct source code control. - Robust feature set, REST API for integration. - Java
To install it is neccesary to download and install MariaDB, the installtion on Windows is done through an msi

$ git clone https://github.com/poolborges/unicenta-pos.git
$ cd unicenta-pos
$ docker run --name unicenta -p 3306:3306 -d -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=unicenta -e MYSQL_USER=unicenta -e MYSQL_PASSWORD=unicenta mysql:5.7
$ docker run --name unicentaMDB -p 3306:3306 -d -e MARIADB_ROOT_PASSWORD=root -e MARIADB_DATABASE=unicenta -e MARIADB_USER=unicenta -e MARIADB_PASSWORD=unicenta mariadb:10.5 #fix OK

$ docker exec -it unicentaMDB mysql -u unicenta -punicenta

$ /home/user/kriolos-opos.properties
                           db.URL=jdbc\:mysql\://localhost\:3306/
                           db.engine=MySQL
                           db.multi=false
                           db.options=
                           db.password=crypt\:CADCDF939C749159D36BF4054217529D
                           db.prodpriceupdate=false
                           db.user=unicenta
                           db.schema=unicenta
				* change to MySQL tipe DB		   

$ ./mvnw compile install
$ ./mvnw exec:java -pl kriolos-opos-app "-Dexec.mainClass=com.openbravo.pos.forms.StartPOS"

admin/admin
#connector
 kriolos-opos-app/target/lib/mysql-connector-j-9.2.0.jar
 kriolos-opos-app/pom.xml -> <mysql.version>9.2.0</mysql.version> -> <mysql.version>9..0</mysql.version>
 kriolos-opos-app/pom.xml -> ${mysql.version} to 
   
#FIX:
./kriolos-opos-domain/src/main/java/com/openbravo/pos/forms/DataLogicSales.java -> REMOVE: FUNCTION unicenta.ANY_VALUE
./kriolos-opos-base/src/main/java/com/openbravo/data/loader/Session.java -> SET TO FALSE: setAutoCommit(false);



> INSERT IGNORE INTO taxcategories (ID, NAME) VALUES ('04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', 'Standard Sales Tax');

> INSERT IGNORE INTO taxes (ID, NAME, CATEGORY, RATE) VALUES ('7b1c3a8e-2e6b-4e7f-8c9d-d1d2e3f4a5b6', 'IVA 5%', '04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', 0.05);

> INSERT IGNORE INTO categories (ID, NAME) VALUES ('c4d5e6f7-a8b9-c0d1-e2f3-a4b5c6d7e8f9', 'Groceries');

> SELECT ID, REFERENCE, CODE, NAME, PRICESELL, PRICEBUY, CATEGORY, TAXCAT, ISCOM, ISSCALE, DISPLAY, ATTRIBUTES, stockcost, stockvolume, stockunits, isvprice FROM products;

> SELECT  id, reference, code, codetype, name, pricebuy, pricesell, category, taxcat, attributeset_id, stockcost, stockvolume, iscom, isscale, isconstant, printkb, sendstatus, isservice, attributes, display, isvprice, isverpatrib, texttip, warranty, stockunits, printto, supplier, uom, memodate FROM products
----------------

> INSERT INTO products (ID, REFERENCE, CODE, NAME, PRICESELL, PRICEBUY, CATEGORY, TAXCAT, IMAGE, ISCOM, ISSCALE, DISPLAY, ATTRIBUTES, stockcost, stockvolume, stockunits, isvprice, codetype ) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', 'RICE001', '8712345678905', 'Rice - 1kg Bag', 4000, 3000, 'c4d5e6f7-a8b9-c0d1-e2f3-a4b5c6d7e8f9', '04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', NULL, FALSE, FALSE, '1kg Rice', NULL, 0, 0, 0, 0, 'EAN-13' );

> INSERT INTO products_cat (product, catorder) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', 10) ON DUPLICATE KEY UPDATE catorder = VALUES(catorder); #OK

> UPDATE products set codetype = 'EAN-13' WHERE ID ='f1e2d3c4-b5a6-7890-1234-567890abcdef';

> INSERT INTO stockdiary (id, datenew, reason, location, product, attributesetinstance_id, units, price, appuser, supplier, supplierdoc ) VALUES ('g1h2i3j4-k5l6-m7n8-o9p0-q1r2s3t4u5v6', NOW(), 1, '0', 'f1e2d3c4-b5a6-7890-1234-567890abcdef', NULL, 100.00, 3000, 'admin', NULL, NULL);

> INSERT IGNORE INTO stockcurrent (PRODUCT, LOCATION, UNITS) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', '0', 100.00);

> INSERT IGNORE INTO STOCKLEVEL (ID, PRODUCT, LOCATION, STOCKSECURITY, STOCKMAX) VALUES ('h9i8j7k6-l5m4-n3o2-p1q0-r9s8t7u6v5w4', 'f1e2d3c4-b5a6-7890-1234-567890abcdef',  '0', 10.00, 500.00);

#QUERY STOCK MANAGEMENT
> SELECT products.ID, products.REFERENCE, products.CODE, products.CODETYPE, products.NAME, products.PRICEBUY, products.PRICESELL, products.CATEGORY, products.TAXCAT, products.ATTRIBUTESET_ID, products.STOCKCOST, products.STOCKVOLUME, products.IMAGE, products.ISCOM, products.ISSCALE, products.ISCONSTANT, products.PRINTKB, products.SENDSTATUS, products.ISSERVICE, products.ATTRIBUTES, products.DISPLAY, products.ISVPRICE, products.ISVERPATRIB, products.TEXTTIP, products.WARRANTY, products.STOCKUNITS, products.PRINTTO, products.SUPPLIER, products.UOM, products.MEMODATE FROM categories INNER JOIN products ON (products.CATEGORY = categories.ID) WHERE products.ISCONSTANT = TRUE ORDER BY categories.NAME, products.NAME

> SELECT ID, NAME, IMAGE, TEXTTIP, CATSHOWNAME, CATORDER FROM categories WHERE PARENTID = ? ORDER BY CATORDER, NAME

> SELECT P.ID, P.REFERENCE, P.CODE, P.CODETYPE, P.NAME, P.PRICEBUY, P.PRICESELL, P.CATEGORY, P.TAXCAT, P.ATTRIBUTESET_ID, P.STOCKCOST, P.STOCKVOLUME, P.IMAGE, P.ISCOM, P.ISSCALE, P.ISCONSTANT, P.PRINTKB, P.SENDSTATUS, P.ISSERVICE, P.ATTRIBUTES, P.DISPLAY, P.ISVPRICE, P.ISVERPATRIB, P.TEXTTIP, P.WARRANTY, P.STOCKUNITS, P.PRINTTO, P.SUPPLIER, P.UOM, P.MEMODATE FROM products P, products_cat O WHERE P.ID = O.PRODUCT AND P.CATEGORY = 'c4d5e6f7-a8b9-c0d1-e2f3-a4b5c6d7e8f9' ORDER BY O.CATORDER, P.NAME


### Properties
user.language=es
user.country=CO

./kriolos-opos-app/src/main/resources/pos_messages.properties
                                      pos_messages_es.properties
rm -fr ./kriolos-opos-app/target/

./app/classes/com/unicenta/reports/inventory_messages_es.properties x
./app/classes/pos_messages_es.properties x
./app/locales/pos_messages_es.properties x
./app/reports/com/unicenta/reports/inventory_messages_es.properties



###WINDOWS ###
$ docker run --detach --name unicentaopos -p 3306:3306 --env MARIADB_ROOT_PASSWORD=root -e MARIADB_DATABASE=unicentaopos -e MARIADB_USER=unicenta -e MARIADB_PASSWORD=unicenta mariadb:latest #OK

$ GRANT ALL PRIVILEGES ON unicenta.* TO 'unicenta'@'%';
$ FLUSH PRIVILEGES;
$ docker exec -it unicentaopos mariadb -u unicenta -punicenta #OK

$docker exec -i unicentaopos mariadb -u unicenta -punicenta unicentaopos < select_tables.sql > local_file_name3.csv #Execute a sql script on a Docker container.
$docker exec -i unicentaopos mariadb -u unicenta -punicenta unicentaopos -e "SELECT ;" > local_file_name2.csv #execute a query

SHOW CREATE TABLE products;

docker exec -i unicentaopos mariadb-dump -u unicenta -punicenta --no-data unicentaopos
$docker exec -i mariadb-dump -u unicenta -punicenta --no-data unicentaopos > output_dbdump_file.sql #e
   
#BACKUP   
> docker exec -i unicentaopos mariadb-dump -u unicenta -punicenta unicentaopos > output_dbdump_file_10-12-2025.sql #OK Full backup

#Restore the data from your backup file:
mariadb -u root -p12345678 unicentaopos < output_dbdump_file_10-12-2025.sql


#LOAD DATA FROM SCRIPT
> docker exec -i unicentaopos mariadb -u unicenta -punicenta < ARTICULOS_final_sql_inserts.sql
> docker exec -i unicentaopos mariadb -u unicenta -punicenta < product_cat_inserts.sql

### CREATE DATABASE USER
CREATE DATABASE unicentaopos;
CREATE USER 'unicenta'@'localhost' IDENTIFIED BY 'unicenta';
GRANT ALL PRIVILEGES ON unicenta.* TO 'unicenta'@'localhost'; #check
FLUSH PRIVILEGES;
EXIT;


#printer: 




###

---
4.6
/opt
$ docker run --name unicenta4 -p 3307:3307 -d -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=unicenta4 -e MYSQL_USER=unicenta4 -e MYSQL_PASSWORD=unicenta4 mysql:5.7
$ docker exec -it unicenta4 mysql -u unicenta4 -p unicenta4
$ ./start.sh

/home/user/kriolos-opos.properties

Administrator
 -> Maintenance -> Tax Categories: Name: Standard VAT, Rate: 19.00, Rate Order: 1
 -> Maintenance -> Taxes 
 -> Stock -> Categories - > new: Beverages.
 -> Stock -> Products: Barcode/Reference: 049000000421, Name: Coca-Cola (355ml Can), Price Sell: 2500, Price Buy: 1500
 -> Stock -> 

Stock  and then select "Products".
 + button




ng new unicenta-web-ui --no-standalone --routing --ssr=false 

ng serve --open





docker run --name unicentaMDB -p 3306:3306 -d -e MARIADB_ROOT_PASSWORD=root -e MARIADB_DATABASE=unicenta -e MARIADB_USER=unicenta -e MARIADB_PASSWORD=unicenta mariadb/server:10.5






#CREATE PRODUCT
INSERT IGNORE INTO taxcategories (ID, NAME) VALUES ('04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', 'Standard Sales Tax');
INSERT IGNORE INTO taxes (ID, NAME, CATEGORY, RATE) VALUES ('7b1c3a8e-2e6b-4e7f-8c9d-d1d2e3f4a5b6', 'IVA 5%', '04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', 0.05);
INSERT IGNORE INTO categories (ID, NAME) VALUES ('c4d5e6f7-a8b9-c0d1-e2f3-a4b5c6d7e8f9', 'Groceries');
INSERT INTO products (ID, REFERENCE, CODE, NAME, PRICESELL, PRICEBUY, CATEGORY, TAXCAT, IMAGE, ISCOM, ISSCALE, DISPLAY, ATTRIBUTES, stockcost, stockvolume, stockunits, isvprice, codetype ) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', 'RICE001', '8712345678905', 'Rice - 1kg Bag', 4000, 3000, 'c4d5e6f7-a8b9-c0d1-e2f3-a4b5c6d7e8f9', '04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', NULL, FALSE, FALSE, '1kg Rice', NULL, 0, 0, 0, 0, 'EAN-13' );
INSERT INTO products_cat (product, catorder) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', 10) ON DUPLICATE KEY UPDATE catorder = VALUES(catorder);
INSERT INTO stockdiary (id, datenew, reason, location, product, attributesetinstance_id, units, price, appuser, supplier, supplierdoc ) VALUES ('g1h2i3j4-k5l6-m7n8-o9p0-q1r2s3t4u5v6', NOW(), 1, '0', 'f1e2d3c4-b5a6-7890-1234-567890abcdef', NULL, 100.00, 3000, 'admin', NULL, NULL);
INSERT IGNORE INTO stockcurrent (PRODUCT, LOCATION, UNITS) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', '0', 100.00);
INSERT IGNORE INTO STOCKLEVEL (ID, PRODUCT, LOCATION, STOCKSECURITY, STOCKMAX) VALUES ('h9i8j7k6-l5m4-n3o2-p1q0-r9s8t7u6v5w4', 'f1e2d3c4-b5a6-7890-1234-567890abcdef',  '0', 10.00, 500.00);


***
use the next sql scripts to generate a REST API to load an individual record to create a product another for the categories, taxes and so on, review carefully which end points are required for that use Spring Boot, the structure of the project must follow the domain driven design approach use as reference the  Eric Evans''s book Domain-Driven Design: Tackling Complexity in the Heart of Software:

INSERT IGNORE INTO taxcategories (ID, NAME) VALUES ('04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', 'Standard Sales Tax');
INSERT IGNORE INTO taxes (ID, NAME, CATEGORY, RATE) VALUES ('7b1c3a8e-2e6b-4e7f-8c9d-d1d2e3f4a5b6', 'IVA 5%', '04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', 0.05);
INSERT IGNORE INTO categories (ID, NAME) VALUES ('c4d5e6f7-a8b9-c0d1-e2f3-a4b5c6d7e8f9', 'Groceries');
INSERT INTO products (ID, REFERENCE, CODE, NAME, PRICESELL, PRICEBUY, CATEGORY, TAXCAT, IMAGE, ISCOM, ISSCALE, DISPLAY, ATTRIBUTES, stockcost, stockvolume, stockunits, isvprice, codetype ) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', 'RICE001', '8712345678905', 'Rice - 1kg Bag', 4000, 3000, 'c4d5e6f7-a8b9-c0d1-e2f3-a4b5c6d7e8f9', '04928060-63b7-4a0d-9b0d-b8d2d2c3e1e2', NULL, FALSE, FALSE, '1kg Rice', NULL, 0, 0, 0, 0, 'EAN-13' );
INSERT INTO products_cat (product, catorder) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', 10) ON DUPLICATE KEY UPDATE catorder = VALUES(catorder);
INSERT INTO stockdiary (id, datenew, reason, location, product, attributesetinstance_id, units, price, appuser, supplier, supplierdoc ) VALUES ('g1h2i3j4-k5l6-m7n8-o9p0-q1r2s3t4u5v6', NOW(), 1, '0', 'f1e2d3c4-b5a6-7890-1234-567890abcdef', NULL, 100.00, 3000, 'admin', NULL, NULL);
INSERT IGNORE INTO stockcurrent (PRODUCT, LOCATION, UNITS) VALUES ('f1e2d3c4-b5a6-7890-1234-567890abcdef', '0', 100.00);
INSERT IGNORE INTO STOCKLEVEL (ID, PRODUCT, LOCATION, STOCKSECURITY, STOCKMAX) VALUES ('h9i8j7k6-l5m4-n3o2-p1q0-r9s8t7u6v5w4', 'f1e2d3c4-b5a6-7890-1234-567890abcdef',  '0', 10.00, 500.00);


SELECT id, reference, code, name, pricesell, pricebuy, price_Sell,category_id, tax_category_id, category, currency FROM products where id = '00000000-prod-0000-0000-000000000109';
select * from categories where id = '00000000-cat0-0000-0000-000000000008';

#Select all products but image
SELECT id, reference, code, codetype, name, pricebuy, pricesell, category, taxcat, attributeset_id, stockcost, stockvolume, iscom,   isscale, isconstant, printkb, sendstatus, isservice, attributes, display, isvprice, isverpatrib, texttip, warranty, stockunits,     printto, supplier, uom, memodate, value, price_buy, currency_buy, price_sell, currency_sell, category_id, currency, tax_category_id
FROM products;

-> EMPTY FIELDS: iscom | isscale | isconstant | printkb | sendstatus | isservice | isvprice | value | category_id | currency | tax_category_id |
-> NULL FIELDS: attributeset_id | attributes | texttip | supplier | price_buy | currency_buy | price_sell | currency_sell |

#SELECT with no null and not empty
SELECT id, category, reference, code, codetype, name, pricebuy, pricesell, taxcat,  -stockcost, -stockvolume, display, -isverpatrib, -warranty, -stockunits, -printto, -uom, -memodate FROM products;


##GMN
# 1. Create a new Angular project (using standalone components)
ng new unicenta-manager-ui --standalone --style=css

# 2. Navigate into the new project directory
cd unicenta-manager-ui

# 3. Generate the centralized API service
ng generate service services/api

# 4. Generate the components for each management tab
ng generate component components/category-manager
ng generate component components/tax-manager
ng generate component components/product-manager

#Kimi
// Similar DTOs for Category, TaxCategory, Tax (omitted for brevity)
// *CategoryJpaEntity: ProductJpaEntity, TaxCategoryJpaEntity, TaxJpaEntity implemented the same way.
// *JpaProductRepository : // Same for Category, TaxCategory, Tax.

CategoryRepository



0.  Test Drive
─────────────────────────────


##POST
#KM
$ curl http://localhost:8080/api/v1/products/00000000-prod-0000-0000-000000000109 #ERR


SELECT p.id, p.reference, p.code, p.name, p.pricesell, p.pricebuy, p.currency, p.category, c.name AS category_name, p.tax_category_id FROM products p JOIN categories c ON p.category = c.id

######################
### GMN - API REST ###
######################

###PRODUCTS ###
#POST Create product
POST http://localhost:8081/api/v1/products #OK
Body:
{
"reference": "RICE002",
"code": "8712345678906",
"codetype": "EAN-13",
"name": "Rice – 2 kg",
"display": "Rice x 2000gr",  
"pricesell": 10000,
"pricebuy": 8000,
"categoryId": "00000000-cat0-0000-0000-000000000001",
"taxcatId": "00000000-taxc-0000-0000-000000000003"
}
→ 201 Created with Location header.

#Get a single product
curl -X GET http://localhost:8081/api/v1/products/00000000-prod-0000-0000-000000000109 #OK

#To get all products:
curl -X GET http://localhost:8081/api/v1/products #OK


#search a product by its name
curl -X GET http://localhost:8081/api/v1/products/search?name=Arroz%20Diana%20Bolsa%201000gramos

#
curl -X GET http://localhost:8081/api/v1/products/getNextProductReference

#PUT, Modify product
http://localhost:8081/api/v1/products/00000000-prod-0000-0000-000000000109
   {
 →  "reference": "REF-0109",
 →  "code": "7709998880025",
    "codetype": "EAN-13",
    "name": "Rice – 122 kg",
    "display": "Rice x 12000gr",  
    "pricesell": 10000,
    "pricebuy": 8000,
    "categoryId": "00000000-cat0-0000-0000-000000000001",
    "taxcatId": "00000000-taxc-0000-0000-000000000003"
   } 

#Pagination
curl -X GET "http://localhost:8081/api/v1/products"
curl -X GET "http://localhost:8081/api/v1/products?size=5"
curl -X GET "http://localhost:8081/api/v1/products?page=1&size=5"
#Pagination with Sorting
curl -X GET "http://localhost:8081/api/v1/products?sort=name,asc"
curl -X GET "http://localhost:8081/api/v1/products?sort=pricesell,desc"
#Combined Example
curl -X GET "http://localhost:8081/api/v1/products?page=2&size=10&sort=name,desc"


### CATEGORIES ###
#To get all categories
curl -X GET http://localhost:8081/api/v1/categories #OK 
#POST create a category
http://localhost:8081/api/v1/categories
{ "name": "Abarrotes"}

###TAX CATEGORIES 
http://localhost:8081/api/v1/tax-categories


### TAXES ###
#To get all taxes
curl -X GET http://localhost:8081/api/v1/taxes


###suppliers
curl -X GET http://localhost:8081/api/v1/suppliers




docker pull oscarfonts/h2
docker run -d -p 8082:81 -p 9092:1521 \
    -e H2_OPTIONS="-web -webAllowOthers -tcp -tcpAllowOthers -ifNotExists" \
    --name h2-database oscarfonts/h2
jdbc:h2:tcp://localhost:1521/test
 
 
 
 
 
###ToDo ###
-Create Product - Done
-Get all the the categories - Done
-Get all the Taxes - Done
-Test ith MySQL DB - Done
to create tax  fectch tax categories
-SPRING REST DOCS - check
-*IP Backend
-load image product
-review Taxes percentages
-logs debug
-CrossOrigin

-Etiquetas de productos
-Suppliers - current debt
-Caused by: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry '7707668553314' Err creando producto
*Display on products
-product Pagination - Done
-Generate image for products using ia
-create product with code bars - Done
*How is calculate the sale price, beneficio bruto, margen.
#UI
-Error when click to close the autocomplete field
-Loading Skeleton Cards

cannot find symbol, symbol:   method getCategoryById(String) location: class CategoryService.
cannot find symbol  symbol:   method getTaxCategoryById(String) location: class TaxCategoryService
cannot find symbol  symbol:   method getTaxById(String) location: class TaxService
fix the error and write unit and integration test for each new endpoint.
For better UX, consider debouncing search while scrolling.
-Reload a products list
-*image product
*Product Referencia
*voice recognition
*Reference field
**Add PVP
-update the list wheh the product is updated
-if you want numbers to use Spanish formatting (e.g., 1.234,56 instead of 1,234.56), 
*Handle feed back when try to create a duplicate product.
-enabled/disabled products
***Visualización de niveles de stock por ubicación, add more locations.
-For ecommerce, a product can be augmented by its description and reviews.

##########
### AI ###
##########
*Search products by voice



###################################
###### MANEJO DE DASHBOARDS #######
###################################
-Sales by month
-Sales by day 


*The idea behind the maxdebt field in the context of a customer is to limit the amount of money the customer owes the business. This is a risk management tool for the business.
-in the context of a supplier, the idea behind a "credit limit" field is the exact opposite. It's not about the supplier's debt to the business; it's about the business's debt to the supplier.
3. Prevent Order Blocks: This warning serves as an internal control. It tells you or your purchasing manager that you need to make a payment to the supplier before placing another order. This proactive management helps prevent a situation where the supplier refuses to fulfill a critical order because you have exceeded your credit limit with them.
-is a tool for managing accounts payable->Es una herramienta para gestionar cuentas por pagar.

-Avoid disputes with suppliers over outstanding balances.
-Ensure a continuous supply chain by preventing your credit from being blocked.

#DONE




#######################
*Gross profit is the financial gain a company makes after deducting the direct costs associated with producing or delivering its goods and services from its total revenue. 
  -Gross Profit=Total Revenue−Cost of Goods Sold (COGS)
  -Gross Profit=Selling Price−Cost of Goods Sold
  -Gross Profit=$10000−$8000=$2000
  -Gross Profit Margin Percentage=(Gross Profit/Total RevenueGross Profit​)×100%
  -Gross Profit Margin Percentage=($10000/$2000​)×100%=0.2×100%=20%





N+1 query problem
global navigation




SELECT 
    t.TABLE_NAME, 
    c.COLUMN_NAME, 
    c.COLUMN_TYPE, 
    c.IS_NULLABLE, 
    c.COLUMN_KEY, 
    c.EXTRA
FROM 
    information_schema.TABLES AS t
JOIN 
    information_schema.COLUMNS AS c 
    ON t.TABLE_SCHEMA = c.TABLE_SCHEMA AND t.TABLE_NAME = c.TABLE_NAME
WHERE 
    t.TABLE_SCHEMA = 'unicentaopos'
ORDER BY 
    t.TABLE_NAME, 
    c.ORDINAL_POSITION;




SELECT
  CONCAT(
    'SELECT ',
    (
      SELECT
        GROUP_CONCAT(COLUMN_NAME)
      FROM
        information_schema.COLUMNS
      WHERE
        TABLE_SCHEMA = T.TABLE_SCHEMA
        AND TABLE_NAME = T.TABLE_NAME
        AND COLUMN_NAME != 'image'
    ),
    ' FROM ',
    T.TABLE_SCHEMA,
    '.',
    T.TABLE_NAME,
    ';'
  )
FROM
  information_schema.TABLES AS T
WHERE
  T.TABLE_SCHEMA = 'unicentaopos';


SELECT id FROM unicentaopos.ticketsnum_payment;
SELECT id,name,content,appuser,pickupid,locked FROM unicentaopos.sharedtickets;
SELECT id,name FROM unicentaopos.taxsuppcategories;
SELECT id,name FROM unicentaopos.attribute;
SELECT id,name,apppassword,card,role,visible FROM unicentaopos.people;
SELECT id,receipt,taxid,base,amount FROM unicentaopos.taxlines;
SELECT id,name,category,custcategory,parentid,rate,ratecascade,rateorder,value FROM unicentaopos.taxes;
SELECT id,name FROM unicentaopos.floors;
SELECT id,reference,code,codetype,name,pricebuy,pricesell,category,taxcat,attributeset_id,stockcost,stockvolume,iscom,isscale,isconstant,printkb,sendstatus,isservice,attributes,display,isvprice,isverpatrib,texttip,warranty,stockunits,printto,supplier,uom,memodate,value,price_buy,currency_buy,price_sell,currency_sell,category_id,currency,tax_category_id,now FROM unicentaopos.products;
SELECT id FROM unicentaopos.ticketsnum;
SELECT id,startshift,endshift,pplid FROM unicentaopos.shifts;
SELECT id,cif,name,address,contactcomm,contactfact,payrule,faxnumber,phonenumber,mobilenumber,email,webpage,notes FROM unicentaopos.thirdparties;
SELECT id FROM unicentaopos.pickup_number;
SELECT id,searchkey,taxid,name,maxdebt,address,address2,postal,city,region,country,firstname,lastname,email,phone,phone2,fax,notes,visible,curdate,curdebt,vatid FROM unicentaopos.suppliers;
SELECT id FROM unicentaopos.ticketsnum_refund;
SELECT id,attributeset_id,attribute_id,lineno FROM unicentaopos.attributeuse;
SELECT id,attribute_id,value FROM unicentaopos.attributevalue;
SELECT id,location,product,stocksecurity,stockmaximum FROM unicentaopos.stocklevel;
SELECT id,name FROM unicentaopos.attributeset;
SELECT id,orderid,qty,details,attributes,notes,ticketid,ordertime,displayid,auxiliary,completetime FROM unicentaopos.orders;
SELECT id,name FROM unicentaopos.uom;
SELECT id,customer FROM unicentaopos.reservation_customers;
SELECT id,name,address FROM unicentaopos.locations;
SELECT id,name,version,instdate FROM unicentaopos.applications;
SELECT id,voucher_number,customer,amount,status FROM unicentaopos.vouchers;
SELECT id,name,value FROM unicentaopos.taxcategories;
SELECT id,datenew,reason,location,product,attributesetinstance_id,units,price,appuser,supplier,supplierdoc FROM unicentaopos.stockdiary;
SELECT id,pplid,name,startdate,enddate,notes FROM unicentaopos.leaves;
SELECT product,catorder FROM unicentaopos.products_cat;
SELECT id,rownumber,csverror,reference,code,name,pricebuy,pricesell,previousbuy,previoussell,category,tax,searchkey FROM unicentaopos.csvimport;
SELECT id,product,product2 FROM unicentaopos.products_com;
SELECT vesselname,size,days,power FROM unicentaopos.moorers;
SELECT id,attributesetinstance_id,attribute_id,value FROM unicentaopos.attributeinstance;
SELECT id,name,parentid,texttip,catshowname,catorder,value FROM unicentaopos.categories;
SELECT location,product,attributesetinstance_id,units FROM unicentaopos.stockcurrent;
SELECT id,attributeset_id,description FROM unicentaopos.attributesetinstance;
SELECT id,created,datenew,title,chairs,isdone,description FROM unicentaopos.reservations;
SELECT id,name,visible,notes FROM unicentaopos.breaks;
SELECT id,name FROM unicentaopos.taxcustcategories;
SELECT opendate,name,ticketid FROM unicentaopos.draweropened;
SELECT id,name,seats,x,y,floor,customer,waiter,ticketid,tablemoved,width,height,guests,occupied FROM unicentaopos.places;
SELECT id,product,product_bundle,quantity FROM unicentaopos.products_bundle;
SELECT id,shiftid,breakid,starttime,endtime FROM unicentaopos.shift_breaks;
SELECT id,searchkey,taxid,name,taxcategory,card,maxdebt,address,address2,postal,city,region,country,firstname,lastname,email,phone,phone2,fax,notes,visible,curdate,curdebt,isvip,discount,memodate FROM unicentaopos.customers;
SELECT id,receipt,payment,total,tip,transid,isprocessed,returnmsg,notes,tendered,cardname,voucher FROM unicentaopos.payments;
SELECT money,host,hostsequence,datestart,dateend,nosales FROM unicentaopos.closedcash;
SELECT id,tickettype,ticketid,person,customer,status FROM unicentaopos.tickets;
SELECT removeddate,name,ticketid,productid,productname,units FROM unicentaopos.lineremoved;


-SELECT id,money,datenew,attributes,person FROM unicentaopos.receipts;
-SELECT ticket,line,product,attributesetinstance_id,units,price,taxid,attributes FROM unicentaopos.ticketlines;
-SELECT id,name,restype,content,version FROM unicentaopos.resources;
-SELECT id,name,permissions FROM unicentaopos.roles;

#
SHOW CREATE TABLE stockcurrent;






#TX for supplier
 SELECT id,datenew,reason,location,product,attributesetinstance_id,units,price,appuser,supplier,supplierdoc FROM unicentaopos.stockdiary;
 
a7b20cc1-f1a8-4eb7-8569-236d2271a69b | 2025-08-10 19:30:00 |      1 | 0        | 00000000-prod-0000-0000-000000000001 | NULL                    |    10 |  80000 | Administrator | dac807e2-6de5-4e67-9eb5-32ce51f19b65 |             | 


SELECT id,datenew,reason,location,product,attributesetinstance_id,units,price,appuser,supplier,supplierdoc FROM unicentaopos.stockdiary WHERE supplier = 'dac807e2-6de5-4e67-9eb5-32ce51f19b65';

#Code Scanner
Tips: 
1.For production use, add these to your index.html:
  <!-- Enable full screen camera on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <!-- Disable zoom on mobile -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  
2.To handle different barcode formats (like QR codes), modify the scanner initialization:
// In setupScanner():
this.scanner = new BrowserMultiFormatReader({
  hints: [
    BarcodeFormat.CODE_128,
    BarcodeFormat.EAN_13,
    BarcodeFormat.QR_CODE
  ]
});  
  
3. For enterprise use cases, add:
  -Vibration feedback on scan success (navigator.vibrate(200))
  -Sound confirmation
  -Automatic form submission after scan
  
  
  Even with the code fix, you MUST do these manually on your device: 

    Open Firefox Settings: 
        Tap ≡ (Menu) → Settings → Site Permissions → Camera
         

    Find Your Site: 
        Look for your development URL (e.g., http://localhost:4200)
        If not listed, visit your site first then check permissions
         
     

    Set to "Allow" (not "Ask to Allow"):
  
  
  Prod:
  <!-- En index.html -->
<meta http-equiv="Content-Security-Policy" 
      content="upgrade-insecure-requests; 
               default-src 'self'; 
               media-src 'self' https:;">
  Esto prevendrá problemas de seguridad al acceder a la cámara en entornos HTTPS.
  
  
###PRINTER
Management -> Printer.Ticket.Logo.jpg 
./com/unicenta/pos/templates/Printer.TicketPreview.xml
  

com.unicenta.pos.forms.AppConfig  
com.unicenta.pos.forms.JRootApp  
com.unicenta.pos.payment.JPaymentCashPos  
  
#Color images
change the color to RGB: 144, 238, 144 background white  
change the color to RGB: 144, 238, 144 background white

################################
######### CERTIFICATES #########
################################
#Backend Windows
> Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
>choco install mkcert
>Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
>scoop bucket add extras
>scoop install mkcert
>mkcert -install
>mkcert localhost
 localhost.pem (certificate)
 localhost-key.pem (private key)
# Generate certificate for multiple domains
> mkcert example.test localhost 127.0.0.1 ::1 
# Generate wildcard certificate
> mkcert "*.example.test" example.test
# Generate certificate for specific IP
>mkcert 192.168.10.5
   192.168.10.5-key.pem
   192.168.10.5.pem
>choco install openssl
#OK copy to  src\main\resources
>openssl pkcs12 -export -out keystore_192.p12 -inkey 192.168.10.5-key.pem -in 192.168.10.5.pem -name springboot
# Convert PKCS12 to JKS (optional)
keytool -importkeystore -srckeystore keystore_192.p12 -srcstoretype pkcs12 -destkeystore keystore.jks -deststoretype JKS

#Linux Client
> 

##################
#Solution 2: Deploy Your CA Certificate to All Machines

Step 1: Create Your Certificate Authority (CA)
# Create CA private key
> openssl genrsa -out my-ca.key 2048

# Create CA certificate (valid for 10 years)
openssl req -x509 -new -key my-ca.key -out my-ca.crt -days 3650 -subj "/CN=UniposWeb Local CA"
openssl req -x509 -new -key my-ca.key -out my-ca.crt -days 3650 -subj "//CN=UniposWeb Local CA" #Git bash

Step 2: Create Server Certificate with Proper SANs
vim server.conf

Step 3: Generate Server Key and Certificate Signing Request (CSR)
# Create server private key
openssl genrsa -out uniposweb.key 2048

# Create CSR using the config file
openssl req -new -key uniposweb.key -out uniposweb.csr -config server.conf

Step 4: Sign the Server Certificate with Your CA
vim ca.conf

# Create empty database and serial files
echo "01" > serial.txt
touch index.txt

mkdir newcerts

Sign the certificate:
# Sign the CSR with your CA
openssl ca -config ca.conf -in uniposweb.csr -out uniposweb.crt -extensions v3_leaf -notext -batch

Step 5: Create Complete Certificate Chain File
# Combine server certificate and CA certificate
cat uniposweb.crt my-ca.crt > uniposweb-fullchain.crt

Step 6: Create PKCS12 Keystore for Tomcat
# Create PKCS12 file with full chain
openssl pkcs12 -export -out keystore.p12 -inkey uniposweb.key -in uniposweb-fullchain.crt -name tomcat -passout pass:12345678

Step 7: Configure Tomcat
keystore.p12

#Install on Windows:
certmgr.msc -> my-ca.crt

##Angular
uniposweb.crt (server certificate)
uniposweb.key (private key)
my-ca.crt (CA certificate - for client trust)


Step 2: Create a certificate chain file for Angular
# Combine server cert and CA cert for complete chain
cat uniposweb.crt my-ca.crt > uniposweb-chain.crt

ng serve --ssl --ssl-cert uniposweb-chain.crt --ssl-key uniposweb.key --host uniposweb --port 4200


### ### deploying an Angular app in production ###




http://192.168.0.1/
 modem ZTE F660,
 Model: ZXHN F660
 Product: GPON ONT
 SN: ZTEGC0526810
 WIFIetb
 80CD2716
 
IPv4: 200.119.48.4 


check open ports
https://www.yougetsignal.com/tools/open-ports/


####### SALES ###########
select * from closedcash;
select * from payments;
select * from tickets;

pos_messages_es.properties:button.closecash=Cerrar caja >>> com/unicenta/pos/panels/JPanelCloseMoney.clas

#DataLogicSystem
centralizes database operations for core system functions like user management, permissions, cash sessions, resource files, audit logging, and data import/export within the unicenta POS system.

#Report
pos_messages_es.properties:Menu.Closing=Cierres de caja

#Cierres de caja
./com/unicenta/reports/sales_closedproducts.jrxml

./com/unicenta/reports/sales_closedproducts_1.bs


pos_messages.properties:Menu.Closing=Cash Closed

label.title.cashclosed

*File: sales_closedpos_1.jrxml
  SELECT
  closedcash.HOST,
  closedcash.HOSTSEQUENCE,
  closedcash.MONEY,
  closedcash.DATESTART,
  closedcash.DATEEND,
  payments.PAYMENT,
  SUM(payments.TOTAL) AS TOTAL
  FROM closedcash, payments, receipts
  WHERE closedcash.MONEY = receipts.MONEY AND payments.RECEIPT = receipts.ID
  GROUP BY closedcash.HOST, closedcash.HOSTSEQUENCE, closedcash.MONEY, closedcash.DATESTART, closedcash.DATEEND, payments.PAYMENT
  ORDER BY closedcash.HOST, closedcash.HOSTSEQUENCE



closedcash
#sales_closedpos.jrxml #OK
#changed the title:
<textFieldExpression><![CDATA[$R{label.title.cashclosed}]]></textFieldExpression> -> 
                          <textFieldExpression><![CDATA["Cierres de caja"]]></textFieldExpression>

./com/unicenta/pos/templates/Menu.Root.txt
 🔹Which terminals (hosts) were active?
 🔹What were the start and end times for each cash drawer session? 
 🔹What was the total amount collected per terminal?
 🔹What was the total amount collected per session?
 🔹How much was collected via each payment method (Cash, Card, etc.) for each session?
 🔹What is the overall total collected across all terminals and sessions within the specified period?
 
 
✅✅✅ File with the correct QUERY: sales_closedpos.bs
  
#.bs
SELECT closedcash.HOST, closedcash.HOSTSEQUENCE, closedcash.MONEY, 
                    closedcash.DATESTART, closedcash.DATEEND, payments.PAYMENT, 
                    SUM(payments.TOTAL) AS TOTAL 
                    FROM closedcash, payments, receipts 
                    WHERE closedcash.MONEY = receipts.MONEY AND payments.RECEIPT = receipts.ID AND ?(QBF_FILTER) 
                    GROUP BY closedcash.HOST, closedcash.HOSTSEQUENCE, closedcash.MONEY, closedcash.DATESTART, closedcash.DATEEND, payments.PAYMENT 
                    ORDER BY closedcash.HOST, closedcash.HOSTSEQUENCE
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 





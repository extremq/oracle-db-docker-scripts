host echo Building Oracle tables. Please wait.
--set termout off
ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN' NLS_TERRITORY= 'AMERICA' NLS_CURRENCY= '$' NLS_ISO_CURRENCY= 'AMERICA' NLS_NUMERIC_CHARACTERS= '.,' NLS_CALENDAR= 'GREGORIAN' NLS_DATE_FORMAT= 'DD-MON-RR' NLS_DATE_LANGUAGE= 'AMERICAN' NLS_SORT= 'BINARY';

CREATE TABLE regions(
	region_id   NUMBER(1),
	region_name VARCHAR2(25) CONSTRAINT regions_region_name_nn NOT NULL,
CONSTRAINT regions_region_id_pk PRIMARY KEY (region_id));

INSERT INTO regions VALUES (1,'Europe');
INSERT INTO regions VALUES (2,'America');
INSERT INTO regions VALUES (3,'Asia');
INSERT INTO regions VALUES (4,'Middle East and Africa');


CREATE TABLE countries (
	country_id   CHAR(2),
	country_name VARCHAR2(40) CONSTRAINT countries_country_name_nn NOT NULL,
	region_id    NUMBER(1),
CONSTRAINT countries_country_id_pk PRIMARY KEY (country_id),
CONSTRAINT countries_region_id_fk FOREIGN KEY (region_id) REFERENCES regions (region_id));

INSERT INTO countries VALUES ('CA','Canada',2);
INSERT INTO countries VALUES ('DE','Germany',1);
INSERT INTO countries VALUES ('UK','United Kingdom',1);
INSERT INTO countries VALUES ('US','United States of America',2);


CREATE TABLE locations(
	location_id    NUMBER(4),
	street_address VARCHAR2(40),
	postal_code    VARCHAR2(12),
	city           VARCHAR2(30) CONSTRAINT locations_city_nn NOT NULL,
	state_province VARCHAR2(25),
	country_id     CHAR(2),
CONSTRAINT locations_location_id_pk PRIMARY KEY (location_id),
CONSTRAINT locations_country_id_fk FOREIGN KEY (country_id) REFERENCES countries (country_id));

INSERT INTO locations VALUES (1400,'2014 Jabberwockz Rd'                     ,'26192'     ,'Southlake'          ,'Texas'     ,'US');
INSERT INTO locations VALUES (1500,'2011 Interiors Blvd'                     ,'99236'     ,'South San Francisco','California','US');
INSERT INTO locations VALUES (1700,'2004 Charade Rd'                         ,'99189'     ,'Washington'         ,'Washington','US');
INSERT INTO locations VALUES (1800,'460 Bloor St. W.'                        ,'ON M5S 1X8','Toronto'            ,'Ontario'   ,'CA');
INSERT INTO locations VALUES (2500,'Magdalen Centre, The Oxford Science Park','OX9 9XB'   ,'Oxford'             ,'Oxford'    ,'UK');


CREATE TABLE departments (
	department_id   NUMBER(4),
	department_name VARCHAR2(30) CONSTRAINT departments_department_name_nn NOT NULL,
	manager_id      NUMBER(6),
	location_id     NUMBER(4),
CONSTRAINT departments_department_id_pk PRIMARY KEY (department_id),
CONSTRAINT departments_location_id_fk FOREIGN KEY (location_id) REFERENCES locations (location_id));

INSERT INTO departments VALUES (10,'Administration'	,200	,1700);
INSERT INTO departments VALUES (20,'Marketing'		,201	,1800);
INSERT INTO departments VALUES (50,'Shipping'		,124	,1500);
INSERT INTO departments VALUES (60,'IT'			,103	,1400);
INSERT INTO departments VALUES (80,'Sales'		,149	,2500);
INSERT INTO departments VALUES (90,'Executive'		,100	,1700);
INSERT INTO departments VALUES (110,'Accounting'	,205	,1700);
INSERT INTO departments VALUES (190,'Contracting'	,NULL	,1700);


CREATE TABLE jobs (
	job_id     VARCHAR2(10),
	job_title  VARCHAR2(35) CONSTRAINT jobs_job_title_nn NOT NULL,
	min_salary NUMBER(6),
	max_salary NUMBER(6),
CONSTRAINT jobs_job_id_pk PRIMARY KEY (job_id),
CONSTRAINT min_salary_max_salary_ck CHECK (min_salary < max_salary));

INSERT INTO jobs VALUES ('AD_PRES'   ,'President'                    ,20000,40000);
INSERT INTO jobs VALUES ('AD_VP'     ,'Administration Vice President',15000,30000);
INSERT INTO jobs VALUES ('AD_ASST'   ,'Administartion Assistant'     , 3000, 6000);
INSERT INTO jobs VALUES ('AC_MGR'    ,'Accounting Manager'           , 8200,16000);
INSERT INTO jobs VALUES ('AC_ACCOUNT','Public Accountant'            , 4200, 9000);
INSERT INTO jobs VALUES ('SA_MAN'    ,'Sales Manager'                ,10000,20000);
INSERT INTO jobs VALUES ('SA_REP'    ,'Sales Represenatative'        , 6000,12000);
INSERT INTO jobs VALUES ('ST_MAN'    ,'Stock Manager'                , 5500, 8500);
INSERT INTO jobs VALUES ('ST_CLERK'  ,'Stock Clerk'                  , 2000, 5000);
INSERT INTO jobs VALUES ('IT_PROG'   ,'Programmer'                   , 4000,10000);
INSERT INTO jobs VALUES ('MK_MAN'    ,'Marketing Manager'            , 9000,15000);
INSERT INTO jobs VALUES ('MK_REP'    ,'Marketing Representative'     , 4000, 9000);


CREATE TABLE job_grades(
	grade_level VARCHAR2(3) CONSTRAINT job_grades_grade_level_nn NOT NULL,
	lowest_sal  NUMBER(5) 	CONSTRAINT job_grades_lowest_sal_nn NOT NULL,
	highest_sal NUMBER(5) 	CONSTRAINT job_grades_highest_sal_nn NOT NULL,
CONSTRAINT job_grades_lowest_sal_highest_sal_ck CHECK (lowest_sal < highest_sal)
);

INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000, 5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D',10000,14999);
INSERT INTO job_grades VALUES ('E',15000,24999);
INSERT INTO job_grades VALUES ('F',25000,40000);


CREATE TABLE employees (
	employee_id    NUMBER(6),
	first_name     VARCHAR2(20),
	last_name      VARCHAR2(25) 	CONSTRAINT employees_last_name_nn NOT NULL,
	email          VARCHAR2(25) 	CONSTRAINT employees_email_nn NOT NULL,
	phone_number   VARCHAR2(10),
	hire_date      DATE 		CONSTRAINT employees_hire_date_nn NOT NULL,
	job_id         VARCHAR2(10) 	CONSTRAINT employees_job_id_nn NOT NULL,
	salary         NUMBER(8,2),
	commission_pct NUMBER(2,2),
	manager_id     NUMBER(6) 	CONSTRAINT employees_manager_id_fk REFERENCES employees (employee_id),
	department_id  NUMBER(4),
CONSTRAINT employees_department_id_fk FOREIGN KEY (department_id) REFERENCES departments (department_id),
CONSTRAINT employees_job_id_fk FOREIGN KEY (job_id) REFERENCES jobs (job_id),
CONSTRAINT employees_employee_id_pk PRIMARY KEY (employee_id),
CONSTRAINT employees_last_name_uk UNIQUE(last_name));

INSERT INTO employees VALUES (100,'Steven'   ,'King'     ,' ','0722123401','17-JUN-1997','AD_PRES'   ,24000,NULL,NULL,  90);
INSERT INTO employees VALUES (101,'Neena'    ,'Kochhar'  ,' ','0722123402','21-SEP-1989','AD_VP'     ,17000,NULL, 100,  90);
INSERT INTO employees VALUES (102,'Lex'      ,'De Haan'  ,' ','0722123403','13-JAN-1993','AD_VP'     ,17000,NULL, 100,  90);
INSERT INTO employees VALUES (103,'Alexander','Hunold'   ,' ','0722123404','03-JAN-1990','IT_PROG'   , 9000,NULL, 102,  60);
INSERT INTO employees VALUES (104,'Bruce'    ,'Ernst'    ,' ','0722123405','21-MAY-1991','IT_PROG'   , 6000,NULL, 103,  60);
INSERT INTO employees VALUES (107,'Diana'    ,'Lorentz'  ,' ','0722123406','07-FEB-1999','IT_PROG'   , 4200,NULL, 103,  60);
INSERT INTO employees VALUES (124,'Kevin'    ,'Mourgos'  ,' ','0722123407','16-NOV-1999','ST_MAN'    , 5800,NULL, 100,  50);
INSERT INTO employees VALUES (141,'Trenna'   ,'Rajs'     ,' ','0722123408','17-OCT-1995','ST_CLERK'  , 3500,NULL, 124,  50);
INSERT INTO employees VALUES (142,'Curtis'   ,'Davies'   ,' ','0722123409','29-JAN-1997','ST_CLERK'  , 3100,NULL, 124,  50);
INSERT INTO employees VALUES (143,'Randall'  ,'Matos'    ,' ','0722123410','15-MAR-1998','ST_CLERK'  , 2600,NULL, 124,  50);
INSERT INTO employees VALUES (144,'Peter'    ,'Vargas'   ,' ','0722123411','09-JUL-1998','ST_CLERK'  , 2500,NULL, 124,  50);
INSERT INTO employees VALUES (149,'Eleni'    ,'Zlotkey'  ,' ','0722123412','29-JAN-2000','SA_MAN'    ,10500, 0.2, 100,  80);
INSERT INTO employees VALUES (174,'Ellen'    ,'Abel'     ,' ','0722123413','11-MAY-1996','SA_REP'    ,11000, 0.3, 149,  80);
INSERT INTO employees VALUES (176,'Jonathon' ,'Taylor'   ,' ','0722123414','24-MAR-1998','SA_REP'    , 8600, 0.2, 149,  80);
INSERT INTO employees VALUES (178,'Kimberly' ,'Grant'    ,' ','0722123415','24-MAY-1999','SA_REP'    , 7000,0.15, 149,NULL);
INSERT INTO employees VALUES (200,'Jennifer' ,'Whalen'   ,' ','0722123416','17-SEP-1987','AD_ASST'   , 4400,NULL, 101,  10);
INSERT INTO employees VALUES (201,'Michael'  ,'Hartstein',' ','0722123417','17-FEB-1996','MK_MAN'    ,13000,NULL, 100,  20);
INSERT INTO employees VALUES (202,'Pat'      ,'Fay'      ,' ','0722123418','17-AUG-1997','MK_REP'    , 6000,NULL, 201,  20);
INSERT INTO employees VALUES (205,'Shelley'  ,'Higgins'  ,' ','0722123419','07-JUN-1994','AC_MGR'    ,12000,NULL, 101, 110);
INSERT INTO employees VALUES (206,'William'  ,'Gietz'    ,' ','0722123420','07-JUN-1994','AC_ACCOUNT', 8300,NULL, 205, 110);


CREATE TABLE job_history(
	employee_id   NUMBER(6) 	CONSTRAINT job_history_employee_id_nn NOT NULL,
	start_date    DATE 	 	CONSTRAINT job_history_start_date_nn NOT NULL,
	end_date      DATE 		CONSTRAINT job_history_end_date_nn NOT NULL,
	job_id        VARCHAR2(10) 	CONSTRAINT job_history_job_id_nn NOT NULL,
	department_id NUMBER(4),
CONSTRAINT job_history_job_id_fk FOREIGN KEY (job_id) REFERENCES jobs (job_id),
CONSTRAINT job_history_department_id_fk FOREIGN KEY (department_id) REFERENCES departments (department_id));

INSERT INTO job_history VALUES (102,'13-JAN-1993','24-JUL-1998','IT_PROG'   , 60);
INSERT INTO job_history VALUES (101,'21-SEP-1989','27-OCT-1993','AC_ACCOUNT',110);
INSERT INTO job_history VALUES (101,'28-OCT-1993','15-MAR-1997','AC_MGR'    ,110);
INSERT INTO job_history VALUES (201,'17-FEB-1996','19-DEC-1999','MK_REP'    , 20);
INSERT INTO job_history VALUES (114,'24-MAR-1998','31-DEC-1999','ST_CLERK'  , 50);
INSERT INTO job_history VALUES (122,'01-JAN-1999','31-DEC-1999','ST_CLERK'  , 50);
INSERT INTO job_history VALUES (200,'17-SEP-1987','17-JUN-1993','AD_ASST'   , 90);
INSERT INTO job_history VALUES (176,'24-MAR-1998','31-DEC-1998','SA_REP'    , 80);
INSERT INTO job_history VALUES (176,'01-JAN-1999','31-DEC-1999','SA_MAN'    , 80);
INSERT INTO job_history VALUES (200,'01-JUL-1994','31-DEC-1998','AC_ACCOUNT', 90);

COMMIT;


#DB

#Back
cd /backekp/desa/ekip/ekp
. ./init_env desa
sqlplus /

#remote connect
show parameter remote_os_authent;

#connect DB Front dba dba_131
dba::1003:oracle,cssgabc,frontco
export ORACLE_SID=ukpbdco11
export ORACLE_HOME=/oracle11/OraDBHome1
/oracle11/OraDBHome1/bin/sqlplus /nolog
connect / as sysdba
Connected

#connect DB Front dba dba_136
export ORACLE_SID=ukpbdco21
export ORACLE_HOME=/oracle11/OraDBHome1
/oracle11/OraDBHome1/bin/sqlplus /nolog
connect / as sysdba
Connected

chmod 6751 /oracle11/OraDBHome1/bin/oracle #OK - ORA-12547: TNS:lost contact, http://www.dadbm.com/how-to-fix-ora-12547-tns-lost-contact-when-try-to-connect-to-oracle/


chmod 755 /oracle11/OraCRSHome1/network/admin/tnsnames.ora
chmod 755 /oracle11/OraDBHome1/network/admin/tnsnames.ora

###BACKUPs ###

#Rights
GRANT EXECUTE ON DBMS_EXPORT_EXTENSION to PUBLIC;
GRANT EXP_FULL_DATABASE to FRONT;
GRANT EXECUTE ON SYS.DBMS_DEFER_IMPORT_INTERNAL TO FRONT;
GRANT EXECUTE ON SYS.DBMS_EXPORT_EXTENSION TO FRONT;

#pr
ALTER USER FRONT quota unlimited on TS_DAT001
grant flashback on "ORDDATA"."ORDDCM_CT_PRED_OPRD" to FRONT; #failed to load/unload. http://oraniltips.blogspot.com.co/2016/04/expdp-failing-to-export-sys-objects.html 

#Backup DB Back Desarrollo - I
ORACLE_BASE=/oracle11
ORACLE_HOME=$ORACLE_BASE/OraDBHome1
ORA_NLS=$ORACLE_HOME/nls/data
export ORA_NLS
PATH=$PATH:$ORACLE_HOME/bin
export PATH ORACLE_HOME ORACLE_BASE
NLS_LANG=american_america.we8iso8859p1
export NLS_LANG
export ORACLE_SID=ukpbdco21
X $ORACLE_HOME/bin/exp USERID="'/ as sysdba'" file=/ekipbck/exp_ukpbcco11_13102017.dmp full=y compress=n grants=y consistent=y log=/ekipbck/exp_ukpbcco11_13102017.log
$ORACLE_HOME/bin/exp userid="'OPS$INGENETUDES/galene'" file=/ekipbck/exp_ukpbdco21_19102017.dmp full=y compress=n grants=y consistent=y log=/ekipbck/exp_ukpbdco21_19102017.log
#Backup DB Back Desarrollo - F

#Backup DB Back TEST - I
ORACLE_BASE=/oracle11
ORACLE_HOME=$ORACLE_BASE/OraDBHome1
ORA_NLS=$ORACLE_HOME/nls/data
export ORA_NLS
PATH=$PATH:$ORACLE_HOME/bin
export PATH ORACLE_HOME ORACLE_BASE
NLS_LANG=american_america.we8iso8859p1
export NLS_LANG
export ORACLE_SID=ukpbcco21  - ukpbpco22
X $ORACLE_HOME/bin/exp USERID="'/ as sysdba'" file=/ekipbck/exp_ukpbcco11_13102017.dmp full=y compress=n grants=y consistent=y log=/ekipbck/exp_ukpbcco11_13102017.log
$ORACLE_HOME/bin/exp userid="'OPS$INGENETUDES/galene'" file=/ekipbck/exp_ukpbdco21_03112017.dmp full=y compress=n grants=y consistent=y log=/ekipbck/exp_ukpbdco21_24102017.log

#OKOKOK Manual
$ORACLE_HOME/bin/expdp OPS$INGENETUDES/galene full=y directory=DATA_PUMP_DIR logfile=exp_ukpbcco21_16042018.log dumpfile=exp_ukpbcco21_16042018.dmp compression=ALL flashback_time=systimestamp

#consistent
$ORACLE_HOME/bin/expdp OPS$INGENETUDES/galene full=y directory=DATA_PUMP_DIR logfile=exp_ukpbpco22_30072018.log dumpfile=exp_ukpbpco22_30072018.dmp compression=ALL flashback_time=systimestamp consistent=y

#Backup DB Back TEST - I


###Backup DB FRONT - I
# LineData I
ORACLE_BASE=/oracle11
ORACLE_HOME=$ORACLE_BASE/OraDBHome1
ORA_NLS=$ORACLE_HOME/nls/data
export ORA_NLS
PATH=$PATH:$ORACLE_HOME/bin
export PATH ORACLE_HOME ORACLE_BASE
export NLS_LANG=american_america.UTF8 #denis
export NLS_LANG
export ORACLE_SID=ukpbdco11
x $ORACLE_HOME/bin/exp USERID="'/ as sysdba'" file=/ekipbck/exp_ukpbcco11_13102017.dmp full=y compress=n grants=y consistent=y log=/ekipbck/exp_ukpbcco11_13102017.log
$ORACLE_HOME/bin/exp userid=FRONT/FRONT file=/ekipbck/exp_ukpbdco11_26032018.dmp full=y compress=n grants=y consistent=y log=/ekipbck/exp_ukpbdco11_26032018.log #Ok
$ORACLE_HOME/bin/expdp FRONT/FRONT directory=DATA_PUMP_DIR logfile=exp_ukpbdco11_10022019.log dumpfile=exp_ukpbdco11_10022019.dmp full=y compression=ALL flashback_time=systimestamp consistent=y #OK

#Mourad
$ORACLE_HOME/bin/exp  userid=FRONT/FRONT file=/tmp/exp_ukpbcco11_13022018.dmp log=/tmp/exp_ukpbcco11_13022018.log  full=y compress=n grants=y consistent=y #KO

impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbdco1_07_03_2019.log dumpfile=exp_ukpbdco11_10022019.dmp #restore 25

drop user FRONT cascade; 
drop user BBVA_FRONT cascade; 

 select sid,serial# from v$session where username = 'FRONT';
 alter system kill session '104,22757';

SELECT TABLESPACE_NAME, STATUS, CONTENTS FROM USER_TABLESPACES;
 
 ORACLE_SID=ukpbcco22
 export ORACLE_SID
sqlplus / as sysdba
srvctl stop database -d ukpbdco2
srvctl start database -d ukpbdco2
srvctl config database -d ukpbdco2 -a
/ORA/oradata01/ukpbcco2/ukpbcco2/spfileukpbcco2.ora
/oracle11/OraCRSHome1/log/bobekcq1/agent/crsd/oraagent_oracle//oraagent_oracle.log 
 
 A8dD15tdes
 /ORA/oradata01/ukpbcco2/ukpbcco2/create_ukpbcco2.sql
 
 @/backekp/desa/ekip/mai/secur_upd.sql 
 invalid - 76
/backekp/desa/ekip/mai/valproc.sql 
@/oracle11/OraDBHome1/rdbms/admin/utlrp.sql - ok 
 
#err consistent
$ORACLE_HOME/bin/exp USERID="'/ as sysdba'" file=/ekipbck/exp_uukpbcco21_11102017_c.dmp full=y compress=n grants=y consistent=y log=/ekipbck/exp_ukpbcco21_11102017_c.log
# LineData F

###Backup DB FRONT - F


### Restore TEST DB - I ###

select sid,serial#,username from v$session where username = 'OPS$INGENETUDES';
 alter system kill session '104,22757';
Shutdown immediate;
startup restrict;

SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;
SELECT TABLE_NAME FROM user_tables where table_name;
select * from all_objects where object_name = 'UTILPLAN';

*ALTER SYSTEM SET "_system_trig_enabled" = FALSE

 ***
 Starting "SYS"."SYS_IMPORT_FULL_01":  "/******** AS SYSDBA" directory=DATA_PUMP_DIR  logfile=impdp_expdp_23082017.log dumpfile=expdp_23082017.dmp  include=ROLE:"in ('EKIP_SCH','EKIP_EXPL','EKIP_USER','EKIP_READ')"  include=USER:"in ('OPS$INGENETUDES','OPS$MDW','DIC','OPS$FWK','EKIP360','OPS$EKIP' )"  include=ROLE_GRANT  include=DEFAULT_ROLE  include=SYSTEM_GRANT  include=CONTEXT
 
 
Starting "SYS"."SYS_IMPORT_FULL_01":  "/******** AS SYSDBA" directory=DATA_PUMP_DIR  logfile=impdp_expdp_23082017.log dumpfile=expdp_23082017.dmp  include=ROLE:"in ('EKIP_SCH','EKIP_EXPL','EKIP_USER','EKIP_READ')"  include=USER:"in ('OPS$INGENETUDES','OPS$MDW','DIC','OPS$FWK','EKIP360','OPS$EKIP' )"  include=ROLE_GRANT  include=DEFAULT_ROLE  include=SYSTEM_GRANT  include=CONTEXT

#OK +/-
impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbcco2_24Octu2017.log dumpfile=exp_ukpbcco21_19102017.dmp include=ROLE:\"in \(\'EKIP_SCH\',\'EKIP_EXPL\',\'EKIP_USER\',\'EKIP_READ\'\)\" include=USER:\"in \(\'OPS\$INGENETUDES\',\'OPS\$MDW\',\'DIC\',\'OPS\$FWK\',\'EKIP360\',\'OPS\$EKIP\' \)\" include=ROLE_GRANT include=DEFAULT_ROLE include=SYSTEM_GRANT include=CONTEXT
impdp system/gptwpro6 directory=DUMP logfile=DUMP:impdp_ukpbcco2_20171103_1.log dumpfile=exp_ukpbcco2_20171103.dmp include=ROLE:\"in \(\'EKIP_SCH\',\'EKIP_EXPL\',\'EKIP_USER\',\'EKIP_READ\'\)\" include=USER:\"in \(\'OPS\$INGENETUDES\',\'OPS\$MDW\',\'DIC\',\'OPS\$FWK\',\'EKIP360\',\'OPS\$EKIP\' \)\" include=ROLE_GRANT include=DEFAULT_ROLE include=SYSTEM_GRANT include=CONTEXT

impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbcco21_24_Octu2017.log dumpfile=exp_ukpbdco21_24102017.dmp include=ROLE:"in ('EKIP_SCH','EKIP_EXPL','EKIP_USER','EKIP_READ')" include=USER:"in ('OPS$INGENETUDES','OPS$MDW','DIC','OPS$FWK','EKIP360','OPS$EKIP' )" include=ROLE_GRANT include=DEFAULT_ROLE include=SYSTEM_GRANT include=CONTEXT


impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbcco11_.log dumpfile=exp_ukpbdco21_24102017.dmp include=ROLE:"in ('P_USER_APL','RL_PRIV_FRONT')" include=USER:"in ('FRONT')" include=ROLE_GRANT include=DEFAULT_ROLE include=SYSTEM_GRANT include=CONTEXT


/oracle11/OraDBHome1/rdbms/log/exp_ukpbdco21_24102017.dmp

Starting "SYS"."SYS_IMPORT_FULL_01":  "/******** AS SYSDBA" directory=DATA_PUMP_DIR  logfile=impdp_expdp_23082017.log dumpfile=expdp_23082017.dmp  include=ROLE:"in ('EKIP_SCH','EKIP_EXPL','EKIP_USER','EKIP_READ')"  include=USER:"in ('OPS$INGENETUDES','OPS$MDW','DIC','OPS$FWK','EKIP360','OPS$EKIP' )"  include=ROLE_GRANT  include=DEFAULT_ROLE  include=SYSTEM_GRANT  include=CONTEXT
 
#MX
nohup impdp \"/ as sysdba\" directory=DATA_PUMP_DIR  logfile=impd_ukpbdco21_26102017.log dumpfile=exp_ukpbdco21_24102017.dmp full=yes & 
export DISPLAY=150.233.133.161:0.0 
 
 ***
 
#12.3.2 Import schemas
# add specific users OPS$EKIPxxxx

#OK
 impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_expdp_23082017_2.log dumpfile=exp_ukpbcco21_19102017.dmp SCHEMAS=OPS\$INGENETUDES,OPS\$MDW,OPS\$FWK,DIC,PUBLIC
 
 *
 impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_expdp_23082017_2.log dumpfile=exp_ukpbcco21_19102017.dmp SCHEMAS=OPS\$EKIP


catalog.sql

@/oracle11/OraDBHome1/rdbms/admin/utlrp.sql  
 -  pre: 16083 after: 68
 
@/export/home/ekipco/grant_EKIP_SCH.sql - nothing done

*
GRANT EKIP_EXPL TO DIC;
GRANT UNLIMITED TABLESPACE TO DIC;
GRANT SELECT ON DBA_OBJECTS TO DIC;
GRANT SELECT ON DBA_ROLE_PRIVS TO DIC;
GRANT SELECT ON DBA_TAB_PRIVS TO DIC;
GRANT SELECT ON DBA_EXTERNAL_TABLES TO DIC;
GRANT EKIP_EXPL TO OPS$FWK;
GRANT UNLIMITED TABLESPACE TO OPS$FWK;
GRANT SELECT ON DBA_OBJECTS TO OPS$FWK;
GRANT SELECT ON DBA_ROLE_PRIVS TO OPS$FWK;
GRANT SELECT ON DBA_TAB_PRIVS TO OPS$FWK;
GRANT SELECT ON DBA_EXTERNAL_TABLES TO OPS$FWK;
GRANT EKIP_EXPL TO OPS$INGENETUDES;
GRANT UNLIMITED TABLESPACE TO OPS$INGENETUDES;
GRANT SELECT ON DBA_OBJECTS TO OPS$INGENETUDES;
GRANT SELECT ON DBA_ROLE_PRIVS TO OPS$INGENETUDES;
GRANT SELECT ON DBA_TAB_PRIVS TO OPS$INGENETUDES;
GRANT SELECT ON DBA_EXTERNAL_TABLES TO OPS$INGENETUDES;
GRANT EKIP_EXPL TO OPS$MDW;
GRANT UNLIMITED TABLESPACE TO OPS$MDW;
GRANT SELECT ON DBA_OBJECTS TO OPS$MDW;
GRANT SELECT ON DBA_ROLE_PRIVS TO OPS$MDW;
GRANT SELECT ON DBA_TAB_PRIVS TO OPS$MDW;
GRANT SELECT ON DBA_EXTERNAL_TABLES TO OPS$MDW;

#242
'ops$ingenetudes/galene@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 150.250.233.137)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ukpbcco2)))'
 @/backekp/desa/ekip/mai/secur_upd.sql 
 invalid - 76
/backekp/desa/ekip/mai/valproc.sql 
  
 
#Restore TEST DB - F


###
### 26 Octubre Despues Restore- Noche - I ###
@/oracle11/OraDBHome1/rdbms/admin/utlrp.sql - 136
cd /backekp/desa/ekip/ekp
. ./init_env desa
/backekp/desa/ekip/recreate_objects.sql 
vi recreate_objects.tmp
@/oracle11/OraDBHome1/rdbms/admin/utlrp.sql
/backekp/desa/ekip/mai/secur_upd.sql 
grant execute on sys.dbms_pipe to public;
grant execute on sys.dbms_lock to public;
grant execute on sys.dbms_job to public;
grant_EKIP_SCH.sql
@/backekp/desa/ekip/mai/secur_upd.sql
@/backekp/desa/ekip/mai/valproc.sql
@/backekp/desa/ekip/mai/secur_upd.sql - mdw
@/oracle11/OraDBHome1/rdbms/admin/utlrp.sql
/backekp/desa/ekip/recreate_objects.sql 
vi recreate_objects 
@ ?/rdbms/admin/utlrp
### 26 Octubre Despues Restore- Noche - I ###

### PR 03-11-2017
/oracle11/OraHome1/bin/sqlplus 'ops$ingenetudes/galene@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 150.250.233.186)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ukpbpco2)))'
select count(*) from all_objects where status !='VALID';  - 19
select count(*) from all_objects;
select count(*) from all_objects where OWNER = 'BONITA7_4';
/backekp/produccion/ekip/recreate_objects.sql
/backekp/produccion/ekip/mai/secur_upd.sql 
@/backekp/produccion/ekip/mai/secur_upd.sql  - mdw
###
/backekp/produccion/ekip/mai/VIDE_BASE.sh ukpbpco2
#PR 08-Nov-2017
cd /backekp/produccion/ekip/ekp ; . ./init_env produccion
sqlplus / @recreate_objects.sql
vi recreate_objects.tmp
sqlplus /nolog @recreate_objects.tmp
@ ?/rdbms/admin/utlrp

###Statitics
exec dbms_stats.gather_schema_stats('OPS$INGENETUDES',5,cascade=>TRUE, degree=>8);
exec dbms_stats.gather_schema_stats('DIC',10,cascade=>TRUE);
exec dbms_stats.gather_schema_stats('OPS$MDW',10,cascade=>TRUE);

begin
  dbms_stats.gather_table_stats(ownname=> 'BONITA7', tabname=> 'ARCH_DATA_INSTANCE', partname=> NULL, estimate_percent=> 25, block_sample=> FALSE, method_opt=> NULL, degree=> 1, granularity=> 'DEFAULT', cascade=> FALSE, stattab=> NULL, statid=> NULL, statown=> NULL, no_invalidate=> DBMS_STATS.AUTO_INVALIDATE, force=> FALSE);
end;
/

#Back lib
exec dbms_stats.gather_schema_stats('FRONT',5,cascade=>TRUE, degree=>8);
select * from ALL_LIBRARIES where upper(LIBRARY_NAME) = 'DBLIB_MOTEUR_FINANCIER';

#Permisos

ld.so.1: sqlplus: fatal: /oracle11/OraDBHome1/lib/libclntsh.so.11.1: Permission denied
Killed

###RESTORE DB FRONT - Local
drop user FRONT cascade;
drop user BBVA_FRONT cascade;
drop role P_USER_APL;
drop role RL_PRIV_FRONT;
$ORACLE_HOME/bin/impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbpco11_01022019.log dumpfile=exp_ukpbpco11_31012019.dmp include=ROLE:\"in \(\'P_USER_APL\',\'RL_PRIV_FRONT\'\)\"  include=USER:\"in \(\'FRONT\',\'BBVA_FRONT\'\)\" include=ROLE_GRANT include=DEFAULT_ROLE include=SYSTEM_GRANT include=CONTEXT #1
$ORACLE_HOME/bin/impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbpco11_01022019.log dumpfile=exp_ukpbpco11_31012019.dmp SCHEMAS=FRONT,PUBLIC, BBVA_FRONT #2

#Jobs mantenimiento
@/export/home/frontco/PG_ABD_MAINTENANCE.sql
@/export/home/frontco/PG_ABD_MAINTENANCE_Body.sql

#RESTORE - Back ops$ekip
drop user OPS$EKIP cascade;
impdp "'/ as sysdba'" directory=DATA_PUMP_DIR_TMP logfile=impdp_ukpbpco22_01022018.log dumpfile=exp_ukpbcco21_01022018.dmp SCHEMAS=OPS\$EKIP
303 error(s)

#Invalid objects owner ops$ekip
run file add_rights_OPSEKIP.sql


$ nohup expdp \'/ as sysdba\' directory=BKP_UKPBCCO1 dumpfile=expdp_ukpbcco1_20180124.dmp logfile=BKP_UKPBCCO1:expdp_ukpbcco1_20180124.log full=Y &


#########################################
### RESTORE BACK - ALL USERS PR - INI ###
#########################################

/* Drop public synonyms for EKIP */
declare cursor curs_public is select 'drop public synonym "'||synonym_name||'"' drop_pub from all_synonyms where owner='PUBLIC' 
and TABLE_OWNER in (select GRANTEE from dba_role_privs where GRANTED_ROLE='EKIP_SCH' and GRANTEE !='SYS')
;begin for rec_public in curs_public loop execute immediate rec_public.drop_pub; end loop; END; 
/

drop user OPS$INGENETUDES cascade; 
drop user OPS$MDW cascade;
drop user OPS$EKIP cascade; 
drop user OPS$FWK cascade; 
drop user DIC cascade; 
drop role EKIP_SCH; 
drop role EKIP_EXPL; 
drop role EKIP_USER; 
drop role EKIP_READ;

#add specific users OPS$EKIPxxxx 
impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbdco21_18042018.log dumpfile=exp_ukpbcco21_16042018.dmp include=ROLE:\"in \(\'EKIP_SCH\',\'EKIP_EXPL\',\'EKIP_USER\',\'EKIP_READ\'\)\" \ include=USER:\"in \(\'OPS\$INGENETUDES\',\'OPS\$MDW\',\'DIC\',\'OPS\$FWK\',\'EKIP360\',\'OPS\$EKIP\' \)\" \ include=ROLE_GRANT \ include=DEFAULT_ROLE \ include=SYSTEM_GRANT \ include=CONTEXT

#add specific users OPS$EKIPxxxx 
impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbdco21_18042018_2.log dumpfile=exp_ukpbcco21_16042018.dmp SCHEMAS=OPS\$INGENETUDES,OPS\$MDW,OPS\$FWK,DIC,OPS\$EKIP,PUBLIC

#
grant execute on sys.dbms_pipe to OPS$INGENETUDES; 
grant execute on sys.dbms_lock to OPS$INGENETUDES; 
grant execute on sys.dbms_job to OPS$INGENETUDES; 
grant execute on sys.dbms_aqadm to OPS$INGENETUDES; 
grant execute on sys.dbms_aq to OPS$INGENETUDES; 
grant execute on sys.dbms_crypto to OPS$INGENETUDES; 
grant execute on sys.dbms_redefinition to OPS$INGENETUDES; 
grant execute on sys.dbms_session to OPS$INGENETUDES; 
grant execute on sys.utl_file to OPS$INGENETUDES;

SELECT count(*) FROM all_objects WHERE status !='VALID';

@/export/home/ekipco/grant_EKIP_SCH.sql - nothing done - from db server (OK to run in 242 secur_upd.sql)
vi grant_EKIP_SCH.tmp

#Server WAS - I
sqlplus 'ops$ingenetudes/galene' @recreate_objects.sql #OK
vi recreate_objects.tmp
sqlplus /nolog @recreate_objects.tmp
sqlplus 'ops$ingenetudes/galene' @$EKIP/mai/secur_upd.sql
sqlplus 'ops$mdw/mdw' @$EKIP/mai/secur_upd.sql
#Server WAS - F

@?/rdbms/admin/utlprp 1

exec dbms_stats.gather_schema_stats('OPS$INGENETUDES',5,cascade=>TRUE, degree=>8); 
exec dbms_stats.gather_schema_stats('DIC',10,cascade=>TRUE); 
exec dbms_stats.gather_schema_stats('OPS$MDW',10,cascade=>TRUE); 

drop user BBVA_BACK cascade; 
impdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=impdp_ukpbdco21_18042018_3.log dumpfile=exp_ukpbcco21_16042018.dmp SCHEMAS=BBVA_BACK
@?/rdbms/admin/utlprp 1



#########################################
### RESTORE BACK - ALL USERS PR - FIN ###
#########################################


#Purge
@/export/home/frontco/Patch_EkipPos_TRUNCATE_TABLE_OFFER_V2.sql
@/export/home/frontco/EkipPos_PurgeParam_0BCOL_V1.1.sql

@/export/home/frontco/EkipPos_PurgeParam_0BCOL_V1.2.sql

##################
### PRODUCCIÓN ###
##################
$ORACLE_HOME/bin/expdp FRONT/FRONT full=y directory=DATA_PUMP_DIR logfile=exp_ukpbcco11_07112017.log dumpfile=exp_ukpbcco11_07112017.dmp compression=ALL flashback_time=systimestamp consistent=y


#DBA_PR

#Front_184
export ORACLE_SID=ukpbpco12
export ORACLE_HOME=/oracle11/OraDBHome1
/oracle11/OraDBHome1/bin/sqlplus /nolog
connect / as sysdba
select count(*) from front.lovelt;

#Back_189
export ORACLE_SID=ukpbpco22
export ORACLE_HOME=/oracle11/OraDBHome1
/oracle11/OraDBHome1/bin/sqlplus /nolog
connect / as sysdba
select * from all_objects where object_name = 'UTILPLAN';
select * from OPS$INGENETUDES.UTILPLAN;

ORACLE_SID=ukpbdco22 sqlplus "/ as sysdba"
#Files
select * from ALL_DIRECTORIES;
DATA_PUMP_DIR - /oracle11/OraDBHome1/rdbms/log/
                /oracle11/OraDBHome1/rdbms/log/
				/ekipbck/
				/u02/EKTMP/BKCFBPRO/TMPCOD

CREATE DIRECTORY DATA_PUMP_DIR_TMP AS '/tmp';

#remote connect
show parameter remote_os_authent;
select * from v$parameter where name = 'remote_os_authent'

#Back lib
select * from ALL_LIBRARIES where upper(LIBRARY_NAME) = 'DBLIB_MOTEUR_FINANCIER';

###DB Scripts Backups
/export/home/oracle/scripts/datapump/exp_ukpbdco11.sh (150.250.233.131).
/export/home/oracle/scripts/datapump/exp_ukpbdco12.sh (150.250.233.136).

#Compile SYNONYM
	SELECT    'CREATE OR REPLACE PUBLIC SYNONYM ' || SYNONYM_NAME 
		   || ' for ' || TABLE_OWNER || '.' || TABLE_NAME || ';'
	  FROM all_synonyms WHERE OWNER = 'PUBLIC' AND SYNONYM_NAME IN (SELECT OBJECT_NAME
	FROM all_objects WHERE status = 'INVALID' AND owner = 'PUBLIC');
	
#Validate database objects
sql> @ ?/rdbms/admin/utlrp

show error procedure OPS$INGENETUDES.DB_VSA_UTILISATION_SECTEUR;

alter procedure OPS$INGENETUDES.DB_VSA_UTILISATION_SECTEUR compile;

SELECT 'desc '||object_name FROM all_objects WHERE status = 'INVALID' AND 
   (owner IN (SELECT GRANTEE FROM dba_role_privs  WHERE GRANTED_ROLE = 'EKIP_SCH') 
   AND owner != 'SYS' OR owner = 'PUBLIC') and object_type='VIEW' ORDER BY owner, 
   object_name, object_type;

@/oracle11/OraHome1/rdbms/admin/utlrp.sql

GRANT ALL ON OPS$INGENETUDES.PKG_SRV_PARAM TO OPS$INGENETUDES
ALTER PACKAGE OPS$INGENETUDES.PKG_SRV_REAFFECTATION COMPILE;	

#Table Space

#Used
 select * From DBA_TABLESPACE_USAGE_METRICS; #https://www.databasejournal.com/features/oracle/monitoring-tablespace-usage-in-oracle.html

SELECT TABLESPACE_NAME "TABLESPACE", INITIAL_EXTENT "INITIAL_EXT", NEXT_EXTENT "NEXT_EXT", MIN_EXTENTS "MIN_EXT", MAX_EXTENTS "MAX_EXT", PCT_INCREASE FROM DBA_TABLESPACES;
SELECT  FILE_NAME, BLOCKS, TABLESPACE_NAME FROM DBA_DATA_FILES; 

#68
SELECT FILE_NAME, TABLESPACE_NAME, BYTES, BLOCKS, AUTOEXTENSIBLE, MAXBYTES, MAXBLOCKS FROM DBA_TEMP_FILES;
SELECT ALLOCATION_TYPE, INITIAL_EXTENT, NEXT_EXTENT FROM DBA_TABLESPACES WHERE TABLESPACE_NAME = 'TS_DAT001';
   /ORA/oradata01/ukpbcco2/ts_tmp001.dbf, TS_TMP001, 1073741824 
 ALTER DATABASE datafile '/ORA/oradata01/ukpbcco2/ts_tmp001.dbf' resize 1536M;
                          /ORA/oradata01/ukpbcco2/ukpbcco2/temp01.dbf 

ALTER DATABASE datafile '/ORA/oradata01/ukpbcco1/DATA_1.dbf' resize 10240M; 

#Dev 131
ALTER DATABASE datafile '/ORA/oradata01/ukpbdco1/DATA_1.dbf' resize 13568M
                                                                1310720          
																 303556
TABLESPACE_NAME                USED_SPACE TABLESPACE_SIZE USED_PERCENT	
DATA                               336696         1736704   19.3870688
DATA                               976208         1310720   74.4787598
DATA                               336696          655360   51.3757324

TS_DAT001                          978816          983040   99.5703125
TS_DAT001                            8496         4063232   .209094632																

@/oracle11/OraHome1/rdbms/admin/utlrp.sql *** ok
OraCRSHome1
@/backekp/desa/ekip/recreate_objects.sql *** OK
/backekp/desa/ekip/mai/secur_upd.sql #permisos
/backekp/desa/ekip/mai/valproc.sql #Compilation des objects invalides	   

sqlplus 'ops$ingenetudes/galene' @compil_ALL.sql
/backekp/desa/ekip/ekp/tnsnames.ora

#connect
sqlplus 'ops$ingenetudes/galene@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 150.250.233.137)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ukpbdco2)))'
sqlplus 'ZBACKACC/v_PlFwZb813@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 150.250.233.137)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ukpbdco2)))'
sqlplus 'FRONT/FRONT@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 150.250.233.132)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ukpbdco1)))'
sqlplus 'FRONT/FRONT@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 150.250.233.132)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ukpbcco1)))'

truncate table ServerSynchroRequest;

tnsping ukpbdco1

select * from all_indexes where index_name like '%FK_COMMPARTYI%'
select username FROM all_users order by username;

#Err lovelt
select * from loveltdefinition where code is null
delete from loveltdefinition where eltnature is null
delete from lovelt where value is null or longlabel is null or shortlabel is null
delete from lovelt where l.value is null

#Profile
from appuser a, appuserprofil ap, profil p, func f, screen s, profilfunc pf
where a.id = ap.appuserid
and ap.profilid = p.id
and pf.profilid = p.id 
and pf.funcid = f.id
and f.screenid = s.id
and a.login like 'GUILHEM';


gptwpro6


#dbms_output
set serveroutput on;

#Paquete mantenimiento
BEGIN "OPS$EKIP".pg_abd_maintenance.sp_statistics_scheme(); END;


select s.sid, s.serial#, s.status, p.spid, s.username from v$session s, v$process p where s.username = 'FRONT' and p.addr (+) = s.paddr;
select job from dba_jobs where log_user='FRONT';
select queue_table, qid from dba_queues where owner='FRONT';
select apply_name from dba_apply where queue_owner='FRONT'; 
select capture_name, queue_name from dba_capture where queue_owner='FRONT';
select propagation_name from dba_propagation where  source_queue_owner='FRONT' or destination_queue_owner='FRONT'; 

#Compile invalid objects
exec dbms_utility.compile_schema( 'OPS$EKIP');


#Sequences
alter sequence SEQ_ID_MDW_HISTO_MODIF increment by 1;
select * from all_objects where object_name = 'SEQ_ID_MDW_HISTO_MODIF';
select SEQ_ID_MDW_HISTO_MODIF.nextva from dual
CREATE SEQUENCE "OPS$MDW"."SEQ_ID_MDW_HISTO_MODIF" MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1522 CACHE 20 NOORDER NOCYCLE ;

#Kill sessions (check both database servers) #http://anilanbu.blogspot.com.co/2012/02/ora-01940-cannot-drop-user-that-is.html
select s.sid, s.serial#, s.status, p.spid from v$session s, v$process p where s.username = 'OPS$INGENETUDES' and p.addr (+) = s.paddr;
alter system kill session '193,51713'
!kill -9 12349

SELECT sid, serial#,inst_id  FROM gv$session WHERE (inst_id, sid) IN (SELECT inst_id, sid FROM gv$lock WHERE type = 'TO')
ALTER SYSTEM KILL SESSION '178,18759,@2';

#Baja DB
/export/home/oracle/scripts/bdb/aja_ukpbcco11.sh
   SHELL=/bin/bash
LOGS=/export/home/oracle/scripts/logs/
export LOGS
ORACLE_BASE=/oracle11/OraBase
export ORACLE_BASE
ORACLE_HOME=/oracle11/OraDBHome1
export ORACLE_HOME
export PATH=$PATH:$ORACLE_HOME/bin
$ORACLE_HOME/bin/srvctl stop database -d ukpbcco1 -o immediate > $LOGS/baja_ukpbcco1_`date "+%d%m%y"`.log 2>&1
$ORACLE_HOME/bin/srvctl status database -d ukpbcco1>> $LOGS/baja_ukpbcco1_`date "+%d%m%y"`.log 2>&1

#Sube DB
$ORACLE_HOME/bin/srvctl start database -d ukpbcco1 -o open > $LOGS/sube_ukpbcco1_`date "+%d%m%y"`.log 2>&1
$ORACLE_HOME/bin/srvctl status database -d ukpbcco1 >> $LOGS/sube_ukpbcco1_`date "+%d%m%y"`.log 2>&1

#Desbloquear y cambiar password
ALTER USER user_name IDENTIFIED BY password ACCOUNT UNLOCK;
ALTER USER BBVA_FRONT IDENTIFIED BY B2v1fr0n ACCOUNT UNLOCK;
GRANT CREATE SESSION TO BBVA_FRONT WITH ADMIN OPTION;
grant create table to BBVA_FRONT;
grant create PROCEDURE to BBVA_FRONT;
SELECT username, account_status, created, lock_date, expiry_date FROM dba_users WHERE account_status != 'OPEN';

ALTER USER BBVA_BACK IDENTIFIED BY B2v1fr0n ACCOUNT UNLOCK;
GRANT CREATE SESSION TO BBVA_BACK WITH ADMIN OPTION;
#CONSTRAINTS
select * from all_constraints  where STATUS='DISABLED' and owner='FRONT';
select * from SCREEN where SCREENID not in  (select id from SCREEN);

SELECT * FROM   ALL_CONS_COLUMNS WHERE  owner = user  AND CONSTRAINT_NAME= 'FK1004662' ;

ALTER TABLE PROFILFUNC DISABLE CONSTRAINT FK100427;


ALTER USER BBVA_FRONT IDENTIFIED BY B2v1fr0n ACCOUNT UNLOCK;

#Password

alter user BBVA_BI identified by BBVA_BI;
alter user BONITA7BDM identified by BONITA7BDM;
alter profile default limit password_life_time unlimited;


#Error 500 prod node
   Caused by: java.lang.NullPointerException
        at com.linedata.ekip.dcfs.epos.core.services.security.dao.impl.springHbm.AppUserReloadableCollection.doReloadUser(AppUserReloadableCollection.java:187)
        at com.linedata.ekip.dcfs.epos.core.services.security.dao.impl.springHbm.AppUserReloadableCollection.reload(AppUserReloadableCollection.java:51)
        at com.linedata.ekip.pos.collection.ReloadableCollectionManager$1.doInHibernate(ReloadableCollectionManager.java:131)

Update Nodenetwork Set Statuscode = 'ARC' Where Id In (1,2,141,205,206);
Update Nodenetwork Set Fundspaymentcode = 'DIRDEBIT' Where Id In (-222, 205,206);
Update Nodenetwork Set SORTNUMBER = 1 Where Id In (-222, 3263);
Select * From Node Where Nodenetworkid Is Null
SELECT * FROM NODENETWORK WHERE ID = 1
UPDATE Node SET Nodenetworkid = 1 Where Nodenetworkid Is Null		


#vmw
DATA_PUMP_DIR /home/oracle/app/oracle/admin/ukpbdco1/dpdump/
ORACLE_SID=ukpbdco1
export ORACLE_SID
expdp "'/ as sysdba'" directory=DATA_PUMP_DIR logfile=exp_ukpbpco1_ANONYMIZATION_31012019_2.log dumpfile=exp_ukpbpco1_ANONYMIZATION_31012019_2.dmp full=y compression=ALL flashback_time=systimestamp consistent=y







SELECT USERNAME FROM ALL_USERS ORDER BY USERNAME; 
SELECT TABLESPACE_NAME FROM USER_TABLESPACES;
SELECT USERNAME, DEFAULT_TABLESPACE FROM DBA_USERS;

#DB
SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS ORDER BY PDB_ID;
     PDB_ID PDB_NAME                                                                                             STATUS
     ----- ----------------------------------------------------------------------------------------------------- ----------
         2 PDB$SEED                                                                                              NORMAL
         3 ORCLPDB1                                                                                              NORMAL
           
		   ORCLPDB1
ORACLE_SID=ORCLCDB - Ok
export ORACLE_SID
sqlplus / as sysdba

#Service: ORCLPDB1
#SID: ORCLCDB

conn sys as sysdba
alter session set "_ORACLE_SCRIPT"=true;
commit;


CREATE BIGFILE TABLESPACE tbs_perm_01
  DATAFILE 'tbs_perm_01.dat'
    SIZE 20M
    AUTOEXTEND ON;

alter session set "_ORACLE_SCRIPT"=true;
CREATE USER BONITA7 IDENTIFIED BY BONITA7
  DEFAULT TABLESPACE TS_BONITA7
  TEMPORARY TABLESPACE TEMP
  QUOTA 20M on TS_BONITA7;


GRANT create session TO BONITA7;
GRANT create table TO BONITA7;
GRANT create view TO BONITA7;
GRANT create any trigger TO BONITA7;
GRANT create any procedure TO BONITA7;
GRANT create sequence TO BONITA7;
GRANT create synonym TO BONITA7;

BONITA7

#Temp
SELECT FILE_NAME, TABLESPACE_NAME, BYTES, BLOCKS, AUTOEXTENSIBLE, MAXBYTES, MAXBLOCKS FROM DBA_TEMP_FILES;

---
alter session set "_oracle_script"=true;
DROP USER BONITA7 CASCADE;
DROP ROLE BONITA7;
ALTER TABLESPACE SAMPLE OFFLINE;  #4.7G    /opt/oracle/product/12.2.0.1/dbhome_1/dbs/temp01.dbf 
                                           119M    /opt/oracle/oradata/ORCLCDB/ORCLPDB1/temp01.dbf
                                           4.7G    /opt/oracle/oradata/ORCLCDB/temp01.dbf
                                                   /opt/oracle/oradata/ORCLCDB/temp01.dbf
												   TEMP
DROP TABLESPACE TS_BONITA7 INCLUDING CONTENTS;
												   
  CREATE TEMPORARY TABLESPACE temp2 TEMPFILE '/opt/oracle/oradata/ORCLCDB/temp_2.dbf' SIZE 5M REUSE
  AUTOEXTEND ON NEXT 1M MAXSIZE unlimited;
  EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M;
  ALTER DATABASE DEFAULT TEMPORARY TABLESPACE temp2;
DROP TABLESPACE TEMP INCLUDING CONTENTS AND DATAFILES;


ALTER USER BONITA7 QUOTA UNLIMITED ON  TS_BONITA7;
GRANT UNLIMITED TABLESPACE ON TS_BONITA7 TO BONITA7;

#UNDO TB
CREATE UNDO TABLESPACE undotbs2 DATAFILE '/opt/oracle/oradata/ORCLCDB/undotbs_2.dbf' SIZE 300M AUTOEXTEND ON NEXT 1M;
ALTER SYSTEM SET UNDO_TABLESPACE=undotbs2;
SELECT file_name, tablespace_name, bytes/1024/1024 UNDO_SIZE_MB, SUM(bytes/1024/1024) OVER() TOTAL_UNDO_SIZE_MB
FROM dba_data_files d
WHERE EXISTS (SELECT 1 FROM v$parameter p WHERE LOWER (p.name)='undo_tablespace' AND p.value=d.tablespace_name);
DROP TABLESPACE UNDOTBS INCLUDING CONTENTS AND DATAFILES;
ALTER SYSTEM SET UNDO_RETENTION = 900 scope=both;
show parameter undo

select segment_name, tablespace_name, status from dba_rollback_segs where tablespace_name='UNDOTBS';

alter system set "_offline_rollback_segments" = '_SYSSMU15_307291401$' , '_SYSSMU16_3346137561$','_SYSSMU17_2638063083$', '_SYSSMU18_1564750626$','_SYSSMU19_1920145524$','_SYSSMU20_511274972$' scope=spfile;

select 'drop rollback segment '||'"'||segment_name||'";' from  dba_rollback_segs where tablespace_name='UNDOTBS';

#GET TS
SELECT FILE_NAME, BYTES FROM DBA_DATA_FILES WHERE TABLESPACE_NAME = 'TS_BONITA7';

#Get Count Tables
select table_name, 
       to_number(extractvalue(xmltype(dbms_xmlgen.getxml('select count(*) c from '||owner||'.'||table_name)),'/ROWSET/ROW/C')) 
       as count
from all_tables
where owner = 'BONITA7_4' ORDER BY COUNT DESC;

#Pause
select * from tenant
update TENANT set status='ACTIVATED';

#Backup
exp userid=BONITA7/BONITA7 file=/tmp/arch_flownode_instance.dmp log=/tmp/arch_flownode_instance.txt tables=arch_flownode_instance consistent=y buffer=1024000 #OK
exp userid=BONITA7/BONITA7 file=/tmp/ARCH_PROCESS_INSTANCE.dmp log=/tmp/ARCH_PROCESS_INSTANCE.txt tables=ARCH_PROCESS_INSTANCE consistent=y buffer=1024000
exp userid=BONITA7/BONITA7 file=/tmp/ARCH_DATA_INSTANCE.dmp log=/tmp/ARCH_DATA_INSTANCE.txt tables=ARCH_DATA_INSTANCE consistent=y buffer=1024000

#Restore 
imp BONITA7BDM/BONITA7BDM FILE=BONITA7BDM_4_Octu_2020.dmp FROMUSER=BONITA7BDM touser=BONITA7BDM TABLES=pndataproceso

#Tablespaces - particionamiento
SELECT DISTINCT  dtf.* FROM DBA_DATA_FILES dtf order by dtf.TABLESPACE_NAME;

#Count Indexes
SELECT table_name, (row_size_in_bytes * cnt_of_rows)/1000/1000/1000 index_size_in_GB
 FROM ( SELECT table_name, (sum (column_length) / 1048576) * 1000000 row_size_in_bytes
 FROM USER_IND_COLUMNS WHERE table_name IN ('ARCH_PROCESS_INSTANCE', 'PROCESS_INSTANCE', 'ARCH_FLOWNODE_INSTANCE')
GROUP BY table_name ) A, (SELECT count(1) cnt_of_rows FROM ARCH_FLOWNODE_INSTANCE );


61469220
41095343















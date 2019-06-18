--**************************************************
--*** Creamos la tabla para almacenar los tweets ***
--**************************************************

create table aux_twitter_lab(
llave_busqueda varchar2(50),
tweet varchar2(500),
usuario varchar2(100),
fecha TIMESTAMP (6) DEFAULT systimestamp,
lugar varchar2(100),
coordenadas varchar2(200),
geo varchar2(100),
json clob)
tablespace ts_table_m;

--**********************************************************************************
--*** Consulta con el fin de identificar la cantidad de tweets por personaje ***
--**********************************************************************************
select llave_busqueda,count(0) conteo from aux_twitter_lab
group by llave_busqueda;

--***************************************************************
--*** Consulta para treaer todo los trinos que no sean reweet ***
--***************************************************************
select 
LLAVE_BUSQUEDA,
replace(replace(tweet,chr(10),''),chr(13),'') tweet,
USUARIO,
FECHA,
LUGAR,
COORDENADAS,
GEO
from aux_twitter_lab
where llave_busqueda = 'URIBE'
and tweet NOT like 'RT %';

--*************************************************************
--*** Consulta para treaer todo los trinos que  sean reweet ***
--*************************************************************
select 
LLAVE_BUSQUEDA,
replace(replace(tweet,chr(10),''),chr(13),'') tweet,
SUBSTR(tweet,3,INSTR(tweet, ':')-3) USUARIO_RT,
COUNT(0) CONTEO
from aux_twitter_lab
where llave_busqueda = 'PETRO'
and tweet like 'RT %'
AND SUBSTR(tweet,3,INSTR(tweet, ':')-3) IS NOT NULL
GROUP BY LLAVE_BUSQUEDA,
replace(replace(tweet,chr(10),''),chr(13),'') ,
SUBSTR(tweet,3,INSTR(tweet, ':')-3)
ORDER BY 4 DESC;



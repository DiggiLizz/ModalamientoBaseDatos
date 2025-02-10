--Lilian Zapata - Alwjandro Waiz
--Modelamiento base datos
--orden de las tablas de la mas fuerte a la mas debil (fuerte-intermedio-debil)
-- region, idioma, estado_civi, genero,titulo, comuna, compania, persona, dominio, titulacion
-- drops  activos, no correr completo

SHOW USER;

-- CREACION TABLA REGION FUERTE
CREATE TABLE REGION 
    ( 
     id_region NUMBER (2) GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
     nombre    VARCHAR2 (25)  NOT NULL 
    ) 
;

--ELIMINAR TABLA
DROP TABLE REGION;

--INGRESO DE INFORMACION
INSERT INTO REGION (nombre) VALUES ('Arica y Parinacota');
INSERT INTO REGION (nombre) VALUES ('Tarapaca');
INSERT INTO REGION (nombre) VALUES ('Antofagasta');
INSERT INTO REGION (nombre) VALUES ('Atacama');
INSERT INTO REGION (nombre) VALUES ('Coquimbo');
INSERT INTO REGION (nombre) VALUES ('Valparaiso');
INSERT INTO REGION (nombre) VALUES ('Metropolitana');
INSERT INTO REGION (nombre) VALUES ('OHiggins');
INSERT INTO REGION (nombre) VALUES ('Maule');
INSERT INTO REGION (nombre) VALUES ('Ñublea');
INSERT INTO REGION (nombre) VALUES ('BioBio');
INSERT INTO REGION (nombre) VALUES ('La Araucania');
INSERT INTO REGION (nombre) VALUES ('Los Rios');
INSERT INTO REGION (nombre) VALUES ('Los lagos');
INSERT INTO REGION (nombre) VALUES ('Aysen');
INSERT INTO REGION (nombre) VALUES ('Magallanes');

 -- CONSULTAR DATOS
 SELECT * FROM REGION;
    
--------------------------------------------------------------------------- 
 
 -- CREACION TABLA IDIOMA FUERTE
CREATE TABLE IDIOMA 
    ( 
     id_idioma     NUMBER (3) GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
     nombre_idioma VARCHAR2 (30)  NOT NULL 
    ) 
;

--ELIMINAR TABLA
DROP TABLE IDIOMA;

-- INGRESAR DATOS
INSERT INTO IDIOMA (nombre_idioma) VALUES ('INGLES');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('CHINO');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('HINDI');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('ESPAÑOL');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('FRANCES');

SELECT * FROM IDIOMA;
    
 ---------------------------------------------------------------------------  
 
-- CREACION TABLA ESTADO CIVIL FUERTE
CREATE TABLE ESTADO_CIVIL 
    ( 
     id_estado_civil NUMBER (1)  NOT NULL , 
     descripcion     VARCHAR2 (25)  NOT NULL 
    ) 
;
-- CREACION LLAVE PRIMARIA
ALTER TABLE ESTADO_CIVIL ADD CONSTRAINT PK_ESTADO_CIVIL PRIMARY KEY ( id_estado_civil ) ;

--ELIMINAR TABLA
DROP TABLE ESTADO_CIVIL;

--INGRESAR DATOS
INSERT INTO ESTADO_CIVIL (id_estado_civil, descripcion) VALUES (1, 'Soltero');
INSERT INTO ESTADO_CIVIL (id_estado_civil, descripcion) VALUES (2, 'Casado');
INSERT INTO ESTADO_CIVIL (id_estado_civil, descripcion) VALUES (3, 'Viudo');
INSERT INTO ESTADO_CIVIL (id_estado_civil, descripcion) VALUES (4, 'Divorsiado');

SELECT * FROM ESTADO_CIVIL;

---------------------------------------------------------------------------    
    
-- CREACION TABLA GENERO FUERTE
CREATE TABLE GENERO 
    ( 
     cod_genero  NUMBER (1)  NOT NULL , 
     descripcion VARCHAR2 (25)  NOT NULL 
    ) 
;
-- CREACION LLAVE PRIMARIA
ALTER TABLE GENERO ADD CONSTRAINT PK_GENERO PRIMARY KEY ( cod_genero ) ;  

--ELIMINAR TABLA
DROP TABLE GENERO;

--AGREGAR INFORMACION
INSERT INTO GENERO (cod_genero, descripcion) VALUES (1, 'Femenino');
INSERT INTO GENERO (cod_genero, descripcion) VALUES (2, 'Masculino');
INSERT INTO GENERO (cod_genero, descripcion) VALUES (3, 'Transgenero');
    
SELECT * FROM GENERO;    
    
 ---------------------------------------------------------------------------   
    
-- CREACION TABLA TITULO FUERTE
CREATE TABLE TITULO 
    ( 
     cod_titulo  NUMBER (5)  NOT NULL , 
     descripcion VARCHAR2 (60)  NOT NULL 
    ) 
;
-- CREACION LLAVE PRIMARIA
ALTER TABLE TITULO ADD CONSTRAINT PK_TITULO PRIMARY KEY ( cod_titulo ) ;   

--ELIMINAR TABLA
DROP TABLE TITULO;

--INGRESAR DATOS
INSERT INTO TITULO (cod_titulo, descripcion) VALUES (1, 'Ingeniero en ventas');
INSERT INTO TITULO (cod_titulo, descripcion) VALUES (2, 'Contador');
INSERT INTO TITULO (cod_titulo, descripcion) VALUES (3, 'Analista de Datos');
INSERT INTO TITULO (cod_titulo, descripcion) VALUES (4, 'Full Stack');

SELECT * FROM TITULO;    
    
 ---------------------------------------------------------------------------   
    
-- CREACION DE COMUNA TABLA INTERMEDIA, SOLO DEPENDE DE UNA TABLA
CREATE TABLE COMUNA 
    ( 
     id_comuna     NUMBER (5)  NOT NULL , 
     comuna_nombre VARCHAR2 (25)  NOT NULL , 
     id_region     NUMBER (2)  NOT NULL 
    ) 
;
-- CREACION LLAVE PRIMARIA
ALTER TABLE COMUNA ADD CONSTRAINT PK_COMUNA PRIMARY KEY ( id_comuna, id_region ) ;   

--LLAVE FORANEA
ALTER TABLE COMUNA ADD CONSTRAINT FK_COMUNA_REGION FOREIGN KEY (id_region) REFERENCES REGION (id_region);

-- CREACION DE SECUENCIA DE INCREMENTO
CREATE SEQUENCE SEQ_COMUNA
    START WITH 1101     -- INICIA EN 1101
    INCREMENT BY 1      -- AUMENTO DE 1
    NOCYCLE;            -- NO SE REINICIA UNA VEZ ACABADO

--ELIMINAR TABLA
DROP TABLE COMUNA;
DROP SEQUENCE SEQ_COMUNA; 

-- INSERTADOR DE DATOS
INSERT INTO COMUNA (id_comuna, comuna_nombre, id_region) VALUES (SEQ_COMUNA.NEXTVAL, 'Santiago', 1);
INSERT INTO COMUNA (id_comuna, comuna_nombre, id_region) VALUES (SEQ_COMUNA.NEXTVAL, 'Camarores', 2);
INSERT INTO COMUNA (id_comuna, comuna_nombre, id_region) VALUES (SEQ_COMUNA.NEXTVAL, 'Iquique', 3);
INSERT INTO COMUNA (id_comuna, comuna_nombre, id_region) VALUES (SEQ_COMUNA.NEXTVAL, 'Osorno', 4);


-- CONSULTAR INFORMACION
SELECT * FROM COMUNA;
SELECT id_comuna, id_region FROM COMUNA;
 
 ---------------------------------------------------------------------------   
    
-- CREACION DE TABLA COMPANIA DEPENDE DE UNA TABLA (COMUNA)
CREATE TABLE COMPANIA 
    ( 
     id_empresa     NUMBER (2)  NOT NULL , 
     nombre_empresa VARCHAR2 (25)  NOT NULL , 
     calle          VARCHAR2 (25)  NOT NULL , 
     numeracion     NUMBER (5)  NOT NULL , 
     renta_promedio NUMBER (10)  NOT NULL , 
     pct_aumento    NUMBER (4,3)  NOT NULL , 
     id_comuna      NUMBER (5)  NOT NULL , 
     id_region      NUMBER (2)  NOT NULL 
    ) 
;
-- CREACION DE LLAVE PRIMARIA
ALTER TABLE COMPANIA ADD CONSTRAINT PK_COMPANIA PRIMARY KEY ( id_empresa ) ;  

--llave foranea
ALTER TABLE COMPANIA ADD CONSTRAINT FK_COMPANIA_COMUNA FOREIGN KEY (id_comuna, id_region) REFERENCES COMUNA (id_comuna, id_region) ;

-- CREACION DE INCREMENTO
CREATE SEQUENCE SEQ_COMPANIA
    START WITH 10       -- INICIO EN 10
    INCREMENT BY 5      -- INCREMENTO DE 5
    MAXVALUE 40         -- HAY 7 COMPAÑIAS
    NOCYCLE;            -- NO REINICIA
       
--ELIMINAR TABLA
DROP TABLE COMPANIA;
DROP SEQUENCE SEQ_COMUNA;  -- eliminar secuencia

-- CONSULTAR SECUENCIA
SELECT sequence_name FROM user_sequences WHERE sequence_name = 'SEQ_COMPANIA';
-- BORRAR SECUENCIA
DROP SEQUENCE SEQ_COMPANIA;

--INGRESAR DATOS
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, id_comuna, id_region)
    VALUES (10, 'CCyRojas', 'Amapolas', 506, 1577000, 0.5, 1101, 1 );
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, id_comuna, id_region)
    VALUES (15, 'SenTTy', 'Los Alamos', 3490, 897000, 0.025, 1101, 1 );
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, id_comuna, id_region)
    VALUES (20, 'Praxia LTDA', 'Las Camelias', 11098, 2157000, 0.035, 1101, 1 );
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, id_comuna, id_region)
    VALUES (25, 'Tic ´SPA', 'Flores', 4357, 857000, 0.15, 1102, 2 );
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, id_comuna, id_region)
    VALUES (30, 'Santana LTDA', 'Av Vicuña Mackena', 106, 757000, 0.015, 1102, 2 );
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, id_comuna, id_region)
    VALUES (35, 'Flores y Asociados', 'Pedro Latorre', 557, 589000, 0.025, 1104, 4 );
INSERT INTO COMPANIA (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, id_comuna, id_region)
    VALUES (40, 'Caets', 'Angol', 514, 4777000, 0.4, 1103, 3 );


SELECT * FROM COMPANIA;

    

---------------------------------------------------------------------------

-- CREACION TABLA INTERMEDIA, DEPENDE DE 4 TABLAS
CREATE TABLE PERSONA 
    ( 
     run_persona        NUMBER (8)  NOT NULL , 
     dv_run             CHAR (1)  NOT NULL , 
     p_nombre           VARCHAR2 (25)  NOT NULL , 
     s_nombre           VARCHAR2 (25) , 
     p_apellido         VARCHAR2 (25)  NOT NULL , 
     s_apellido         VARCHAR2 (25)  NOT NULL , 
     fecha_contratacion DATE  NOT NULL , 
     fecha_nacimiento   DATE  NOT NULL , 
     email              VARCHAR2 (100), 
     calle              VARCHAR2 (50)  NOT NULL , 
     numeracion         NUMBER (5)  NOT NULL , 
     sueldo             NUMBER (10)  NOT NULL , 
     id_empresa         NUMBER (2)  NOT NULL , 
     id_comuna          NUMBER (5)  NOT NULL , 
     id_region          NUMBER (2)  NOT NULL , 
     cod_genero         NUMBER (1)  NOT NULL , 
     id_estado_civil    NUMBER (1)  NOT NULL 
    ) 
;
-- CREACION LLAVE PRIMARIA
ALTER TABLE PERSONA ADD CONSTRAINT PK_PERSONA PRIMARY KEY ( run_persona ) ;
ALTER TABLE PERSONA ADD CONSTRAINT UN_PERSONA_email UNIQUE ( email ) ;
ALTER TABLE PERSONA ADD CONSTRAINT CK_PERSONA_DV_RUN CHECK (UPPER(dv_run) IN ('0','1','2','3','4','5','6','7','8','9','K'));
ALTER TABLE PERSONA ADD CONSTRAINT CK_PERSONA_SUELDO CHECK (sueldo >= 450000);

-- LLAVES FORANEAS
ALTER TABLE PERSONA ADD CONSTRAINT FK_PERSONA_COMPANIA FOREIGN KEY (id_empresa) REFERENCES COMPANIA (id_empresa);
ALTER TABLE PERSONA ADD CONSTRAINT FK_PERSONA_COMUNA FOREIGN KEY (id_comuna, id_region) REFERENCES COMUNA (id_comuna,id_region);
ALTER TABLE PERSONA ADD CONSTRAINT FK_PERSONA_ESTADO_CIVIL FOREIGN KEY (id_estado_civil) REFERENCES ESTADO_CIVIL (id_estado_civil);
ALTER TABLE PERSONA ADD CONSTRAINT FK_PERSONA_GENERO FOREIGN KEY (cod_genero) REFERENCES GENERO (cod_genero);

--ELIMINAR TABLA
DROP TABLE PERSONA;

--INGRESAR DATOS
INSERT INTO PERSONA (run_persona, dv_run, p_nombre, s_nombre, p_apellido, s_apellido, fecha_contratacion, fecha_nacimiento, email, calle, numeracion, sueldo, id_empresa, id_comuna, id_region, cod_genero, id_estado_civil)
    VALUES (17789456, 1, 'Alejandro', 'Armando', 'Waiz', 'Lobos', '14/02/2015', '17/01/1988', 'waiz@gmmm.com', 'Villablaca', 457, 785985, 15, 1101, 1, 2, 1);
INSERT INTO PERSONA (run_persona, dv_run, p_nombre, s_nombre, p_apellido, s_apellido, fecha_contratacion, fecha_nacimiento, email, calle, numeracion, sueldo, id_empresa, id_comuna, id_region, cod_genero, id_estado_civil)
    VALUES (17741236, 6, 'Lizz', 'Isabel', 'Zapata', 'Zenteno', '14/02/2018', '17/05/1988', 'lizz@gmmm.com', 'Las Golondrinas', 1125, 953214, 40, 1103, 3, 1, 2);
INSERT INTO PERSONA (run_persona, dv_run, p_nombre, s_nombre, p_apellido, s_apellido, fecha_contratacion, fecha_nacimiento, email, calle, numeracion, sueldo, id_empresa, id_comuna, id_region, cod_genero, id_estado_civil)
    VALUES (7895633, 'K', 'Juan', 'Pablo', 'Rio', 'Li', '14/02/1990', '14/12/1955', 'alsk@gmmm.com', 'Rios', 4, 1236145, 25, 1102, 2, 2, 2);

---------------------------------------------------------------------------    

-- CREACION TABLA DOMINIO DEBIL, DEPENDE DE OTRAS TABLAS
CREATE TABLE DOMINIO 
    ( 
     nivel       VARCHAR2 (25)  NOT NULL , 
     run_persona NUMBER (8)  NOT NULL , 
     id_idioma   NUMBER (3)  NOT NULL 
    ) 
;
-- CREACION LLAVE PRIMARIA
ALTER TABLE DOMINIO ADD CONSTRAINT PK_DOMINIO PRIMARY KEY ( run_persona, id_idioma ) ;

--LLAVES FORNAEAS
ALTER TABLE DOMINIO ADD CONSTRAINT FK_DOMINIO_IDIOMA FOREIGN KEY (id_idioma) REFERENCES IDIOMA (id_idioma);
ALTER TABLE DOMINIO ADD CONSTRAINT FK_DOMINIO_PERSONA FOREIGN KEY (run_persona) REFERENCES PERSONA (run_persona);

--ELIMINAR TABLA
DROP TABLE DOMINIO;

--AGREGAR DATOS
INSERT INTO DOMINIO (nivel, run_persona, id_idioma) VALUES ('b1',17789456, 2);
INSERT INTO DOMINIO (nivel, run_persona, id_idioma) VALUES ('A2', 17741236, 3);
INSERT INTO DOMINIO (nivel, run_persona, id_idioma) VALUES ('A2', 7895633, 5);

SELECT * FROM DOMINIO;
---------------------------------------------------------------------------

-- CREACION TABLA TOTULACION, DEBIL, DEPENDE DE OTRAS TABLAS
CREATE TABLE TITULACION 
    ( 
     fecha_titulacion DATE  NOT NULL , 
     cod_titulo       NUMBER (5)  NOT NULL , 
     run_persona      NUMBER (8)  NOT NULL 
    ) 
;
-- CREACION LLAVE PRIMARIA
ALTER TABLE TITULACION ADD CONSTRAINT PK_TITULACION PRIMARY KEY ( cod_titulo, run_persona ) ;

--ELIMINAR TABLA
DROP TABLE TITULACION;

--AGRGAR LA INFORMACION}
INSERT INTO TITULACION (fecha_titulacion, cod_titulo, run_persona) VALUES ('11/10/2012', 1, 17789456);
INSERT INTO TITULACION (fecha_titulacion, cod_titulo, run_persona) VALUES ('11/06/2011', 1, 17741236);
INSERT INTO TITULACION (fecha_titulacion, cod_titulo, run_persona) VALUES ('11/10/1972', 1, 7895633);




--SOLICITUDES DE LA EMPRESA
-- CASO 1
SELECT 
    nombre_empresa AS "Nombre de la Empresa",
    calle || ' ' || numeracion AS "Dirección Completa",
    renta_promedio AS "Renta Promedio",
    renta_promedio * (1 + pct_aumento) AS "Renta Promedio con Aumento"
FROM COMPANIA
ORDER BY "Renta Promedio con Aumento" DESC;

--CASO 2
SELECT
    id_empresa AS "Id de la Empresa",
    nombre_empresa AS "Nombre de la Empresa",
    renta_promedio AS "Renta Promedio Actual",
    pct_aumento * 0.15 AS "Porcentaje aumentado en 15%",
    renta_promedio * 1.15 AS "Renta Aumentada"
FROM COMPANIA
ORDER BY "Renta Promedio Actual" ASC, "Nombre de la Empresa" ASC;




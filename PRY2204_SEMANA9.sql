-- EVALUACION TRANSVERSAL MODELAMIENTO BASE DE DATOS
-- LILIAN ZAPATA

SHOW USER;


--CREACION DE TABLAS FUERTES
CREATE TABLE NACIONALIDAD(
    id_nacionalidad  NUMBER   (3)  NOT NULL,
    pais             VARCHAR2 (50) NOT NULL
);

-- CREACION DE PK
ALTER TABLE NACIONALIDAD ADD CONSTRAINT PK_NACIONALIDAD PRIMARY KEY (id_nacionalidad);

--insertar informacion
INSERT INTO NACIONALIDAD (id_nacionalidad, pais) VALUES (10, 'CHILENA');
INSERT INTO NACIONALIDAD (id_nacionalidad, pais) VALUES (20, 'ARGENTINA');
INSERT INTO NACIONALIDAD (id_nacionalidad, pais) VALUES (30, 'PERUANA');
INSERT INTO NACIONALIDAD (id_nacionalidad, pais) VALUES (40, 'BOLIVIANA');
INSERT INTO NACIONALIDAD (id_nacionalidad, pais) VALUES (50, 'BRASILEÑA');

-------------------------------------------------------------------------------------------------------------
CREATE TABLE REGION(
    id_region       NUMBER  (2)  NOT NULL,
    region          VARCHAR2(25) NOT NULL
);

--CREACION PK
ALTER TABLE REGION ADD CONSTRAINT PK_REGION PRIMARY KEY (id_region);

-- ingresar informscion // SE AGREGA REGIONES, YA QUE HABIA COMUNAS INGRESADAS SIN REGION
INSERT INTO REGION (id_region, region) VALUES (1, 'ARICA Y PAR. Y TARAPACA'); -- se ajusta el nombre ya que era muy largo
INSERT INTO REGION (id_region, region) VALUES (2, 'ANTOFAGASTA');
INSERT INTO REGION (id_region, region) VALUES (3, 'ATACAMA Y COQUIMBO');
INSERT INTO REGION (id_region, region) VALUES (5, 'VALPARAISO');
INSERT INTO REGION (id_region, region) VALUES (13, 'METROPOLITANA');
INSERT INTO REGION (id_region, region) VALUES (8, 'CONCEPCION');
INSERT INTO REGION (id_region, region) VALUES (16, 'CHILLAN');



----------------------------------------------------
CREATE TABLE COMUNA(
    id_comuna       NUMBER  (4)  GENERATED AS IDENTITY (START WITH 1050 INCREMENT BY 5) PRIMARY KEY,
    nom_comuna      VARCHAR2(20) NOT NULL,
    id_region       NUMBER  (2)  NOT NULL
);

-- CERACION PK Y FK
ALTER TABLE COMUNA ADD CONSTRAINT FK_COMUNA_REGION FOREIGN KEY (id_region) REFERENCES REGION (id_region);

--insertar informacion
INSERT INTO COMUNA (nom_comuna, id_region) VALUES ('Santiago', 13);
INSERT INTO COMUNA (nom_comuna, id_region) VALUES ('Valparaiso', 5);
INSERT INTO COMUNA (nom_comuna, id_region) VALUES ('Concepcion', 8);
INSERT INTO COMUNA (nom_comuna, id_region) VALUES ('Antofagasta', 2);
INSERT INTO COMUNA (nom_comuna, id_region) VALUES ('Chillan', 16);


------------------------------------------------------------------------------------
CREATE TABLE CLUB_FUTBOL(                  ----- se agrega id comuna, ya que se piden 2 tablas fuertes
    id_club     VARCHAR2 (4)  NOT NULL,     ---- dos tablas debiles, pero por los datos entregados
    nom_club    VARCHAR2 (50) NOT NULL,          -- solo habia una debil
    patrimonio  NUMBER   (10) NOT NULL,
    direccion   VARCHAR2 (100)NOT NULL,
    tipo_club   VARCHAR  (11) NOT NULL,
    id_comuna   NUMBER   (4) NOT NULL
);

--CREACIO PK
ALTER TABLE CLUB_FUTBOL ADD CONSTRAINT PK_CLUB_FUTBOL PRIMARY KEY (id_club);
ALTER TABLE CLUB_FUTBOL ADD CONSTRAINT FK_CLUB_FURBOL_COMUNA FOREIGN KEY (id_comuna) REFERENCES COMUNA (id_comuna);

-- CREACION DE SECUENCUA
CREATE SEQUENCE SEQ_CLUB_FUTBOL
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
--agregar informacion // se busca las direcciones para poder asignar la comuna, ya que esta la tabla comuna y no direccion
INSERT INTO CLUB_FUTBOL (id_club, nom_club, patrimonio, direccion, tipo_club, id_comuna) VALUES (SEQ_CLUB_FUTBOL.NEXTVAL, 'Colo-Colo', 500000000, 'Av. Marathon 5300', 'Profesional', 1050);
INSERT INTO CLUB_FUTBOL (id_club, nom_club, patrimonio, direccion, tipo_club, id_comuna) VALUES (SEQ_CLUB_FUTBOL.NEXTVAL, 'Universidad de Chile', 450000000, 'AV. El Parron 0931', 'Profesional', 1050);
INSERT INTO CLUB_FUTBOL (id_club, nom_club, patrimonio, direccion, tipo_club, id_comuna) VALUES (SEQ_CLUB_FUTBOL.NEXTVAL, 'Deportes Antofagasta', 180000000, 'Avenida Angamos 01606', 'Profesional', 1065);
INSERT INTO CLUB_FUTBOL (id_club, nom_club, patrimonio, direccion, tipo_club, id_comuna) VALUES (SEQ_CLUB_FUTBOL.NEXTVAL, 'Huachipato', 220000000, 'Avenida Desierto Garcia 909', 'Profesional', 1060);
INSERT INTO CLUB_FUTBOL (id_club, nom_club, patrimonio, direccion, tipo_club, id_comuna) VALUES (SEQ_CLUB_FUTBOL.NEXTVAL, 'Ñublense', 170000000, 'Avenida Pedro Aguirre Cerda 1003', 'Profesional', 1055);



    
--DROP
--DROP TABLE CLUB_FUTBOL;
--DROP TABLE COMUNA;
--DROP TABLE REGION;
--DROP TABLE NACIONALIDAD;
--DROP SEQUENCE SEQ_CLUB_FUTBOL;
    
-- ELEGIR LAS TABLAS   
SELECT * FROM NACIONALIDAD;  
SELECT * FROM REGION; 
SELECT * FROM COMUNA; 
SELECT * FROM CLUB_FUTBOL; 

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

CREATE TABLE ASOCIACION(
    id_asociacion    NUMBER(10),
    nombre_asociacion VARCHAR2(40),
    fecha_creacion    DATE,
    tipo_asociacion   CHAR(1),
    CONSTRAINT PK_ASOCIACION PRIMARY KEY (id_asociacion));
    
SELECT * FROM ASOCIACION;

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (1, 'Asociación de Fútbol de Santiago', TO_DATE('2001-05-15', 'YYYY-MM-DD'), 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (2, 'Asociación Nacional de Fútbol Amateur', TO_DATE('1998-03-10', 'YYYY-MM-DD'), 'A');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (3, 'Asociación de Fútbol de Valparaíso', TO_DATE('1987-07-21', 'YYYY-MM-DD'), 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (4, 'Asociación de Fútbol de Concepción', TO_DATE('1995-11-30', 'YYYY-MM-DD'), 'A');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (5, 'Asociación de Fútbol de Antofagasta', TO_DATE('2003-06-25', 'YYYY-MM-DD'), 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (6, 'Asociación de Fútbol de Temuco', TO_DATE('2010-01-12', 'YYYY-MM-DD'), 'A');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (7, 'Asociación de Fútbol de Rancagua', TO_DATE('1999-09-08', 'YYYY-MM-DD'), 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (8, 'Asociación de Fútbol de Puerto Montt', TO_DATE('2005-04-20', 'YYYY-MM-DD'), 'A');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (9, 'Asociación de Fútbol de La Serena', TO_DATE('2012-08-14', 'YYYY-MM-DD'), 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion) 
VALUES (10, 'Asociación de Fútbol de Chillán', TO_DATE('2018-12-01', 'YYYY-MM-DD'), 'A');

COMMIT;

----------------------------------------------------------------------------------------------
-- CASO 1:

--1.	Listar las asociaciones que sean de tipo profesional “P” y que hayan sido creadas posterior al año 2000. Estas deben ser ordenadas de manera descendente por la fecha de creación.

SELECT nombre_asociacion, fecha_creacion, tipo_asociacion
    FROM ASOCIACION
    WHERE tipo_asociacion = 'P';

-- 2.	Adicional a la información anterior, se necesita obtener cuales asociaciones de tipo amateurs “A” fueron creadas entre el año 1980 y el año 2009.  Se necesita que esto sea ordenado por fecha de creación de manera ascendente.

SELECT nombre_asociacion, fecha_creacion, tipo_asociacion
    FROM ASOCIACION
    WHERE tipo_asociacion = 'A'
    AND fecha_creacion BETWEEN TO_DATE('01-01-1980', 'DD-MM-YYYY') 
                            AND TO_DATE('31-12-2009', 'DD-MM-YYYY')
    ORDER BY fecha_creacion ASC;

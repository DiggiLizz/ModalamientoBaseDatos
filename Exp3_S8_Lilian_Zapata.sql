-- SUMATIVA 3
-- LILIAN ZAPATA
-- DROP ACTIVOS, NO CORRER COMPLETO

SHOW USER;

-- CREACION DE TABLAS FUERTES

CREATE TABLE PAIS(
    id_pais     NUMBER   (3) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pais        VARCHAR2 (30) NOT NULL
);

--SELECCION TABALA
SELECT * FROM PAIS;

-- ELIMINAR TABLA
DROP TABLE PAIS;

-- INGRESAR INFORMACION
INSERT INTO PAIS (pais) VALUES ('CHILE');
INSERT INTO PAIS (pais) VALUES ('BRASIL');
INSERT INTO PAIS (pais) VALUES ('USA');
INSERT INTO PAIS (pais) VALUES ('FRANCIA');
INSERT INTO PAIS (pais) VALUES ('PERU');

--------------------------------------------------------------------------
CREATE TABLE SERVICIO(
    cod_servicio    NUMBER   (3) NOT NULL,
    descripcion     VARCHAR2 (100) NOT NULL,
    costo           NUMBER   (7) NOT NULL
);

-- ALTERTABLE
ALTER TABLE SERVICIO ADD CONSTRAINT PK_SERVICIO PRIMARY KEY (cod_servicio);

--SELECCION DE TABBLA
SELECT * FROM SERVICIO;

-- CREAR SECUENCIA
CREATE SEQUENCE SEQ_SERVICIO
    START WITH 100
    INCREMENT BY 5
    NOCACHE;
    
-- ELIMIANR SECUENCIA Y TABLA
DROP SEQUENCE SEQ_SERVICIO;
DROP TABLE SERVICIO;
    
-- INGRESAR INFORMACION
INSERT INTO SERVICIO (cod_servicio, descripcion, costo) VALUES (100, 'PINTURA', 156000);
INSERT INTO SERVICIO (cod_servicio, descripcion, costo) VALUES (105, 'CAMBIO LUCES', 45000);
INSERT INTO SERVICIO (cod_servicio, descripcion, costo) VALUES (110, 'DESABOLLADURA', 67000);
INSERT INTO SERVICIO (cod_servicio, descripcion, costo) VALUES (115, 'REVISION FRENOS', 30000);
INSERT INTO SERVICIO (cod_servicio, descripcion, costo) VALUES (120, 'CAMBIO PUERTA TRASERA', 50000);

----------------------------------------------------------------

CREATE TABLE MARCA(
    id_marca     NUMBER  (2) NOT NULL,
    descripcion  VARCHAR2(20) NOT NULL
);

-- ALTERAR TABLA
ALTER TABLE MARCA ADD CONSTRAINT PK_MARCA PRIMARY KEY (id_marca);

-- SELECCIONAR TABLA
SELECT * FROM MARCA;

-- CREAR SECUENCIA
CREATE SEQUENCE SEQ_MARCA
    START WITH 5
    INCREMENT BY 10
    NOCACHE;
    
-- ELIMINAR SECUENXIA Y TABLA
DROP SEQUENCE SEQ_MARCA;
DROP TABLE MARCA;
    
-- AGREGAR INFROMACION
INSERT INTO MARCA (id_marca, descripcion) VALUES (5, 'HYUNDAI');
INSERT INTO MARCA (id_marca, descripcion) VALUES (15, 'HONDA');
INSERT INTO MARCA (id_marca, descripcion) VALUES (25, 'KIA');
INSERT INTO MARCA (id_marca, descripcion) VALUES (35, 'CHEVROLET');
INSERT INTO MARCA (id_marca, descripcion) VALUES (45, 'FIAT');

------------------------------------------------------------------

CREATE TABLE TIPO_AUTOMOVIL(
    id_automovil      NUMBER   (2) NOT NULL,
    descripcion       VARCHAR2 (20) NOT NULL
);

--PK
ALTER TABLE TIPO_AUTOMOVIL ADD CONSTRAINT PK_TIPO_AUTOMOVIL PRIMARY KEY (id_automovil);

-- SELECCION TABLA
SELECT * FROM TIPO_AUTOMOVIL;

-- ELIMINAR TABLA
DROP TABLE TIPO_AUTOMOVIL;

-----------------------------------------------------------
CREATE TABLE CLIENTE(
    rut         NUMBER  (8) NOT NULL,
    dv          CHAR    (1) NOT NULL,
    p_nombre    VARCHAR2(20) NOT NULL,
    s_nombre    VARCHAR2(20),
    a_paterno   VARCHAR2(20) NOT NULL,
    a_materno   VARCHAR2(20) NOT NULL,
    telefono    VARCHAR2(12),
    email       VARCHAR2(40),
    tipo_cli    CHAR    (1) NOT NULL
);

-- CRECAION DE PK
ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE PRIMARY KEY (rut);

-- VERIFICACION DE DV
ALTER TABLE CLIENTE ADD CONSTRAINT CK_DV CHECK (dv IN (1, 2, 3, 4, 5, 6, 7, 8, 9,'K'));

--UNCIICDAD EMAIL
ALTER TABLE CLIENTE ADD CONSTRAINT UN_EMAIL UNIQUE (email);

-- SELECCION
SELECT * FROM CLIENTE;

--ELIMIANR TABALA
DROP TABLE CLIENTE;

--------------------------------------------------------------------------------------------

-- CREACION TABLAS INTERMEDIAS DEBILES (DEPENDE DE POCAS FUERTES)

CREATE TABLE CIUDAD(
    id_ciudad   NUMBER   (3) NOT NULL,
    nombre      VARCHAR2 (30) NOT NULL,
    id_pais     NUMBER   (3) NOT NULL
);

-- ALTERACIONDE TABLA PK
ALTER TABLE CIUDAD ADD CONSTRAINT PK_CIUDAD PRIMARY KEY (id_ciudad);

-- ALTERACION TABLA FK
ALTER TABLE CIUDAD ADD CONSTRAINT FK_CIUDAD_PAIS FOREIGN KEY (id_pais) REFERENCES PAIS (id_pais);

--SELECCION DE LA TABLA
SELECT * FROM CIUDAD;

-- INGRESO DE DATOS
INSERT INTO CIUDAD (id_ciudad, nombre, id_pais) VALUES (1, 'SANTIAGO', 1);
INSERT INTO CIUDAD (id_ciudad, nombre, id_pais) VALUES (2, 'PARIS', 4);
INSERT INTO CIUDAD (id_ciudad, nombre, id_pais) VALUES (3, 'OHIO', 3);
INSERT INTO CIUDAD (id_ciudad, nombre, id_pais) VALUES (4, 'LIMA', 5);
INSERT INTO CIUDAD (id_ciudad, nombre, id_pais) VALUES (5, 'SAO PAULO', 2);

--ELIMIANR TABLA
DROP TABLE CIUDAD;

---------------------------------------------------------------------------------------------

CREATE TABLE SUCURSAL(
    codigo          NUMBER   (3) NOT NULL,
    nom_sucursal    VARCHAR2 (20)NOT NULL,
    calle           VARCHAR2 (20)NOT NULL, 
    num_calle       NUMBER   (4) NOT NULL,
    id_ciudad       NUMBER   (3) NOT NULL
);

--ALTERACION PK
ALTER TABLE SUCURSAL ADD CONSTRAINT PK_SUCURSAL PRIMARY KEY (codigo);

--ALTERACION FK
ALTER TABLE SUCURSAL ADD CONSTRAINT FK_SUCURSAL_CIUDAD FOREIGN KEY (id_ciudad) REFERENCES CIUDAD (id_ciudad);

-- SELECCION DE LA TABLA
SELECT * FROM SUCURSAL;

-- ELIMINAR LA TABLA
DROP TABLE SUCURSAL;

-- INGRESAR INFORMACION
INSERT INTO SUCURSAL (codigo, nom_sucursal, calle, num_calle, id_ciudad) VALUES (1, 'PROVIDENCIA', 'A. VARAS', 234, 1);
INSERT INTO SUCURSAL (codigo, nom_sucursal, calle, num_calle, id_ciudad) VALUES (2, 'LAS 4 ESQUINAS', 'AV. LATINA', 234, 5);
INSERT INTO SUCURSAL (codigo, nom_sucursal, calle, num_calle, id_ciudad) VALUES (3, 'CENTRO', 'TEATINOS', 234, 1);

----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE MECANICO(
    cod_mecanico     NUMBER   (5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    p_nombre        VARCHAR2 (20) NOT NULL,
    s_nombre        VARCHAR2 (20) NOT NULL,
    a_paterno       VARCHAR2 (20) NOT NULL,
    a_materno       VARCHAR2 (20) NOT NULL,
    bono_jefatura   NUMBER   (10),
    sueldo          NUMBER   (10) NOT NULL,
    monto_impuestos NUMBER   (10) NOT NULL,
    cod_supervisor  NUMBER   (5)
);

--ALTER FK
ALTER TABLE MECANICO ADD CONSTRAINT FK_MECANICO_MECANICO FOREIGN KEY (cod_supervisor) REFERENCES MECANICO (cod_mecanico);

--CHECK SUELDO MINIMO
ALTER TABLE MECANICO ADD CONSTRAINT CK_SUELDO CHECK (sueldo > 510000);

--SELECCION DE LA TABLA
SELECT * FROM MECANICO;

--EÑIMANR TABLA
DROP TABLE MECANICO;

--INSERTAR INFROMACION
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('JORGE', 'PABLO', 'SOTO', 'SIERRE',5400000 ,2759000 ,223580 , NULL);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('PEDRO', 'JOSE', 'MANRRIQUEZ', 'CORRAL',NULL ,759000 ,23980 , 2);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('SANDRA', 'JOSEFA', 'LETELIER', 'S.',0 ,659000 ,22350 , 2);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('FELIPE', 'M.', 'VIDAL', 'A.',NULL ,759000 ,23580 , 2);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('JOSE', 'MIGUEL', 'TRONCOSO', 'B.',NULL ,659000 ,44580 , 2);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('JUAN', 'PABLO', 'SANCHEZ', 'R.',NULL ,859000 ,23380 , 2);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('CARLOS', 'FELIPE', 'SOTO', 'J.',0 ,597000 ,23580 , 2);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('ALBERTO', 'P.', 'CERDA', 'RAMIREZ',NULL ,559000 ,22380 , 2);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('ALEJANDRA', 'GIROGINA', 'R.', 'SIERRE',NULL ,659000 ,22380 , 2);
INSERT INTO MECANICO (p_nombre, s_nombre, a_paterno, a_materno, bono_jefatura, sueldo, monto_impuestos, cod_supervisor) VALUES ('ROBERTO', 'PATRICIO', 'GIANELLI', 'SOSA',NULL ,859000 ,22380 , 2);


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE MODELO(
    id_modelo   NUMBER  (5) NOT NULL,
    id_marca    NUMBER  (2) NOT NULL,
    descripcion VARCHAR2(20) NOT NULL
);

--ALTERACION PK
ALTER TABLE MODELO ADD CONSTRAINT PK_MODELO PRIMARY KEY (id_modelo);

-- alteracion fk
ALTER TABLE MODELO ADD CONSTRAINT FK_MODELO_MARCA FOREIGN KEY (id_marca) REFERENCES MARCA (id_marca);

-- SELLECCION DE LA TABLA
SELECT * FROM MODELO;

--ELIMINARA TABLA
DROP TABLE MODELO;

-----------------------------------------------------------------------------------------------------------

--CREACION TABLAS DEBILES
CREATE TABLE AUTOMOVIL(
    patente      CHAR    (8) NOT NULL,
    año          NUMBER  (4) NOT NULL,
    cant_puertas NUMBER  (1) NOT NULL,
    km           NUMBER  (6) NOT NULL,
    color        VARCHAR2(30) NOT NULL,
    id_automovil NUMBER  (2) NOT NULL,
    id_modelo    NUMBER  (5) NOT NULL,
    id_marca     NUMBER  (2) NOT NULL,
    rut_cli      NUMBER  (8) NOT NULL
);

-- ALTERACION PK
ALTER TABLE AUTOMOVIL ADD CONSTRAINT PK_AUTOMOVIL PRIMARY KEY (patente);

--SELECCION DE TABLA
SELECT * FROM AUTOMOVIL;

--ELIMIANR TABLA
DROP TABLE AUTOMOVIL;

--alteracion fk
ALTER TABLE AUTOMOVIL ADD CONSTRAINT FK_AUTOMOVIL_TIPO_AUTOMOVIL FOREIGN KEY (id_automovil) REFERENCES TIPO_AUTOMOVIL (id_automovil);
ALTER TABLE AUTOMOVIL ADD CONSTRAINT FK_AUTOMOVIL_MODELO FOREIGN KEY (id_modelo) REFERENCES MODELO (id_modelo);
ALTER TABLE AUTOMOVIL ADD CONSTRAINT FK_AUTOMOVIL_MARCA FOREIGN KEY (id_marca) REFERENCES MARCA (id_marca);
ALTER TABLE AUTOMOVIL ADD CONSTRAINT FK_AUTOMOVIL_CLIENTE FOREIGN KEY (rut_cli) REFERENCES CLIENTE (rut);

--------------------------------------------------------------------------------------------------------------

CREATE TABLE MANTENCION(
    num_mantencion NUMBER (4) NOT NULL,
    cod_sucursal   NUMBER (3) NOT NULL,
    fec_ingreso    DATE       NOT NULL,
    fec_salida     DATE       NOT NULL,
    fec_entrega    DATE       NOT NULL,
    patente_auto   NUMBER (8) NOT NULL,
    cod_mecanico   NUMBER (5) NOT NULL,
    costo_total   NUMBER (7) NOT NULL
);

--ALTERACION PK
ALTER TABLE MANTENCION ADD CONSTRAINT PK_MANTENCION PRIMARY KEY (num_mantencion, cod_sucursal);

--alteracion de patente, ya que en automovil es char y aqui number, no hay congruencia en la informacion
ALTER TABLE MANTENCION MODIFY patente_auto CHAR(8);

-- ALTERACION FK
ALTER TABLE MANTENCION ADD CONSTRAINT FK_MANTENCION_AUTOMOVIL FOREIGN KEY (patente_auto) REFERENCES AUTOMOVIL (patente);
ALTER TABLE MANTENCION ADD CONSTRAINT FK_MANTENCION_MECANICO FOREIGN KEY (cod_mecanico) REFERENCES MECANICO (cod_mecanico);

-- eliminacion de costo_total
ALTER TABLE MANTENCION DROP COLUMN costo_total;
 
-- SELECCION TABLA
SELECT * FROM MANTENCION;

-- ELIMAINR TABLA
DROP TABLE MANTENCION;

-------------------------------------------------------------------------

CREATE TABLE NORMALL( -- SE USA NORMAL CON 2 L, YA QUE AL TENER SOLO UNA, LA MARCA COMO PALABRA RESERVADA
    rut                 NUMBER (8) NOT NULL,
    puntaje_fidelidad   NUMBER (10)NOT NULL
);

--alteracion tabla pk
ALTER TABLE NORMALL ADD CONSTRAINT PK_NORMALL PRIMARY KEY (rut);

--SELECCION TABLA
SELECT * FROM NORMALL;

-- ELIMIANR TABLA
DROP TABLE NORMALL;

-------------------------------------------------------------------------
CREATE TABLE PREMIUM(
    rut             NUMBER (8) NOT NULL,
    pesos_clientes  NUMBER (10) NOT NULL,
    monto_credito   NUMBER (10)
);

-- ALTERACION PK
ALTER TABLE PREMIUM ADD CONSTRAINT PK_PREMIUM PRIMARY KEY (rut);

-- seleccion de tabla
SELECT * FROM PREMIUM;

-- ELIMIANR TABLA
DROP TABLE PREMIUM;

-------------------------------------------------------------------------
CREATE TABLE DETALLES_SERVICIO(
    num_mantencion     NUMBER (4) NOT NULL,
    codigo_mantencion  NUMBER (3) NOT NULL,
    cod_servicio       NUMBER (3) NOT NULL,
    descuento_servicio NUMBER (4,3) NOT NULL,
    cantidad           NUMBER (3) NOT NULL
);

--ALTERCAION PK
ALTER TABLE DETALLES_SERVICIO ADD CONSTRAINT PK_DETALLES_SERVICIO PRIMARY KEY (num_mantencion, codigo_mantencion, cod_servicio);

-- seleccion tabla
SELECT * FROM DETALLES_SERVICIO;

-- ELIMINAR TABLA
DROP TABLE DETALLES_SERVICIO;


-------------------------------------------------------------------------

--EJERCICIOS

--CASE 1: Se requiere obtener un listado de los mecánicos cuyo bono de jefatura es nulo y cuyo monto
--de impuestos es inferior a 40.000 pesos

SELECT 
    cod_mecanico,
    p_nombre || ' ' || a_paterno AS NOMBRE_MECANICO, --concatenacion de datos mecanico
    sueldo,
    monto_impuestos AS IMPUESTO_ACTUAL,
    monto_impuestos * 0.8 AS IMPUESTO_REBAJADO,  -- se obtiene el 80%, si lo hacia con resta me daba otra valor en rebajodo xp
    sueldo - (monto_impuestos * 0.8) AS SUELDO_CON_REBAJA_IMPUESTOS
    FROM MECANICO
    WHERE bono_jefatura IS NULL AND monto_impuestos <40000  -- muestra solo los null e impuetsos menos a 40000
    ORDER BY monto_impuestos ASC, a_paterno ASC;



--CASE 2: e requiere realizar un ajuste salarial del 5% a los mecánicos que tienen un sueldo entre
--600 mil y 900 mil pesos, o aquellos que no tienen un supervisor asignado. El ajuste salarial
--debe mostrarse junto con el sueldo actual y el sueldo reajustado


SELECT
    cod_mecanico,
    p_nombre || ' ' || s_nombre || ' ' || a_paterno AS MECANICO, -- pese que pide nombre completom no piden apellido materno
    sueldo AS SUELDO_ACTUAL,
    sueldo * 0.05 AS AJUSTE, -- se saca el 5%
    sueldo + (sueldo * 0.05) AS SUELDO_REAJUSTADO  -- se suma el 5% al sueldo
    FROM MECANICO
    WHERE sueldo BETWEEN 600000 AND 900000 OR cod_supervisor IS NULL -- valores enter 600 900 mil y nulos
    ORDER BY sueldo ASC, a_paterno ASC;
















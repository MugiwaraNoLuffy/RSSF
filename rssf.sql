CREATE TABLE no
(
  idNo serial NOT NULL,
  serial character varying(16) NOT NULL,
  name character varying(10) NOT NULL,
  latitude character varying(6) DEFAULT NULL::character varying,
  longitude character varying(6) DEFAULT NULL::character varying,
  altitude character varying(6) DEFAULT NULL::character varying,
  CONSTRAINT no_pkey PRIMARY KEY (id_pk )
)

CREATE TABLE tipo
(
  idTipo serial NOT NULL,
  tipo character varying(15) NOT NULL,
  CONSTRAINT tipo_pkey PRIMARY KEY (idtipo )
)

CREATE TABLE Sensor (
idSensor serial primary key NOT NULL,
idNo_fk integer NOT NULL,
idTipo_fk integer NOT NULL
)

CREATE TABLE Amostra (
idAmostra serial primary key NOT NULL,
idSensor_fk integer NOT NULL,
valor integer NOT NULL,
timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)



select sensor.id_pk from sensor inner join no on (no.id_pk = sensor.idno_fk) where no.serial = '0013a2004078ecdd' and sensor.idtipo_fk=2 
 
 ALTER SEQUENCE tipo_idtipo_seq RESTART WITH 1;
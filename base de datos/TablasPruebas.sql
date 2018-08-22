CREATE DATABASE EasyCredit

create table Usuario(
IdUsuario SERIAL PRIMARY KEY NOT NULL,
Nombre VARCHAR(20) NOT NULL,
fec_inserccion timestamp DEFAULT timenow() NOT NULL
);

create table Solicitud(
IdSolicitud SERIAL  NOT NULL,
IdUsuario INT NOT NULL,
Monto REAL NOT NULL,
Edad INT NOT NULL,
TarjetaDeCredito BOOLEAN NOT NULL,
PlazoDeInteres REAL NOT NULL,
ProcesoDeAutorizacion BOOLEAN DEFAULT NULL,
fec_Creacion timestamp DEFAULT timenow() NOT NULL,
fec_Aceptacion timestamp 
);

INSERT INTO Usuario(Nombre) VALUES('david');

INSERT INTO Solicitud(IdUsuario,
Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion)
VALUES('1','100','20',TRUE,'7',NULL);


drop table Usuario;

drop table Solicitud;


DELETE from Solicitud where id = '1'
DELETE from Usuario where id = '1'
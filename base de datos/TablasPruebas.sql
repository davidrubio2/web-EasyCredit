CREATE DATABASE EasyCredit

create table Usuario(
IdUsuario SERIAL PRIMARY KEY NOT NULL,
Nombre VARCHAR(20) NOT NULL,
fec_Inserccion TIMESTAMP DEFAULT TIMENOW() NOT NULL
);

create table Solicitud(
IdSolicitud SERIAL  NOT NULL,
IdUsuario INT NOT NULL,
Monto REAL NOT NULL,
Edad INT NOT NULL,
TarjetaDeCredito VARCHAR(10) NOT NULL,
PlazoDeInteres REAL NOT NULL,
ProcesoDeAutorizacion varchar(10) DEFAULT ('PENDIENTE'),
fec_Creacion TIMESTAMP DEFAULT TIMENOW() NOT NULL,
fec_Aceptacion TIMESTAMP 
);

pendiente
aceptada
rechazada
INSERT INTO Usuario(Nombre) VALUES('david');

INSERT INTO Solicitud(IdUsuario,
Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion)
VALUES('1','100','20',TRUE,'7',NULL);


drop table Usuario;

drop table Solicitud;


DELETE from Solicitud where id = '1'
DELETE from Usuario where id = '1'
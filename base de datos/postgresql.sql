create table Usuario(
ID SERIAL PRIMARY KEY NOT NULL,
Usuario VARCHAR(20) NOT NULL
);

create table Solicitud(
ID SERIAL  NOT NULL,
Monto REAL NOT NULL,
Edad INT NOT NULL,
TarjetaDeCredito BOOLEAN NOT NULL,
PlazoDeInteres REAL NOT NULL,
ProcesoDeAutorizacion BOOLEAN DEFAULT NULL
);

INSERT INTO Usuario(Usuario) VALUES('david');
INSERT INTO Solicitud(ID,Monto,Edad,TarjetaDeCredito,PlazoDeInteres)
VALUES('1','100','18',TRUE,'4');
drop table Usuario;
drop table Solicitud;


DELETE from Solicitud where id = '1'
DELETE from Usuario where id = '1'
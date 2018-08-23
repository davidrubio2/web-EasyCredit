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
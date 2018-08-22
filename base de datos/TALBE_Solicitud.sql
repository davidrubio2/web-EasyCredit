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
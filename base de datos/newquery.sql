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
ProcesoDeAutorizacion BOOLEAN NOT NULL
);

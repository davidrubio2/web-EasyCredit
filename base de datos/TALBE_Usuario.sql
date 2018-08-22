create table Usuario(
IdUsuario SERIAL PRIMARY KEY NOT NULL,
Nombre VARCHAR(20) NOT NULL,
fec_inserccion timestamp DEFAULT timenow() NOT NULL
);
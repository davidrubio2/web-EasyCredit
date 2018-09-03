CREATE OR REPLACE FUNCTION fun_instalar_tablas_credito()
RETURNS smallint AS
$BODY$
DECLARE
	iExiste	integer default 0;
BEGIN	

	--TALBE_Solicitud.SQL
		SELECT count(table_name) into iExiste  FROM information_schema.tables where lower(table_name) = lower('Usuario');
		IF (iExiste = 0) THEN		
			create table Usuario(
			IdUsuario SERIAL PRIMARY KEY NOT NULL,
			Nombre VARCHAR(20) NOT NULL,
			fec_Inserccion TIMESTAMP DEFAULT TIMENOW() NOT NULL);
		END IF;	
		iExiste = 0;
		
		--TALBE_Usuario.SQL
		SELECT count(table_name) into iExiste  FROM information_schema.tables where lower(table_name) = lower('Solicitud');
		IF (iExiste = 0) THEN		
			create table Solicitud(
				IdSolicitud SERIAL  NOT NULL,
				IdUsuario INT NOT NULL,
				Monto REAL NOT NULL,
				Edad INT NOT NULL,
				TarjetaDeCredito VARCHAR(10) NOT NULL,
				PlazoDeInteres REAL NOT NULL,
				ProcesoDeAutorizacion varchar(10) DEFAULT ('PENDIENTE'),
				fec_Creacion TIMESTAMP DEFAULT TIMENOW() NOT NULL,
				fec_Aceptacion TIMESTAMP);
		END IF;	
		iExiste = 0;
		
		return 1;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;


SELECT fun_instalar_tablas_credito();
DROP FUNCTION fun_instalar_tablas_credito();

CREATE OR REPLACE FUNCTION fun_InstalarFunciones()
	RETURNS VOID AS
$BODY$

BEGIN
	-- fun_AceptarSolicitud.sql
	PERFORM proname  FROM pg_proc WHERE proname = 'fun_aceptarsolicitud';
	IF found THEN
		DROP FUNCTION fun_AceptarSolicitud();
	END IF;

	-- fun_ConsultarGrabarUsuario.sql
	PERFORM proname   FROM pg_proc WHERE proname = 'fun_consultargrabarusuario';
	IF  found THEN
		DROP FUNCTION fun_ConsultarGrabarUsuario(usuario TEXT);
	END IF;

	-- fun_ConsultarPerfil.sql
	PERFORM proname FROM pg_proc WHERE proname = 'fun_consultarperfil';
	IF  found THEN
		DROP FUNCTION fun_ConsultarPerfil(Id Int);
	END IF;
	
		-- fun_ConsultarSolicitudesPendientes.sql
	PERFORM proname  FROM pg_proc WHERE proname = 'fun_consultarsolicitudespendientes';
	IF  found THEN
		DROP FUNCTION fun_ConsultarSolicitudesPendientes(Id Int);
	END IF;
	
		-- fun_ConsultarSolicitudHistorial.sql
	PERFORM proname FROM pg_proc WHERE proname = 'fun_consultarsolicitudhistorial';
	IF  found THEN
		DROP FUNCTION fun_ConsultarSolicitudHistorial(Id Int);
	END IF;
	
	
		-- fun_NuevaSolicitud.sql
	PERFORM proname  FROM pg_proc WHERE proname = 'fun_nuevasolicitud';
	IF  found THEN
		DROP FUNCTION fun_NuevaSolicitud(Id Int,Monto real, Edad int, TarjetaDeCredito varchar(10),PlazoDeInteres real);
	END IF;
	

END;
$BODY$
	LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;


	

SELECT fun_InstalarFunciones();
DROP FUNCTION fun_InstalarFunciones();



CREATE FUNCTION fun_AceptarSolicitud()
RETURNS boolean AS $$
DECLARE
fun_IdSolicitud int;
fun_Edad int;
fun_TarjetaDeCredito VARCHAR(10);
var_ProcesoPendiente  VARCHAR(10);
var_ProcesoAceptada  VARCHAR(10);
var_ProcesoRechazada  VARCHAR(10);
var_SiTieneTarjeta VARCHAR(10);
BEGIN
var_ProcesoPendiente := 'PENDIENTE';
var_ProcesoAceptada  :='ACEPTADA';
var_ProcesoRechazada := 'RECHAZADA';
var_SiTieneTarjeta :='SI TIENE';

       select IdSolicitud INTO fun_IdSolicitud from Solicitud where ProcesoDeAutorizacion = var_ProcesoPendiente;
       if fun_IdSolicitud is null
		then
			RETURN false;
		else
			select IdSolicitud,edad,TarjetaDeCredito INTO fun_IdSolicitud,fun_Edad,fun_TarjetaDeCredito  from Solicitud  WHERE ProcesoDeAutorizacion = var_ProcesoPendiente order by fec_creacion asc limit 1;
			if fun_Edad >= 20 and fun_TarjetaDeCredito = var_SiTieneTarjeta
				then
					update Solicitud set ProcesoDeAutorizacion = var_ProcesoAceptada,  fec_Aceptacion = timenow()  where IdSolicitud = fun_IdSolicitud;
					RETURN true;
				else
				        update Solicitud set ProcesoDeAutorizacion = var_ProcesoRechazada,  fec_Aceptacion = timenow() where IdSolicitud = fun_IdSolicitud;
					RETURN true;
					END IF;
			RETURN true;
			END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE FUNCTION fun_ConsultarGrabarUsuario(usuario TEXT)
RETURNS int AS $$
DECLARE

fun_nombre ALIAS FOR $1;
fun_id int;

BEGIN
        select IdUsuario INTO fun_id from  Usuario where Nombre = fun_nombre;
	if fun_id is null
		then
			INSERT INTO Usuario(Nombre) VALUES(fun_nombre); 
			select IdUsuario INTO fun_id from  Usuario where Nombre = fun_nombre;
			RETURN fun_id;
		else
		RETURN fun_id;
		END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;

CREATE FUNCTION fun_ConsultarPerfil(Id Int)
 RETURNS TABLE (
 val_Nombre varchar(20),
 val_Monto real,
 val_Edad int,
 val_TarjetaDeCredito varchar(10),
 val_PlazoDeInteres real,
 val_ProcesoDeAutorizacion varchar(10)
) 
AS $$
DECLARE 
var_ProcesoPendiente  VARCHAR(10);
fun_IdSolicitud int;

BEGIN
var_ProcesoPendiente := 'PENDIENTE';

  select IdSolicitud INTO fun_IdSolicitud from Solicitud where ProcesoDeAutorizacion = var_ProcesoPendiente;
       if fun_IdSolicitud is null
		then

		RETURN QUERY 
			select Nombre, null::real  as  fake, null::int as fake, null::varchar as fake, null::real as fake, null::varchar as fake
			from  Usuario where
			  idusuario = Id;
			
		else
		RETURN QUERY 
			select Usuario.Nombre, Solicitud.Monto,Solicitud.Edad,Solicitud.TarjetaDeCredito,Solicitud.PlazoDeInteres,Solicitud.ProcesoDeAutorizacion 
			from  Solicitud 
			 inner join  Usuario  on Usuario.idusuario = Solicitud.idusuario where
			  Usuario.idusuario = Id and Solicitud.ProcesoDeAutorizacion = var_ProcesoPendiente  order by Solicitud.fec_creacion desc limit 1;
		
END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;

CREATE FUNCTION fun_ConsultarSolicitudesPendientes(Id Int)
 RETURNS TABLE (
 val_Monto real,
 val_Edad int,
 val_TarjetaDeCredito varchar(10),
 val_PlazoDeInteres real,
 val_ProcesoDeAutorizacion varchar(10)
) 
AS $$
DECLARE 
var_ProcesoPendiente  VARCHAR(10);

BEGIN
var_ProcesoPendiente := 'PENDIENTE';

RETURN QUERY SELECT
	 Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion from  Solicitud where ProcesoDeAutorizacion = var_ProcesoPendiente and IdUsuario = Id;       
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE FUNCTION fun_ConsultarSolicitudHistorial(Id Int)
 RETURNS TABLE (
 val_Monto real,
 val_Edad int,
 val_TarjetaDeCredito VARCHAR(10),
 val_PlazoDeInteres real,
 val_ProcesoDeAutorizacion VARCHAR(10)
) 
AS $$
DECLARE 
var_ProcesoPendiente  VARCHAR(10);

BEGIN
var_ProcesoPendiente := 'PENDIENTE';

RETURN QUERY SELECT
	 Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion from  Solicitud where ProcesoDeAutorizacion != var_ProcesoPendiente and IdUsuario = Id order by fec_creacion desc;       
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE FUNCTION fun_NuevaSolicitud(Id Int,Monto real, Edad int, TarjetaDeCredito varchar(10),PlazoDeInteres real  )
RETURNS boolean AS $$
DECLARE

fun_Id ALIAS FOR $1;
fun_Monto  ALIAS FOR $2;
fun_Edad  ALIAS FOR $3;
fun_TarjetaDeCredito ALIAS FOR $4;
fun_PlazoDeInteres ALIAS FOR $5;


BEGIN

       select IdUsuario INTO fun_id from  Usuario where IdUsuario = fun_Id;
       if fun_Id is null
		then
			RETURN false;
		else
		  INSERT INTO Solicitud(IdUsuario,Monto,Edad,TarjetaDeCredito,PlazoDeInteres)
		  VALUES(fun_Id,fun_Monto,fun_Edad,fun_TarjetaDeCredito,fun_PlazoDeInteres);
		  RETURN true;
		  END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;

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
SECURITY DEFINER


select usuario('david')

drop function usuario

CREATE FUNCTION fun_NuevaSolicitud(Id Int,Monto real, Edad int, TarjetaDeCredito boolean,PlazoDeInteres real, ProcesoDeAutorizacion boolean  )
RETURNS boolean AS $$
DECLARE

fun_Id ALIAS FOR $1;
fun_Monto  ALIAS FOR $2;
fun_Edad  ALIAS FOR $3;
fun_TarjetaDeCredito ALIAS FOR $4;
fun_PlazoDeInteres ALIAS FOR $5;
fun_ProcesoDeAutorizacion ALIAS FOR $6;


BEGIN

       select IdUsuario INTO fun_id from  Usuario where IdUsuario = fun_Id;
       if fun_Id is null
		then
			RETURN false;
		else
		  INSERT INTO Solicitud(IdUsuario,Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion)
		  VALUES(fun_Id,fun_Monto,fun_Edad,fun_TarjetaDeCredito,fun_PlazoDeInteres,fun_ProcesoDeAutorizacion);
		  RETURN true;
		  END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER

drop function fun_NuevaSolicitud;

INSERT INTO Solicitud(IdUsuario,
Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion)
VALUES('2','100','20',TRUE,'7',NULL);

select fun_NuevaSolicitud('2','100','20',FALSE,'7',NULL)

CREATE FUNCTION fun_AceptarSolicitud()
RETURNS boolean AS $$
DECLARE
fun_IdSolicitud int;
fun_Edad int;
fun_TarjetaDeCredito boolean;

BEGIN

       select IdSolicitud INTO fun_IdSolicitud from Solicitud where ProcesoDeAutorizacion IS NULL;
       if fun_IdSolicitud is null
		then
			RETURN false;
		else
			select IdSolicitud,edad,TarjetaDeCredito INTO fun_IdSolicitud,fun_Edad,fun_TarjetaDeCredito  from Solicitud  WHERE ProcesoDeAutorizacion IS NULL order by fec_Aceptacion limit 1;
			if fun_Edad >= 20 and fun_TarjetaDeCredito is TRUE
				then
					update Solicitud set ProcesoDeAutorizacion = TRUE ,  fec_Aceptacion = timenow()  where IdSolicitud = fun_IdSolicitud;
					RETURN true;
				else
				        update Solicitud set ProcesoDeAutorizacion = FALSE ,  fec_Aceptacion = timenow() where IdSolicitud = fun_IdSolicitud;
					RETURN true;
					END IF;
			RETURN true;
			END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER


drop function fun_AceptarSolicitud;

select fun_AceptarSolicitud();


Solicitud 

select *
from Solicitud WHERE ProcesoDeAutorizacion IS NULL order by fec_Aceptacion limit 1;

UPDATE Solicitud set ProcesoDeAutorizacion = TRUE ,  fec_Aceptacion = timenow()  where IdSolicitud = '3';


CREATE FUNCTION fun_ConsultarSolicitudHistorial(Id Int)
RETURNS table AS $$
DECLARE
fun_Id ALIAS FOR $1;

BEGIN
	select * from  Solicitud where ProcesoDeAutorizacion is not NULL and IdUsuario = fun_Id;       
	if fun_IdSolicitud is null
       then
			RETURN false;
        else
      
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER

select * from  Solicitud where ProcesoDeAutorizacion is not NULL and IdUsuario = '1'
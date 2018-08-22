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
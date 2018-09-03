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
SECURITY DEFINER
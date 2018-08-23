CREATE FUNCTION fun_AceptarSolicitud()
RETURNS boolean AS $$
DECLARE
fun_IdSolicitud int;
fun_Edad int;
fun_TarjetaDeCredito VARCHAR(10);
var_PocesoPendiente  VARCHAR(10);
var_PocesoAceptada  VARCHAR(10);
var_PocesoRechazada  VARCHAR(10);
var_SiTieneTarjeta VARCHAR(10);
var_NoTieneTarjeta  VARCHAR(10);
BEGIN
var_PocesoPendiente := 'PENDIENTE';
var_PocesoAceptada  :='ACEPTADA';
var_PocesoRechazada := 'RECHAZADA';
var_SiTieneTarjeta :='SI TIENE';
var_NoTieneTarjeta := 'NO TIENE';

       select IdSolicitud INTO fun_IdSolicitud from Solicitud where ProcesoDeAutorizacion = var_PocesoPendiente;
       if fun_IdSolicitud is null
		then
			RETURN false;
		else
			select IdSolicitud,edad,TarjetaDeCredito INTO fun_IdSolicitud,fun_Edad,fun_TarjetaDeCredito  from Solicitud  WHERE ProcesoDeAutorizacion = var_PocesoPendiente order by fec_creacion asc limit 1;
			if fun_Edad >= 20 and fun_TarjetaDeCredito = var_SiTieneTarjeta
				then
					update Solicitud set ProcesoDeAutorizacion = var_PocesoAceptada,  fec_Aceptacion = timenow()  where IdSolicitud = fun_IdSolicitud;
					RETURN true;
				else
				        update Solicitud set ProcesoDeAutorizacion = var_PocesoRechazada,  fec_Aceptacion = timenow() where IdSolicitud = fun_IdSolicitud;
					RETURN true;
					END IF;
			RETURN true;
			END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
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
var_PocesoPendiente  VARCHAR(10);
fun_IdSolicitud int;

BEGIN
var_PocesoPendiente := 'PENDIENTE';

  select IdSolicitud INTO fun_IdSolicitud from Solicitud where ProcesoDeAutorizacion = var_PocesoPendiente;
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
			  Usuario.idusuario = Id and Solicitud.ProcesoDeAutorizacion = var_PocesoPendiente  order by Solicitud.fec_creacion desc limit 1;
		
END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
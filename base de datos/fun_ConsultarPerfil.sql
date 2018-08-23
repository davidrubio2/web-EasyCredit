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

BEGIN
var_PocesoPendiente := 'PENDIENTE';

RETURN QUERY 
select Usuario.Nombre, Solicitud.Monto,Solicitud.Edad,Solicitud.TarjetaDeCredito,Solicitud.PlazoDeInteres,Solicitud.ProcesoDeAutorizacion 
from  Solicitud 
 inner join  Usuario  on Usuario.idusuario = Solicitud.idusuario where
  Usuario.idusuario = '1' and Solicitud.ProcesoDeAutorizacion = var_PocesoPendiente  order by Solicitud.fec_creacion desc limit 1;
     
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
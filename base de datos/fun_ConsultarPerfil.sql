CREATE FUNCTION fun_ConsultarPerfil(Id Int)
 RETURNS TABLE (
 val_Nombre varchar(20),
 val_Monto real,
 val_Edad int,
 val_TarjetaDeCredito Boolean,
 val_PlazoDeInteres real,
 val_ProcesoDeAutorizacion Boolean
) 

AS $$
BEGIN
RETURN QUERY select Usuario.Nombre, Solicitud.Monto,Solicitud.Edad,Solicitud.TarjetaDeCredito,Solicitud.PlazoDeInteres,Solicitud.ProcesoDeAutorizacion 
from  Solicitud 
 inner join  Usuario  on Usuario.idusuario = Solicitud.idusuario where Usuario.idusuario = '2' order by Solicitud.fec_creacion desc limit 1;
     
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
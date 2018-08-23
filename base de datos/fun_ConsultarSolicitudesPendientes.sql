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
var_PocesoPendiente  VARCHAR(10);

BEGIN
var_PocesoPendiente := 'PENDIENTE';

RETURN QUERY SELECT
	 Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion from  Solicitud where ProcesoDeAutorizacion = var_PocesoPendiente and IdUsuario = Id;       
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
CREATE FUNCTION fun_ConsultarSolicitudesPendientes(Id Int)
 RETURNS TABLE (
 val_Monto real,
 val_Edad int,
 val_TarjetaDeCredito Boolean,
 val_PlazoDeInteres real,
 val_ProcesoDeAutorizacion Boolean
) 

AS $$
BEGIN
RETURN QUERY SELECT
	 Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion from  Solicitud where ProcesoDeAutorizacion is NULL and IdUsuario = Id;       
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER

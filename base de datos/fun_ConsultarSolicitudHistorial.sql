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
SECURITY DEFINER
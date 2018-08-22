CREATE FUNCTION fun_ConsultarSolicitudHistorial(Id Int)
 RETURNS TABLE (
 fun_Monto real,
 fun_Edad int
) 

AS $$
BEGIN
RETURN QUERY SELECT
	 Monto,Edad from  Solicitud where ProcesoDeAutorizacion is not NULL and IdUsuario = Id;       
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
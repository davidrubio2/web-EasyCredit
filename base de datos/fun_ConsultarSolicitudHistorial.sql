CREATE FUNCTION fun_ConsultarSolicitudHistorial(Id Int)
RETURNS table AS $$
DECLARE
fun_Id ALIAS FOR $1;

BEGIN
	select * from  Solicitud where ProcesoDeAutorizacion is not NULL and IdUsuario = fun_Id;       
	if fun_IdSolicitud is null
       then
			RETURN false;
        else
      
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
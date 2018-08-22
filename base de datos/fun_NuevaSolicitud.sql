CREATE FUNCTION fun_NuevaSolicitud(Id Int,Monto real, Edad int, TarjetaDeCredito boolean,PlazoDeInteres real, ProcesoDeAutorizacion boolean  )
RETURNS boolean AS $$
DECLARE

fun_Id ALIAS FOR $1;
fun_Monto  ALIAS FOR $2;
fun_Edad  ALIAS FOR $3;
fun_TarjetaDeCredito ALIAS FOR $4;
fun_PlazoDeInteres ALIAS FOR $5;
fun_ProcesoDeAutorizacion ALIAS FOR $6;


BEGIN

       select IdUsuario INTO fun_id from  Usuario where IdUsuario = fun_Id;
       if fun_Id is null
		then
			RETURN false;
		else
		  INSERT INTO Solicitud(IdUsuario,Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion)
		  VALUES(fun_Id,fun_Monto,fun_Edad,fun_TarjetaDeCredito,fun_PlazoDeInteres,fun_ProcesoDeAutorizacion);
		  RETURN true;
		  END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
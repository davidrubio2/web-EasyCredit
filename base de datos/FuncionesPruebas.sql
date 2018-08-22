CREATE FUNCTION fun_ConsultarGrabarUsuario(usuario TEXT)
RETURNS int AS $$
DECLARE

fun_nombre ALIAS FOR $1;
fun_id int;

BEGIN
        select IdUsuario INTO fun_id from  Usuario where Nombre = fun_nombre;
	if fun_id is null
		then
			INSERT INTO Usuario(Nombre) VALUES(fun_nombre); 
			select IdUsuario INTO fun_id from  Usuario where Nombre = fun_nombre;
			RETURN fun_id;
		else
		RETURN fun_id;
		END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER

select fun_ConsultarGrabarUsuario('david')

drop function fun_ConsultarGrabarUsuario
-----------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION fun_NuevaSolicitud(Id Int,Monto real, Edad int, TarjetaDeCredito varchar(10),PlazoDeInteres real  )
RETURNS boolean AS $$
DECLARE

fun_Id ALIAS FOR $1;
fun_Monto  ALIAS FOR $2;
fun_Edad  ALIAS FOR $3;
fun_TarjetaDeCredito ALIAS FOR $4;
fun_PlazoDeInteres ALIAS FOR $5;


BEGIN

       select IdUsuario INTO fun_id from  Usuario where IdUsuario = fun_Id;
       if fun_Id is null
		then
			RETURN false;
		else
		  INSERT INTO Solicitud(IdUsuario,Monto,Edad,TarjetaDeCredito,PlazoDeInteres)
		  VALUES(fun_Id,fun_Monto,fun_Edad,fun_TarjetaDeCredito,fun_PlazoDeInteres);
		  RETURN true;
		  END IF;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER

drop function fun_NuevaSolicitud;

INSERT INTO Solicitud(IdUsuario,
Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion)
VALUES('2','100','20',TRUE,'7');

select fun_NuevaSolicitud('1','100','20','SI TIENE','7');

------------------------------------------------------------------------------------------------------
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


drop function fun_AceptarSolicitud;

select fun_AceptarSolicitud();


Solicitud 

select *
from Solicitud WHERE ProcesoDeAutorizacion IS NULL order by fec_Aceptacion limit 1;

UPDATE Solicitud set ProcesoDeAutorizacion = TRUE ,  fec_Aceptacion = timenow()  where IdSolicitud = '3';

IdUsuario,
Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion
----------------------------------------------------------------------------------------------------------------------
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
var_PocesoPendiente  VARCHAR(10);

BEGIN
var_PocesoPendiente := 'PENDIENTE';

RETURN QUERY SELECT
	 Monto,Edad,TarjetaDeCredito,PlazoDeInteres,ProcesoDeAutorizacion from  Solicitud where ProcesoDeAutorizacion != var_PocesoPendiente and IdUsuario = Id;       
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER

drop function fun_ConsultarSolicitudHistorial;
select fun_ConsultarSolicitudHistorial('1');

select * from  Solicitud where ProcesoDeAutorizacion is not NULL and IdUsuario = '2'

---------------------------------------------------------------------------------------------------------------------------
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

drop function fun_ConsultarSolicitudesPendientes;
select fun_ConsultarSolicitudesPendientes('1');

select * from  Solicitud where ProcesoDeAutorizacion is  NULL and IdUsuario = '2'

-----------------------------------------------------------------------------------------------------------------------
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

drop function fun_ConsultarPerfil;
select fun_ConsultarPerfil('1');

select Usuario.Nombre, Solicitud.Monto,Solicitud.Edad,Solicitud.TarjetaDeCredito,Solicitud.PlazoDeInteres,Solicitud.ProcesoDeAutorizacion 
from  Solicitud 
 inner join  Usuario  on Usuario.idusuario = Solicitud.idusuario where Usuario.idusuario = '2' order by Solicitud.fec_creacion desc limit 1

select *
 from Solicitud  WHERE ProcesoDeAutorizacion IS NULL order by fec_creacion desc limit 1

select Usuario.Nombre, Solicitud.Monto,Solicitud.Edad,Solicitud.TarjetaDeCredito,Solicitud.PlazoDeInteres,Solicitud.ProcesoDeAutorizacion 
from  Solicitud 
 inner join  Usuario  on Usuario.idusuario = Solicitud.idusuario where
  Usuario.idusuario = '1' and Solicitud.ProcesoDeAutorizacion = 'PENDIENTE'  order by Solicitud.fec_creacion desc limit 1;
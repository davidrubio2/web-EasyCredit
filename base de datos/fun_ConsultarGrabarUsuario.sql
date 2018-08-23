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
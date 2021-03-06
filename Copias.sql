PGDMP         $                y         
   DRAWCREATE    11.8    11.8 ?    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            ?           1262    41868 
   DRAWCREATE    DATABASE     ?   CREATE DATABASE "DRAWCREATE" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
    DROP DATABASE "DRAWCREATE";
             postgres    false            ?            1255    50012 7   agregar_categoria(character varying, character varying)    FUNCTION     ?   CREATE FUNCTION public.agregar_categoria(character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	INSERT INTO categoria (nom_cat, desc_cat) values ($1,$2);
END
$_$;
 N   DROP FUNCTION public.agregar_categoria(character varying, character varying);
       public       postgres    false            ?            1255    91057 )   agregar_compra(numeric, integer, integer)    FUNCTION     D  CREATE FUNCTION public.agregar_compra(numeric, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
ide integer;
BEGIN
	INSERT INTO compra (fecha_com, total_com,id_per, id_usu) values (current_timestamp,$1,$2,$3);
	ide = (select id_com from compra order by id_com desc limit 1);
	
	return ide;
END
$_$;
 @   DROP FUNCTION public.agregar_compra(numeric, integer, integer);
       public       postgres    false            ?            1255    91060 B   agregar_detallecompra(integer, integer, numeric, numeric, numeric)    FUNCTION     d  CREATE FUNCTION public.agregar_detallecompra(integer, integer, numeric, numeric, numeric) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
ide integer;
BEGIN
	INSERT INTO detalle_compra (id_com, cod_pro, subtotal_com, cant_com, prepro_decom) values ($1,$2,$3,$4,$5);
	update producto set precio_pro = (precio_pro + $5) / 2 where cod_pro = $2;
END
$_$;
 Y   DROP FUNCTION public.agregar_detallecompra(integer, integer, numeric, numeric, numeric);
       public       postgres    false                       1255    91063 $   agregar_detallerol(integer, integer)    FUNCTION     ?   CREATE FUNCTION public.agregar_detallerol(integer, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE

BEGIN
	INSERT INTO rol_permisos (id_rol, id_perm) values ($1,$2);
END
$_$;
 ;   DROP FUNCTION public.agregar_detallerol(integer, integer);
       public       postgres    false                       1255    74670 8   agregar_detalleventa(integer, integer, numeric, numeric)    FUNCTION       CREATE FUNCTION public.agregar_detalleventa(integer, integer, numeric, numeric) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
ide integer;
BEGIN
	INSERT INTO detalle_venta (id_venta, cod_prod, subtotal_venta, cant_venta) values ($1,$2,$3,$4);
END
$_$;
 O   DROP FUNCTION public.agregar_detalleventa(integer, integer, numeric, numeric);
       public       postgres    false            ?            1255    66446 ?   agregar_persona(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     ?  CREATE FUNCTION public.agregar_persona(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	INSERT INTO persona (nom_per,doc_per,genero_per,tipo_per,correo_per,tipdoc_per,cel_per,dir_per)
	values ($1,$2,$3,$4,$5,$6,$7,$8);
END
$_$;
 ?   DROP FUNCTION public.agregar_persona(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);
       public       postgres    false                        1255    58176 ?   agregar_producto(character varying, character varying, integer)    FUNCTION       CREATE FUNCTION public.agregar_producto(character varying, character varying, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	INSERT INTO producto (codbarr_pro, nom_pro,precio_pro,stock_pro,iva_pro,cod_cat) values ($1,$2,0,0,0,$3);
END
$_$;
 V   DROP FUNCTION public.agregar_producto(character varying, character varying, integer);
       public       postgres    false            ?            1255    66475 ?   agregar_usuario(character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying)    FUNCTION     ?  CREATE FUNCTION public.agregar_usuario(character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	INSERT INTO usuario (nom_usu,ape_usu,correo_usu,docum_usu,estado_usu,genero_usu,con_usu,id_rol,tipdoc_usu,fecreg_usu,cel_usu)
	values ($1,$2,$3,$4,'A',$5,$6,$7,$8,current_date,$9);
END
$_$;
 ?   DROP FUNCTION public.agregar_usuario(character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying);
       public       postgres    false            	           1255    74669 (   agregar_venta(numeric, integer, integer)    FUNCTION     V  CREATE FUNCTION public.agregar_venta(numeric, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
ide integer;
BEGIN
	INSERT INTO venta (fecha_venta, total_venta,id_per, id_usu, est_ven) values (current_timestamp,$1,$2,$3,'D');
	ide = (select id_venta from venta order by id_venta desc limit 1);
	
	return ide;
END
$_$;
 ?   DROP FUNCTION public.agregar_venta(numeric, integer, integer);
       public       postgres    false                       1255    50000 #   bloquear_usuario(character varying)    FUNCTION     a  CREATE FUNCTION public.bloquear_usuario(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
id_usuario integer= (select id_usu from usuario where correo_usu = $1);
BEGIN
	if(id_usuario is not null)then
		update usuario set estado_usu = 'B' where id_usu = id_usuario;
		
		return true;
	
	else 
		return false;
	end if;
END;

$_$;
 :   DROP FUNCTION public.bloquear_usuario(character varying);
       public       postgres    false                       1255    66533 !   buscar_menconf(character varying)    FUNCTION     ?  CREATE FUNCTION public.buscar_menconf(character varying) RETURNS TABLE(host character varying, puerto character varying, corr_emisor character varying, nom_emisor character varying, asunto character varying, mensaje text)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN	
return query select host_concor, pue_concor, corren_concor, nomrem_concor, asu_mencor, men_mencor  from configuracion_correo concor inner join mensajes_correo ms 
on ms.id_concor = concor.id_concor where cod_mencor = $1;
END;
$_$;
 8   DROP FUNCTION public.buscar_menconf(character varying);
       public       postgres    false            ?            1255    50029 )   cambiarestado_categoria(integer, boolean)    FUNCTION     ?   CREATE FUNCTION public.cambiarestado_categoria(integer, boolean) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	UPDATE categoria set est_cat = $2 where cod_cat = $1;
END
$_$;
 @   DROP FUNCTION public.cambiarestado_categoria(integer, boolean);
       public       postgres    false                       1255    91064 )   cambiarestado_usuario(integer, character)    FUNCTION     ?   CREATE FUNCTION public.cambiarestado_usuario(integer, character) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	UPDATE usuario set estado_usu = $2 where id_usu = $1;
END
$_$;
 @   DROP FUNCTION public.cambiarestado_usuario(integer, character);
       public       postgres    false                       1255    82860 '   cambiarestado_venta(integer, character)    FUNCTION     ?   CREATE FUNCTION public.cambiarestado_venta(integer, character) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	UPDATE venta set est_ven = $2 where id_venta = $1;
END
$_$;
 >   DROP FUNCTION public.cambiarestado_venta(integer, character);
       public       postgres    false                       1255    58244 4   iniciar_sesion(character varying, character varying)    FUNCTION     ?  CREATE FUNCTION public.iniciar_sesion(character varying, character varying) RETURNS TABLE(id_usuario integer, nombre character varying, apellido character varying, correo character varying, documento character varying, rol character varying, tipo_documento character varying, fecha_registro date, genero character varying, celular character varying)
    LANGUAGE plpgsql
    AS $_$
DECLARE
cant_usu int := (select count(*) from usuario);
id_usuario int := (select id_usu from usuario where correo_usu = $1);
clave int := 0;
estado char:= '';
BEGIN	
	if(cant_usu > 0)then
		if(id_usuario is not null) then
			
				estado = (select estado_usu from usuario where id_usu = id_usuario);
				if(estado = 'A')then
					clave = (select id_usu from usuario where con_usu = $2 and id_usu = id_usuario);
					if(clave is not null)then
						return query select id_usu,nom_usu,ape_usu,correo_usu,docum_usu, r.nom_rol,tipdoc_usu,fecreg_usu, genero_usu, cel_usu from usuario u inner join rol r on u.id_rol = r.id_rol where id_usu = id_usuario;
					else
						return query select -3,'El usuario usuario y/o contraseña son incorrectos'::varchar,'Por favor intente de nuevo'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,'01-01-2020'::date,''::varchar,''::varchar;

					end if;
		
				elsif (estado = 'I') then 
					return query select -1,'El usuario está inactivo'::varchar,'Por favor comuniquese con el administrador'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,'01-01-2020'::date,''::varchar,''::varchar;

				else
					return query select -2,'El usuario está bloqueado por intentos excedidos'::varchar,'Por favor comuniquese con el administrador'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,'01-01-2020'::date,''::varchar,''::varchar;		
				end if;
		else

			return query select -4,'No existe ningun usuario registrado con ese correo electronico'::varchar,'Por favor verifique los datos ingresados'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,'01-01-2020'::date,''::varchar,''::varchar;		

		end if;
		
		else
		
			return query select -5,'No hay registro de usuarios'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar,'01-01-2020'::date,''::varchar,''::varchar;
	end if;

END;
$_$;
 K   DROP FUNCTION public.iniciar_sesion(character varying, character varying);
       public       postgres    false            ?            1255    50009    listar_categorias(integer)    FUNCTION     `  CREATE FUNCTION public.listar_categorias(integer) RETURNS TABLE(id_cat integer, nombre character varying, descripcion character varying, estado boolean)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	if($1 != 0)then
		
		return query select * from categoria where est_cat = true;
	
	else
		return query select * from categoria;

	end if;
	
	
END;
$_$;
 1   DROP FUNCTION public.listar_categorias(integer);
       public       postgres    false                       1255    66527    listar_compras()    FUNCTION     ]  CREATE FUNCTION public.listar_compras(OUT ide integer, OUT fecha timestamp without time zone, OUT total money, OUT proveedor character varying, OUT usuario character varying, OUT detalle integer[]) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
DECLARE
det integer[];
i int = 0;
query_com text;
query_det text;
compra RECORD;
detalle_compra RECORD;

BEGIN
	query_com = 'select co.id_com, fecha_com, co.total_com, per.nom_per, usu.nom_usu || usu.ape_usu
	as nom_usu from compra co inner join persona per on per.id_per = co.id_per inner join usuario 
	usu on usu.id_usu = co.id_usu';
	FOR compra IN EXECUTE query_com LOOP
		query_det := 'select dc.id_detcom from compra co inner join detalle_compra dc on
		dc.id_com = co.id_com where co.id_com ='||compra.id_com;
		FOR detalle_compra IN EXECUTE query_det LOOP
		 det[i] = detalle_compra.id_detcom;
		 i = i +1;
		END LOOP;
		ide = compra.id_com;
		fecha = compra.fecha_com;
		total = compra.total_com;
		proveedor = compra.nom_per;
		usuario = compra.nom_usu;
		detalle = det;
		det = '{}';
										
		RETURN NEXT;							
	END LOOP;
										
	RETURN;
END
$$;
 ?   DROP FUNCTION public.listar_compras(OUT ide integer, OUT fecha timestamp without time zone, OUT total money, OUT proveedor character varying, OUT usuario character varying, OUT detalle integer[]);
       public       postgres    false                       1255    66467    listar_permisos()    FUNCTION     ?   CREATE FUNCTION public.listar_permisos() RETURNS TABLE(ide integer, nombre character varying, descripcion character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN	
return query select * from permisos;
END;
$$;
 (   DROP FUNCTION public.listar_permisos();
       public       postgres    false            ?            1255    91068    listar_permisos(integer)    FUNCTION     )  CREATE FUNCTION public.listar_permisos(integer) RETURNS TABLE(ide integer)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN	
return query select rp.id_perm from usuario us inner join rol rl on us.id_rol = rl.id_rol inner join 
rol_permisos rp on rp.id_rol = rl.id_rol where us.id_usu = $1;
END;
$_$;
 /   DROP FUNCTION public.listar_permisos(integer);
       public       postgres    false            ?            1255    66449 "   listar_personas(character varying)    FUNCTION     ?  CREATE FUNCTION public.listar_personas(character varying) RETURNS TABLE(ide integer, nombre character varying, documento character varying, genero character varying, correo character varying, tipodocumento character varying, celular character varying, direccion character varying)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	return query select id_per, nom_per, doc_per, genero_per,correo_per, tipdoc_per, cel_per, dir_per from persona where tipo_per = $1;
END;
$_$;
 9   DROP FUNCTION public.listar_personas(character varying);
       public       postgres    false                       1255    66518    listar_productos(integer)    FUNCTION     ?  CREATE FUNCTION public.listar_productos(integer) RETURNS TABLE(ide integer, codigo character varying, nombre character varying, categoria character varying, precio numeric, stock integer, iva numeric)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	if($1 != 0)then
		
		return query select pro.cod_pro, pro.codbarr_pro, pro.nom_pro,cat.nom_cat,pro.precio_pro, 
		 pro.stock_pro, pro.iva_pro from producto pro inner join categoria cat
		on pro.cod_cat = cat.cod_cat where stock_pro > 0;
	
	else
		return query select pro.cod_pro, pro.codbarr_pro, pro.nom_pro,cat.nom_cat,pro.precio_pro, 
		 pro.stock_pro, pro.iva_pro from producto pro inner join categoria cat
		on pro.cod_cat = cat.cod_cat;

	end if;
	
	
END;
$_$;
 0   DROP FUNCTION public.listar_productos(integer);
       public       postgres    false            ?            1255    66466    listar_roles(integer)    FUNCTION     ]  CREATE FUNCTION public.listar_roles(input integer, OUT ide integer, OUT nombre character varying, OUT estado boolean, OUT permisos integer[]) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $_$
DECLARE
per integer[];
i int = 0;
query_per text;
query_rol text;
permiso RECORD;
roles RECORD;

BEGIN
	if($1 = 1)then
		query_rol = 'select id_rol,nom_rol, est_rol from rol where est_rol = true';
		else
		query_rol = 'select id_rol,nom_rol, est_rol from rol';
	end if;
	
	FOR roles IN EXECUTE query_rol LOOP
		query_per := 'select id_perm from rol_permisos where id_rol ='|| roles.id_rol;
		FOR permiso IN EXECUTE query_per LOOP
		 per[i] = permiso.id_perm;
		 i = i +1;
		END LOOP;
		ide = roles.id_rol;
		nombre = roles.nom_rol;
		estado = roles.est_rol;
		permisos = per;
		
		per = '{}';
										
		RETURN NEXT;							
	END LOOP;
										
	RETURN;
END
$_$;
 ?   DROP FUNCTION public.listar_roles(input integer, OUT ide integer, OUT nombre character varying, OUT estado boolean, OUT permisos integer[]);
       public       postgres    false            ?            1255    66471    listar_usuarios(integer)    FUNCTION     h  CREATE FUNCTION public.listar_usuarios(integer) RETURNS TABLE(ide integer, nombre character varying, apellido character varying, correo character varying, documento character varying, estado character, genero character varying, ide_rol integer, nom_rol character varying, tipodocumento character varying, fecha_registro date, celular character varying)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	if($1 != 0)then
	return query select id_usu, nom_usu, ape_usu, correo_usu ,docum_usu,estado_usu, genero_usu,u.id_rol, ro.nom_rol, tipdoc_usu, fecreg_usu ,cel_usu from usuario u inner join rol ro on u.id_rol = ro.id_rol where estado_usu = 'A';
	else
	return query select id_usu, nom_usu, ape_usu, correo_usu ,docum_usu,estado_usu, genero_usu, u.id_rol,ro.nom_rol, tipdoc_usu, fecreg_usu ,cel_usu from usuario u inner join rol ro on u.id_rol = ro.id_rol;
	end if;
END;
$_$;
 /   DROP FUNCTION public.listar_usuarios(integer);
       public       postgres    false                       1255    66501    listar_ventas()    FUNCTION     ?  CREATE FUNCTION public.listar_ventas(OUT ide integer, OUT fecha timestamp without time zone, OUT total money, OUT cliente character varying, OUT usuario character varying, OUT estado character, OUT detalle integer[]) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
DECLARE
det integer[];
i int = 0;
query_ven text;
query_det text;
venta RECORD;
detalle_venta RECORD;

BEGIN
	query_ven = 'select ve.id_venta, fecha_venta, ve.total_venta, per.nom_per, usu.nom_usu || usu.ape_usu
	as nom_usu, est_ven from venta ve inner join persona per on per.id_per = ve.id_per inner join usuario 
	usu on usu.id_usu = ve.id_usu';
	FOR venta IN EXECUTE query_ven LOOP
		query_det := 'select dv.id_detven from venta ve inner join detalle_venta dv on
		dv.id_venta = ve.id_venta where ve.id_venta ='||venta.id_venta;
		FOR detalle_venta IN EXECUTE query_det LOOP
		 det[i] = detalle_venta.id_detven;
		 i = i +1;
		END LOOP;
		ide = venta.id_venta;
		fecha = venta.fecha_venta;
		total = venta.total_venta;
		cliente = venta.nom_per;
		usuario = venta.nom_usu;
		estado = venta.est_ven;
		detalle = det;
		det = '{}';
										
		RETURN NEXT;							
	END LOOP;
										
	RETURN;
END
$$;
 ?   DROP FUNCTION public.listar_ventas(OUT ide integer, OUT fecha timestamp without time zone, OUT total money, OUT cliente character varying, OUT usuario character varying, OUT estado character, OUT detalle integer[]);
       public       postgres    false            ?            1255    50028 B   modificar_categoria(integer, character varying, character varying)    FUNCTION     ?   CREATE FUNCTION public.modificar_categoria(integer, character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	UPDATE categoria set nom_cat = $2, desc_cat = $3 where cod_cat = $1;
END
$_$;
 Y   DROP FUNCTION public.modificar_categoria(integer, character varying, character varying);
       public       postgres    false            ?            1255    66453 ?   modificar_persona(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE public.modificar_persona(id_p integer, nom character varying, doc character varying, genero character varying, correo character varying, tipodocumento character varying, celular character varying, direccion character varying)
    LANGUAGE sql
    AS $$
UPDATE persona SET nom_per=nom, doc_per = doc, genero_per=genero,correo_per=correo, tipdoc_per = tipodocumento,cel_per = celular, dir_per = direccion
WHERE id_per=id_p;
$$;
 ?   DROP PROCEDURE public.modificar_persona(id_p integer, nom character varying, doc character varying, genero character varying, correo character varying, tipodocumento character varying, celular character varying, direccion character varying);
       public       postgres    false                       1255    91062 )   modificar_rol(integer, character varying)    FUNCTION       CREATE FUNCTION public.modificar_rol(ide_rol integer, nombre character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
i int = 1;
BEGIN
	delete from rol_permisos where id_rol =ide_rol;
	
	update rol set nom_rol = $2 where id_rol = $1;
END
$_$;
 O   DROP FUNCTION public.modificar_rol(ide_rol integer, nombre character varying);
       public       postgres    false                       1255    66479 ?   modificar_usuario(integer, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying)    FUNCTION     ?  CREATE FUNCTION public.modificar_usuario(integer, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	update usuario set nom_usu = $2,ape_usu = $3 ,correo_usu = $4,docum_usu = $5 ,genero_usu = $6,id_rol = $7,tipdoc_usu = $8,cel_usu = $9 where id_usu = $1;
END
$_$;
 ?   DROP FUNCTION public.modificar_usuario(integer, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying);
       public       postgres    false            ?            1255    91061    mostrar_detallecompra(integer)    FUNCTION     ?  CREATE FUNCTION public.mostrar_detallecompra(integer) RETURNS TABLE(opcion character varying, producto character varying, cantidad integer, precio numeric, iva numeric, subtotal money, total money)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN	
return query select ''::character varying,nom_pro, dt.cant_com,prepro_decom, iva_pro,subtotal_com, (subtotal_com + (subtotal_com *iva_pro)) as total
from producto pr inner join detalle_compra dt on pr.cod_pro = dt.cod_pro where id_com = $1;
END;
$_$;
 5   DROP FUNCTION public.mostrar_detallecompra(integer);
       public       postgres    false                       1255    91056    mostrar_detalleventa(integer)    FUNCTION     ?  CREATE FUNCTION public.mostrar_detalleventa(integer) RETURNS TABLE(opcion character varying, producto character varying, cantidad integer, precio numeric, iva numeric, subtotal money, total money)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN	
return query select ''::character varying,nom_pro, dt.cant_venta,precio_pro, iva_pro,subtotal_venta, (subtotal_venta + (subtotal_venta *iva_pro)) as total
from producto pr inner join detalle_venta dt on pr.cod_pro = dt.cod_prod where id_venta = $1;
END;
$_$;
 4   DROP FUNCTION public.mostrar_detalleventa(integer);
       public       postgres    false            
           1255    66535 8   recuperar_password(character varying, character varying)    FUNCTION     :  CREATE FUNCTION public.recuperar_password(character varying, character varying) RETURNS TABLE(usuario text)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN	
 update usuario set con_usu = $2 where correo_usu = $1;
 return query select nom_usu || ' '|| ape_usu as usuario from usuario where correo_usu = $1;
END;
$_$;
 O   DROP FUNCTION public.recuperar_password(character varying, character varying);
       public       postgres    false            ?            1259    41879 	   categoria    TABLE     ?   CREATE TABLE public.categoria (
    cod_cat integer NOT NULL,
    nom_cat character varying(50) NOT NULL,
    desc_cat character varying(250) NOT NULL,
    est_cat boolean DEFAULT true
);
    DROP TABLE public.categoria;
       public         postgres    false            ?            1259    41877    categoria_cod_cat_seq    SEQUENCE     ?   CREATE SEQUENCE public.categoria_cod_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.categoria_cod_cat_seq;
       public       postgres    false    199            ?           0    0    categoria_cod_cat_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.categoria_cod_cat_seq OWNED BY public.categoria.cod_cat;
            public       postgres    false    198            ?            1259    41979    compra    TABLE     ?   CREATE TABLE public.compra (
    id_com integer NOT NULL,
    fecha_com timestamp without time zone NOT NULL,
    total_com money NOT NULL,
    id_per integer NOT NULL,
    id_usu integer NOT NULL
);
    DROP TABLE public.compra;
       public         postgres    false            ?            1259    41973    compra_id_com_seq    SEQUENCE     ?   CREATE SEQUENCE public.compra_id_com_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.compra_id_com_seq;
       public       postgres    false    215            ?           0    0    compra_id_com_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.compra_id_com_seq OWNED BY public.compra.id_com;
            public       postgres    false    212            ?            1259    41975    compra_id_per_seq    SEQUENCE     ?   CREATE SEQUENCE public.compra_id_per_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.compra_id_per_seq;
       public       postgres    false    215            ?           0    0    compra_id_per_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.compra_id_per_seq OWNED BY public.compra.id_per;
            public       postgres    false    213            ?            1259    41977    compra_id_usu_seq    SEQUENCE     ?   CREATE SEQUENCE public.compra_id_usu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.compra_id_usu_seq;
       public       postgres    false    215            ?           0    0    compra_id_usu_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.compra_id_usu_seq OWNED BY public.compra.id_usu;
            public       postgres    false    214            ?            1259    66429    configuracion_correo    TABLE       CREATE TABLE public.configuracion_correo (
    id_concor integer NOT NULL,
    host_concor character varying(50) NOT NULL,
    pue_concor character varying(5),
    corren_concor character varying(100) NOT NULL,
    nomrem_concor character varying(250) NOT NULL
);
 (   DROP TABLE public.configuracion_correo;
       public         postgres    false            ?            1259    66427 "   configuracion_correo_id_concor_seq    SEQUENCE     ?   CREATE SEQUENCE public.configuracion_correo_id_concor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.configuracion_correo_id_concor_seq;
       public       postgres    false    225            ?           0    0 "   configuracion_correo_id_concor_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.configuracion_correo_id_concor_seq OWNED BY public.configuracion_correo.id_concor;
            public       postgres    false    224            ?            1259    42001    detalle_compra    TABLE     ?   CREATE TABLE public.detalle_compra (
    cod_pro integer NOT NULL,
    id_com integer NOT NULL,
    subtotal_com money NOT NULL,
    cant_com integer NOT NULL,
    id_detcom integer NOT NULL,
    prepro_decom numeric(11,2)
);
 "   DROP TABLE public.detalle_compra;
       public         postgres    false            ?            1259    41997    detalle_compra_cod_pro_seq    SEQUENCE     ?   CREATE SEQUENCE public.detalle_compra_cod_pro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.detalle_compra_cod_pro_seq;
       public       postgres    false    218            ?           0    0    detalle_compra_cod_pro_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.detalle_compra_cod_pro_seq OWNED BY public.detalle_compra.cod_pro;
            public       postgres    false    216            ?            1259    41999    detalle_compra_id_com_seq    SEQUENCE     ?   CREATE SEQUENCE public.detalle_compra_id_com_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.detalle_compra_id_com_seq;
       public       postgres    false    218            ?           0    0    detalle_compra_id_com_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.detalle_compra_id_com_seq OWNED BY public.detalle_compra.id_com;
            public       postgres    false    217            ?            1259    66519    detalle_compra_id_detcom_seq    SEQUENCE     ?   CREATE SEQUENCE public.detalle_compra_id_detcom_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.detalle_compra_id_detcom_seq;
       public       postgres    false    218            ?           0    0    detalle_compra_id_detcom_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.detalle_compra_id_detcom_seq OWNED BY public.detalle_compra.id_detcom;
            public       postgres    false    229            ?            1259    41956    detalle_venta    TABLE     ?   CREATE TABLE public.detalle_venta (
    cod_prod integer NOT NULL,
    id_venta integer NOT NULL,
    subtotal_venta money NOT NULL,
    cant_venta integer NOT NULL,
    id_detven integer NOT NULL
);
 !   DROP TABLE public.detalle_venta;
       public         postgres    false            ?            1259    41952    detalle_venta_cod_prod_seq    SEQUENCE     ?   CREATE SEQUENCE public.detalle_venta_cod_prod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.detalle_venta_cod_prod_seq;
       public       postgres    false    211            ?           0    0    detalle_venta_cod_prod_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.detalle_venta_cod_prod_seq OWNED BY public.detalle_venta.cod_prod;
            public       postgres    false    209            ?            1259    66480    detalle_venta_id_detven_seq    SEQUENCE     ?   CREATE SEQUENCE public.detalle_venta_id_detven_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.detalle_venta_id_detven_seq;
       public       postgres    false    211            ?           0    0    detalle_venta_id_detven_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.detalle_venta_id_detven_seq OWNED BY public.detalle_venta.id_detven;
            public       postgres    false    228            ?            1259    41954    detalle_venta_id_venta_seq    SEQUENCE     ?   CREATE SEQUENCE public.detalle_venta_id_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.detalle_venta_id_venta_seq;
       public       postgres    false    211            ?           0    0    detalle_venta_id_venta_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.detalle_venta_id_venta_seq OWNED BY public.detalle_venta.id_venta;
            public       postgres    false    210            ?            1259    66437    mensajes_correo    TABLE     ?   CREATE TABLE public.mensajes_correo (
    id_mencor integer NOT NULL,
    asu_mencor character varying(100) NOT NULL,
    men_mencor text,
    est_mencor boolean,
    cod_mencor character varying(10),
    id_concor integer
);
 #   DROP TABLE public.mensajes_correo;
       public         postgres    false            ?            1259    66435    mensajes_correo_id_mencor_seq    SEQUENCE     ?   CREATE SEQUENCE public.mensajes_correo_id_mencor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.mensajes_correo_id_mencor_seq;
       public       postgres    false    227            ?           0    0    mensajes_correo_id_mencor_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.mensajes_correo_id_mencor_seq OWNED BY public.mensajes_correo.id_mencor;
            public       postgres    false    226            ?            1259    58198    permisos    TABLE     ?   CREATE TABLE public.permisos (
    id_perm integer NOT NULL,
    nom_perm character varying(250) NOT NULL,
    des_perm character varying(250) NOT NULL
);
    DROP TABLE public.permisos;
       public         postgres    false            ?            1259    58196    permisos_id_perm_seq    SEQUENCE     ?   CREATE SEQUENCE public.permisos_id_perm_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.permisos_id_perm_seq;
       public       postgres    false    222            ?           0    0    permisos_id_perm_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.permisos_id_perm_seq OWNED BY public.permisos.id_perm;
            public       postgres    false    221            ?            1259    41887    persona    TABLE     t  CREATE TABLE public.persona (
    id_per integer NOT NULL,
    nom_per character varying(100) NOT NULL,
    doc_per character varying(30) NOT NULL,
    genero_per character varying(15) NOT NULL,
    tipo_per character varying(20) NOT NULL,
    correo_per character varying(100) NOT NULL,
    tipdoc_per character varying(150),
    cel_per character varying(20),
    dir_per character varying(255),
    CONSTRAINT ck_genero_per CHECK (((genero_per)::text = ANY (ARRAY[('Masculino'::character varying)::text, ('Femenino'::character varying)::text, ('Otros'::character varying)::text, ('No aplica'::character varying)::text])))
);
    DROP TABLE public.persona;
       public         postgres    false            ?            1259    41885    persona_id_per_seq    SEQUENCE     ?   CREATE SEQUENCE public.persona_id_per_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.persona_id_per_seq;
       public       postgres    false    201            ?           0    0    persona_id_per_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.persona_id_per_seq OWNED BY public.persona.id_per;
            public       postgres    false    200            ?            1259    41897    producto    TABLE     $  CREATE TABLE public.producto (
    cod_pro integer NOT NULL,
    codbarr_pro character varying(30) NOT NULL,
    nom_pro character varying(250) NOT NULL,
    precio_pro numeric(11,2) NOT NULL,
    stock_pro integer NOT NULL,
    iva_pro numeric(4,2) NOT NULL,
    cod_cat integer NOT NULL
);
    DROP TABLE public.producto;
       public         postgres    false            ?            1259    41895    producto_cod_cat_seq    SEQUENCE     ?   CREATE SEQUENCE public.producto_cod_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.producto_cod_cat_seq;
       public       postgres    false    204            ?           0    0    producto_cod_cat_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.producto_cod_cat_seq OWNED BY public.producto.cod_cat;
            public       postgres    false    203            ?            1259    41893    producto_cod_pro_seq    SEQUENCE     ?   CREATE SEQUENCE public.producto_cod_pro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.producto_cod_pro_seq;
       public       postgres    false    204            ?           0    0    producto_cod_pro_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.producto_cod_pro_seq OWNED BY public.producto.cod_pro;
            public       postgres    false    202            ?            1259    58190    rol    TABLE     ?   CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nom_rol character varying(40) NOT NULL,
    est_rol boolean DEFAULT true NOT NULL
);
    DROP TABLE public.rol;
       public         postgres    false            ?            1259    58188    rol_id_rol_seq    SEQUENCE     ?   CREATE SEQUENCE public.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.rol_id_rol_seq;
       public       postgres    false    220            ?           0    0    rol_id_rol_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;
            public       postgres    false    219            ?            1259    58207    rol_permisos    TABLE     `   CREATE TABLE public.rol_permisos (
    id_perm integer NOT NULL,
    id_rol integer NOT NULL
);
     DROP TABLE public.rol_permisos;
       public         postgres    false            ?            1259    41871    usuario    TABLE     ?  CREATE TABLE public.usuario (
    id_usu integer NOT NULL,
    nom_usu character varying(50) NOT NULL,
    ape_usu character varying(50) NOT NULL,
    correo_usu character varying(100) NOT NULL,
    docum_usu character varying(20) NOT NULL,
    estado_usu character(1) NOT NULL,
    genero_usu character varying(15) NOT NULL,
    con_usu character varying(255) NOT NULL,
    id_rol integer,
    tipdoc_usu character varying(100),
    fecreg_usu date,
    cel_usu character varying(20),
    CONSTRAINT ck_estado_usu CHECK ((estado_usu = ANY (ARRAY['A'::bpchar, 'B'::bpchar, 'I'::bpchar]))),
    CONSTRAINT ck_genero_usu CHECK (((genero_usu)::text = ANY ((ARRAY['Masculino'::character varying, 'Femenino'::character varying, 'Otro'::character varying])::text[])))
);
    DROP TABLE public.usuario;
       public         postgres    false            ?            1259    41869    usuario_cod_usu_seq    SEQUENCE     ?   CREATE SEQUENCE public.usuario_cod_usu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.usuario_cod_usu_seq;
       public       postgres    false    197            ?           0    0    usuario_cod_usu_seq    SEQUENCE OWNED BY     J   ALTER SEQUENCE public.usuario_cod_usu_seq OWNED BY public.usuario.id_usu;
            public       postgres    false    196            ?            1259    41934    venta    TABLE     ?   CREATE TABLE public.venta (
    id_venta integer NOT NULL,
    fecha_venta timestamp without time zone NOT NULL,
    total_venta money NOT NULL,
    id_per integer NOT NULL,
    id_usu integer NOT NULL,
    est_ven "char"
);
    DROP TABLE public.venta;
       public         postgres    false            ?            1259    41930    venta_id_per_seq    SEQUENCE     ?   CREATE SEQUENCE public.venta_id_per_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.venta_id_per_seq;
       public       postgres    false    208            ?           0    0    venta_id_per_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.venta_id_per_seq OWNED BY public.venta.id_per;
            public       postgres    false    206            ?            1259    41932    venta_id_usu_seq    SEQUENCE     ?   CREATE SEQUENCE public.venta_id_usu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.venta_id_usu_seq;
       public       postgres    false    208            ?           0    0    venta_id_usu_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.venta_id_usu_seq OWNED BY public.venta.id_usu;
            public       postgres    false    207            ?            1259    41928    venta_id_venta_seq    SEQUENCE     ?   CREATE SEQUENCE public.venta_id_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.venta_id_venta_seq;
       public       postgres    false    208            ?           0    0    venta_id_venta_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.venta_id_venta_seq OWNED BY public.venta.id_venta;
            public       postgres    false    205            ?
           2604    41882    categoria cod_cat    DEFAULT     v   ALTER TABLE ONLY public.categoria ALTER COLUMN cod_cat SET DEFAULT nextval('public.categoria_cod_cat_seq'::regclass);
 @   ALTER TABLE public.categoria ALTER COLUMN cod_cat DROP DEFAULT;
       public       postgres    false    199    198    199                       2604    41982    compra id_com    DEFAULT     n   ALTER TABLE ONLY public.compra ALTER COLUMN id_com SET DEFAULT nextval('public.compra_id_com_seq'::regclass);
 <   ALTER TABLE public.compra ALTER COLUMN id_com DROP DEFAULT;
       public       postgres    false    215    212    215            	           2604    41983    compra id_per    DEFAULT     n   ALTER TABLE ONLY public.compra ALTER COLUMN id_per SET DEFAULT nextval('public.compra_id_per_seq'::regclass);
 <   ALTER TABLE public.compra ALTER COLUMN id_per DROP DEFAULT;
       public       postgres    false    215    213    215            
           2604    41984    compra id_usu    DEFAULT     n   ALTER TABLE ONLY public.compra ALTER COLUMN id_usu SET DEFAULT nextval('public.compra_id_usu_seq'::regclass);
 <   ALTER TABLE public.compra ALTER COLUMN id_usu DROP DEFAULT;
       public       postgres    false    214    215    215                       2604    66432    configuracion_correo id_concor    DEFAULT     ?   ALTER TABLE ONLY public.configuracion_correo ALTER COLUMN id_concor SET DEFAULT nextval('public.configuracion_correo_id_concor_seq'::regclass);
 M   ALTER TABLE public.configuracion_correo ALTER COLUMN id_concor DROP DEFAULT;
       public       postgres    false    225    224    225                       2604    42004    detalle_compra cod_pro    DEFAULT     ?   ALTER TABLE ONLY public.detalle_compra ALTER COLUMN cod_pro SET DEFAULT nextval('public.detalle_compra_cod_pro_seq'::regclass);
 E   ALTER TABLE public.detalle_compra ALTER COLUMN cod_pro DROP DEFAULT;
       public       postgres    false    218    216    218                       2604    42005    detalle_compra id_com    DEFAULT     ~   ALTER TABLE ONLY public.detalle_compra ALTER COLUMN id_com SET DEFAULT nextval('public.detalle_compra_id_com_seq'::regclass);
 D   ALTER TABLE public.detalle_compra ALTER COLUMN id_com DROP DEFAULT;
       public       postgres    false    217    218    218                       2604    66521    detalle_compra id_detcom    DEFAULT     ?   ALTER TABLE ONLY public.detalle_compra ALTER COLUMN id_detcom SET DEFAULT nextval('public.detalle_compra_id_detcom_seq'::regclass);
 G   ALTER TABLE public.detalle_compra ALTER COLUMN id_detcom DROP DEFAULT;
       public       postgres    false    229    218                       2604    41959    detalle_venta cod_prod    DEFAULT     ?   ALTER TABLE ONLY public.detalle_venta ALTER COLUMN cod_prod SET DEFAULT nextval('public.detalle_venta_cod_prod_seq'::regclass);
 E   ALTER TABLE public.detalle_venta ALTER COLUMN cod_prod DROP DEFAULT;
       public       postgres    false    209    211    211                       2604    41960    detalle_venta id_venta    DEFAULT     ?   ALTER TABLE ONLY public.detalle_venta ALTER COLUMN id_venta SET DEFAULT nextval('public.detalle_venta_id_venta_seq'::regclass);
 E   ALTER TABLE public.detalle_venta ALTER COLUMN id_venta DROP DEFAULT;
       public       postgres    false    211    210    211                       2604    66482    detalle_venta id_detven    DEFAULT     ?   ALTER TABLE ONLY public.detalle_venta ALTER COLUMN id_detven SET DEFAULT nextval('public.detalle_venta_id_detven_seq'::regclass);
 F   ALTER TABLE public.detalle_venta ALTER COLUMN id_detven DROP DEFAULT;
       public       postgres    false    228    211                       2604    66440    mensajes_correo id_mencor    DEFAULT     ?   ALTER TABLE ONLY public.mensajes_correo ALTER COLUMN id_mencor SET DEFAULT nextval('public.mensajes_correo_id_mencor_seq'::regclass);
 H   ALTER TABLE public.mensajes_correo ALTER COLUMN id_mencor DROP DEFAULT;
       public       postgres    false    226    227    227                       2604    58201    permisos id_perm    DEFAULT     t   ALTER TABLE ONLY public.permisos ALTER COLUMN id_perm SET DEFAULT nextval('public.permisos_id_perm_seq'::regclass);
 ?   ALTER TABLE public.permisos ALTER COLUMN id_perm DROP DEFAULT;
       public       postgres    false    221    222    222            ?
           2604    41890    persona id_per    DEFAULT     p   ALTER TABLE ONLY public.persona ALTER COLUMN id_per SET DEFAULT nextval('public.persona_id_per_seq'::regclass);
 =   ALTER TABLE public.persona ALTER COLUMN id_per DROP DEFAULT;
       public       postgres    false    200    201    201                        2604    41900    producto cod_pro    DEFAULT     t   ALTER TABLE ONLY public.producto ALTER COLUMN cod_pro SET DEFAULT nextval('public.producto_cod_pro_seq'::regclass);
 ?   ALTER TABLE public.producto ALTER COLUMN cod_pro DROP DEFAULT;
       public       postgres    false    202    204    204                       2604    41901    producto cod_cat    DEFAULT     t   ALTER TABLE ONLY public.producto ALTER COLUMN cod_cat SET DEFAULT nextval('public.producto_cod_cat_seq'::regclass);
 ?   ALTER TABLE public.producto ALTER COLUMN cod_cat DROP DEFAULT;
       public       postgres    false    203    204    204                       2604    58193 
   rol id_rol    DEFAULT     h   ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);
 9   ALTER TABLE public.rol ALTER COLUMN id_rol DROP DEFAULT;
       public       postgres    false    220    219    220            ?
           2604    41874    usuario id_usu    DEFAULT     q   ALTER TABLE ONLY public.usuario ALTER COLUMN id_usu SET DEFAULT nextval('public.usuario_cod_usu_seq'::regclass);
 =   ALTER TABLE public.usuario ALTER COLUMN id_usu DROP DEFAULT;
       public       postgres    false    196    197    197                       2604    41937    venta id_venta    DEFAULT     p   ALTER TABLE ONLY public.venta ALTER COLUMN id_venta SET DEFAULT nextval('public.venta_id_venta_seq'::regclass);
 =   ALTER TABLE public.venta ALTER COLUMN id_venta DROP DEFAULT;
       public       postgres    false    205    208    208                       2604    41938    venta id_per    DEFAULT     l   ALTER TABLE ONLY public.venta ALTER COLUMN id_per SET DEFAULT nextval('public.venta_id_per_seq'::regclass);
 ;   ALTER TABLE public.venta ALTER COLUMN id_per DROP DEFAULT;
       public       postgres    false    208    206    208                       2604    41939    venta id_usu    DEFAULT     l   ALTER TABLE ONLY public.venta ALTER COLUMN id_usu SET DEFAULT nextval('public.venta_id_usu_seq'::regclass);
 ;   ALTER TABLE public.venta ALTER COLUMN id_usu DROP DEFAULT;
       public       postgres    false    208    207    208            ?          0    41879 	   categoria 
   TABLE DATA               H   COPY public.categoria (cod_cat, nom_cat, desc_cat, est_cat) FROM stdin;
    public       postgres    false    199   ?      ?          0    41979    compra 
   TABLE DATA               N   COPY public.compra (id_com, fecha_com, total_com, id_per, id_usu) FROM stdin;
    public       postgres    false    215   ?      ?          0    66429    configuracion_correo 
   TABLE DATA               p   COPY public.configuracion_correo (id_concor, host_concor, pue_concor, corren_concor, nomrem_concor) FROM stdin;
    public       postgres    false    225   ?      ?          0    42001    detalle_compra 
   TABLE DATA               j   COPY public.detalle_compra (cod_pro, id_com, subtotal_com, cant_com, id_detcom, prepro_decom) FROM stdin;
    public       postgres    false    218   ?      ?          0    41956    detalle_venta 
   TABLE DATA               b   COPY public.detalle_venta (cod_prod, id_venta, subtotal_venta, cant_venta, id_detven) FROM stdin;
    public       postgres    false    211   c      ?          0    66437    mensajes_correo 
   TABLE DATA               o   COPY public.mensajes_correo (id_mencor, asu_mencor, men_mencor, est_mencor, cod_mencor, id_concor) FROM stdin;
    public       postgres    false    227   l	      ?          0    58198    permisos 
   TABLE DATA               ?   COPY public.permisos (id_perm, nom_perm, des_perm) FROM stdin;
    public       postgres    false    222   ?	      ?          0    41887    persona 
   TABLE DATA               {   COPY public.persona (id_per, nom_per, doc_per, genero_per, tipo_per, correo_per, tipdoc_per, cel_per, dir_per) FROM stdin;
    public       postgres    false    201   ?
      ?          0    41897    producto 
   TABLE DATA               j   COPY public.producto (cod_pro, codbarr_pro, nom_pro, precio_pro, stock_pro, iva_pro, cod_cat) FROM stdin;
    public       postgres    false    204   $      ?          0    58190    rol 
   TABLE DATA               7   COPY public.rol (id_rol, nom_rol, est_rol) FROM stdin;
    public       postgres    false    220   &      ?          0    58207    rol_permisos 
   TABLE DATA               7   COPY public.rol_permisos (id_perm, id_rol) FROM stdin;
    public       postgres    false    223   ]      ?          0    41871    usuario 
   TABLE DATA               ?   COPY public.usuario (id_usu, nom_usu, ape_usu, correo_usu, docum_usu, estado_usu, genero_usu, con_usu, id_rol, tipdoc_usu, fecreg_usu, cel_usu) FROM stdin;
    public       postgres    false    197   ?      ?          0    41934    venta 
   TABLE DATA               \   COPY public.venta (id_venta, fecha_venta, total_venta, id_per, id_usu, est_ven) FROM stdin;
    public       postgres    false    208   X      ?           0    0    categoria_cod_cat_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.categoria_cod_cat_seq', 12, true);
            public       postgres    false    198            ?           0    0    compra_id_com_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.compra_id_com_seq', 15, true);
            public       postgres    false    212            ?           0    0    compra_id_per_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.compra_id_per_seq', 1, false);
            public       postgres    false    213            ?           0    0    compra_id_usu_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.compra_id_usu_seq', 1, false);
            public       postgres    false    214            ?           0    0 "   configuracion_correo_id_concor_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.configuracion_correo_id_concor_seq', 1, false);
            public       postgres    false    224            ?           0    0    detalle_compra_cod_pro_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.detalle_compra_cod_pro_seq', 1, false);
            public       postgres    false    216            ?           0    0    detalle_compra_id_com_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.detalle_compra_id_com_seq', 1, false);
            public       postgres    false    217            ?           0    0    detalle_compra_id_detcom_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.detalle_compra_id_detcom_seq', 43, true);
            public       postgres    false    229            ?           0    0    detalle_venta_cod_prod_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.detalle_venta_cod_prod_seq', 1, false);
            public       postgres    false    209            ?           0    0    detalle_venta_id_detven_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.detalle_venta_id_detven_seq', 64, true);
            public       postgres    false    228                        0    0    detalle_venta_id_venta_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.detalle_venta_id_venta_seq', 1, false);
            public       postgres    false    210                       0    0    mensajes_correo_id_mencor_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.mensajes_correo_id_mencor_seq', 1, false);
            public       postgres    false    226                       0    0    permisos_id_perm_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.permisos_id_perm_seq', 6, true);
            public       postgres    false    221                       0    0    persona_id_per_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.persona_id_per_seq', 52, true);
            public       postgres    false    200                       0    0    producto_cod_cat_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.producto_cod_cat_seq', 1, false);
            public       postgres    false    203                       0    0    producto_cod_pro_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.producto_cod_pro_seq', 23, true);
            public       postgres    false    202                       0    0    rol_id_rol_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.rol_id_rol_seq', 3, true);
            public       postgres    false    219                       0    0    usuario_cod_usu_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.usuario_cod_usu_seq', 24, true);
            public       postgres    false    196                       0    0    venta_id_per_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.venta_id_per_seq', 1, false);
            public       postgres    false    206            	           0    0    venta_id_usu_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.venta_id_usu_seq', 1, false);
            public       postgres    false    207            
           0    0    venta_id_venta_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.venta_id_venta_seq', 51, true);
            public       postgres    false    205                       2606    41884    categoria categoria_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (cod_cat);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public         postgres    false    199            &           2606    41986    compra compra_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (id_com);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public         postgres    false    215            0           2606    66434 .   configuracion_correo configuracion_correo_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.configuracion_correo
    ADD CONSTRAINT configuracion_correo_pkey PRIMARY KEY (id_concor);
 X   ALTER TABLE ONLY public.configuracion_correo DROP CONSTRAINT configuracion_correo_pkey;
       public         postgres    false    225            (           2606    42007 "   detalle_compra detalle_compra_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT detalle_compra_pkey PRIMARY KEY (cod_pro, id_com);
 L   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT detalle_compra_pkey;
       public         postgres    false    218    218            $           2606    41962     detalle_venta detalle_venta_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_pkey PRIMARY KEY (cod_prod, id_venta);
 J   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT detalle_venta_pkey;
       public         postgres    false    211    211            2           2606    66445 $   mensajes_correo mensajes_correo_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.mensajes_correo
    ADD CONSTRAINT mensajes_correo_pkey PRIMARY KEY (id_mencor);
 N   ALTER TABLE ONLY public.mensajes_correo DROP CONSTRAINT mensajes_correo_pkey;
       public         postgres    false    227            ,           2606    58206    permisos permisos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (id_perm);
 @   ALTER TABLE ONLY public.permisos DROP CONSTRAINT permisos_pkey;
       public         postgres    false    222                       2606    41892    persona persona_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (id_per);
 >   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_pkey;
       public         postgres    false    201                        2606    41903    producto producto_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (cod_pro);
 @   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_pkey;
       public         postgres    false    204            .           2606    58211    rol_permisos rol_permisos_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.rol_permisos
    ADD CONSTRAINT rol_permisos_pkey PRIMARY KEY (id_perm, id_rol);
 H   ALTER TABLE ONLY public.rol_permisos DROP CONSTRAINT rol_permisos_pkey;
       public         postgres    false    223    223            *           2606    58195    rol rol_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);
 6   ALTER TABLE ONLY public.rol DROP CONSTRAINT rol_pkey;
       public         postgres    false    220                       2606    49998    persona uq_correo_per 
   CONSTRAINT     V   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT uq_correo_per UNIQUE (correo_per);
 ?   ALTER TABLE ONLY public.persona DROP CONSTRAINT uq_correo_per;
       public         postgres    false    201                       2606    49996    usuario uq_correo_usu 
   CONSTRAINT     V   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uq_correo_usu UNIQUE (correo_usu);
 ?   ALTER TABLE ONLY public.usuario DROP CONSTRAINT uq_correo_usu;
       public         postgres    false    197                       2606    50004    persona uq_doc_per 
   CONSTRAINT     P   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT uq_doc_per UNIQUE (doc_per);
 <   ALTER TABLE ONLY public.persona DROP CONSTRAINT uq_doc_per;
       public         postgres    false    201                       2606    41876    usuario usuario_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usu);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    197            "           2606    41941    venta venta_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (id_venta);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    208            ?           2606    66528    mensajes_correo fk_concormen    FK CONSTRAINT     ?   ALTER TABLE ONLY public.mensajes_correo
    ADD CONSTRAINT fk_concormen FOREIGN KEY (id_concor) REFERENCES public.configuracion_correo(id_concor) NOT VALID;
 F   ALTER TABLE ONLY public.mensajes_correo DROP CONSTRAINT fk_concormen;
       public       postgres    false    2864    225    227            7           2606    41963    detalle_venta fk_dt_codprod    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_dt_codprod FOREIGN KEY (cod_prod) REFERENCES public.producto(cod_pro);
 E   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_dt_codprod;
       public       postgres    false    204    211    2848            ;           2606    42008    detalle_compra fk_dt_codprod    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_dt_codprod FOREIGN KEY (cod_pro) REFERENCES public.producto(cod_pro);
 F   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT fk_dt_codprod;
       public       postgres    false    218    204    2848            <           2606    42013    detalle_compra fk_dt_idcom    FK CONSTRAINT     }   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_dt_idcom FOREIGN KEY (id_com) REFERENCES public.compra(id_com);
 D   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT fk_dt_idcom;
       public       postgres    false    2854    218    215            8           2606    41968    detalle_venta fk_dt_idventa    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_dt_idventa FOREIGN KEY (id_venta) REFERENCES public.venta(id_venta);
 E   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_dt_idventa;
       public       postgres    false    208    2850    211            =           2606    58212    rol_permisos fk_idperm    FK CONSTRAINT     }   ALTER TABLE ONLY public.rol_permisos
    ADD CONSTRAINT fk_idperm FOREIGN KEY (id_perm) REFERENCES public.permisos(id_perm);
 @   ALTER TABLE ONLY public.rol_permisos DROP CONSTRAINT fk_idperm;
       public       postgres    false    223    222    2860            >           2606    58217    rol_permisos fk_idrol    FK CONSTRAINT     u   ALTER TABLE ONLY public.rol_permisos
    ADD CONSTRAINT fk_idrol FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);
 ?   ALTER TABLE ONLY public.rol_permisos DROP CONSTRAINT fk_idrol;
       public       postgres    false    223    2858    220            4           2606    41904    producto fk_producto_codcat    FK CONSTRAINT     ?   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_codcat FOREIGN KEY (cod_cat) REFERENCES public.categoria(cod_cat);
 E   ALTER TABLE ONLY public.producto DROP CONSTRAINT fk_producto_codcat;
       public       postgres    false    199    2840    204            3           2606    58229    usuario fk_rolusu    FK CONSTRAINT     {   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_rolusu FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol) NOT VALID;
 ;   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_rolusu;
       public       postgres    false    197    2858    220            5           2606    41942    venta fk_venta_idper    FK CONSTRAINT     x   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_idper FOREIGN KEY (id_per) REFERENCES public.persona(id_per);
 >   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_idper;
       public       postgres    false    2842    201    208            9           2606    41987    compra fk_venta_idper    FK CONSTRAINT     y   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_venta_idper FOREIGN KEY (id_per) REFERENCES public.persona(id_per);
 ?   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_venta_idper;
       public       postgres    false    215    2842    201            6           2606    41947    venta fk_venta_idusu    FK CONSTRAINT     x   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_idusu FOREIGN KEY (id_usu) REFERENCES public.usuario(id_usu);
 >   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_idusu;
       public       postgres    false    2838    197    208            :           2606    41992    compra fk_venta_idusu    FK CONSTRAINT     y   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_venta_idusu FOREIGN KEY (id_usu) REFERENCES public.usuario(id_usu);
 ?   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_venta_idusu;
       public       postgres    false    197    215    2838            ?     x?]P?R?0<?_?/??R^WJ/???#?V??J???G?Oȏ!'-?p??ҮV{/d{n?Sd[L??-?<?Y]?%2o?xJ????Sv???5<?/???)??Df?d?c<??Ҕ2Y*Z???KbM2??X?7?X?B??:??#???o?|?V+?b?P? ?;?pع?(??ũ9=Z.3?????????d?䎎????5AcDlQ??*o??r?3WҀ{??>???L?6ܱ?p_???N?~-t?:???L:`tcү??/?v?&      ?   ?   x?]?K?? E?qXE=,,??YK??D?@I?D:zX?FƊV?O??|???????
?yuē?E?*?2?u΋G?ds??J+6dV??[-o{?y"?*esQb޸/Z/?????̛ns9?W????M?
?,M{A???(M\?O?.ؕ?)O??;??????ˣ?Ah??t?????5A?????J{???]?? ??ST@8g?(?|?c?      ?   P   x?3?,?-)?K?M???K?ϵss2?RA<NSsμ??̴????????b????D?zN?Y? ?p? W?W?=... m? i      ?   q  x?USˑ? ;?*???;?Ahb+x?ױ?@pn?F??@???i????Z!????t??gmQ?v?O????k?
l?:?*?}]??(ot*??????m??~~?#7????m?8m?!?wlCmN?1?`Dbe?	(?!??V?=?,c?af?-?瓚<?XT?8wLJ|R?en?9y???x??sys#p?'}İ???G?O?S?X?0?#??.????t?V?C±?5v?%??Q??U???ќ`NG?B?<gB??q?1m|??,he6???rK?#Ծ3S,?q?'?6?КN;?????B+??駠u??Kǥ?4Vf?????????!??P???JD1t??St}?u]?Ќ?D      ?   ?  x?e??m?0D?R9?Ej?%???В???<P??/??Ϗ*_??*??+dL? @??E2A&?????>4O&??(aϵ??B:?.??d3?Ԝ?????`g????O!?5OR??;A?lI???6գ?ڍՍ??Z??????.??]???.??a?0R?u?f`Vܒ??m/$?F@Gڛ?^?W????q???g??[???n????#?Ij?Рu??>??rT%>???JN??<}??VVR?A*+5Ll????????d?l=?[???????g?????"??w?s9?e?X?rLr?R??1{??!?s$ꆔG!?j?4iuQ-:b??qT>l6??I?(?%}???Q?8?=+ׯ????<???5??q??z9ܖ?
7???????d?????5wV?1տ?Lp/q0O1k???r???3?'??U?7?)֭]??;?ָ/??v?????9???????/??^pn\??d??'?nl??.^??I=??ԛw???B5_9??4?\      ?   |   x?=?1
?0@??>?PY?C?v?(?,????,?^?G??B2t???f?^Y???+&)??x???I??y?ʔ^)
X?&9Q????A?C????!p?'0^?(??3w??&7?e???r/i      ?   {   x?3?tO-.?<?9O!%U?,5?$??3 H??$??P?9?dES?BE??Q?%????e?????2A?P??R?\???? &?e?j~~nA??P1.3ts?RSS򋀎.@5&????? ?b?      ?   ?  x?uTKo?0>S????-l=b??-???Ŏ????8p?LJ??ߏ??6(?~I?H???&?oł???*y+??P???7?8[XO????7IYU??4?8_J??????0??C??q???VȌ?????ߜ???u?x
$?Z???_??ð?q????F?&,?)??I??yD?U\(X;,?(???]Q
V????d?4v[t ?U???	????!?qv1F[?E?????)?\բiZN?M??A?s?
?ѼĢ??????[>|w?e+?¨^=	$ل??m????ݎUV??u?5o?hݶ?L<??aA???!?'j?ԃ?C??z0h?????.??^?A???Y????J??ND??~_???q?M&?N)0? ?!??k?u>?AH?? J(??Kp$?'?????p8??&?$??????6R??H????C??u??I??I7П?3???_?????(񚃦?,???s*??ߡ??9h? ?????p???G?<t?Ōf?3? -??a??t?=f|??L???D?s$?-??p?L??'P?&˵?y???d?dE=??#???nS?6=????
?Κ?X?d_&f?伽+??E?<??&PE?&??N?O8N?f??d???L?w??t񷷷f???ą?={?g???0ܼ      ?   ?  x?}?;r?0???)tv?2?6Efܦ?(J?L	@t?;??|?,D*?U??G????K?0a?Ɠu0?i?N??ր??j ? ?*4j?KI?\????????9k???\R7? ?O?r?(4`???XGd-?ԥi?\?']mEW??A#RA?5???"?
<E?(??Ǽ??^H?s&0^l]E???1???P??? ???+x??s????4?h2?Q?E)?????J???Xpև[D??|?)W?V9Tu??f?u)????Ic?ؒ????f*C=?ͭ|?i?A/?c????ʱͰHE?~?????U@?ÊA;0??T7??T?C'??#?H?xQ????IHԣ?~????????9??|9>$?I??~??? ?ӡ6?!98oG?=0?9??r?@????t%?wl?S???,??.?V??L?E??Z??ݐF???h??n?#????v/??/????????e??A?}3???H?ĭ??.ˇ??V)???͉      ?   '   x?3?tO-.?/?,?2?tL????,.)JL???qqq ?a	?      ?   '   x?3?4?2bc 6bS 6?4???l#.3 ????? h?      ?   ?  x????r?0???S?????r??`'?wg?T.? ?	?$?;?S̋???L??ʍ??Z????o?????/|YQ-8?A)?B????2R?	ٝ`t?T????-???2????k?ֲ?|s-V?e*?`:zx??U1Z???#]??S?2?r?o???9?	??jb?$6P??tԯ?E???}?D???m?zcٿ?????w??_???2??-??L+Zا?b0??y	?<(SV???2`??*,j؅3	ׂ?M? y??E??QxF?"?B?+yv??;>6??#~?N/?O??^Y?Ųp??????yw;7?(3???f????	?????&??H?P??E????͛uQ?q?q??`??OG???Z?O\?F&R.u?Ld?hlX?i?O?????F?9W??0???`??xą!?s?{??z[UM~?????5??c? ??? k??O??3p?֙???N??ygj??'??E???0???O.?EGhj?夜?@?DC9f2}F??I?A7? W	+???R???:{v?³[?q????S?^M???k?smJT?r!7J6???m/?'?;ĵ<?:??P?{??D?IQ???zjBV???~lǲZ?L???]]???jg?CK-?BG?lu?aW ?5!?%???]m?u.RH·???K4ǣ}?uP뛺?'T?ｹ7??O'??      ?   b  x?mUIn#1<?_???w???????1??v??@??,?2>V??	??????^ ?+?#=???BPV?od<<??iE??H? ???`y?h_???սp?X:`a??]-D8?j{Ѻc?:?uj???M*?th?W??ݩ??
C!OVu??5ו(????&?i"?Q?U?DMj?\R( ??%?}0??C?(??7<?Iə???p$?o	~&H?((?dI?Pt?????h ???qūtW???p?3\????nzW??L?XP????`??Nx??1?"??˗XzZ?4???????1:???3!%?g?o??[???O??`Ԣ????9I??"x"d?1c0??$f<֞?????#G?$??5??S*x'??b???]?? ????b??Pރɻ??"?ק.??!@4?Nq????Rj??*?+r"?q?g???i?X??x????Yt?T?l?????p?X??Y???$\?2??Y0?M???k??lıZ\	?4?%???D?m??:^n??e?^A=??!??i?E??=t?Ҹr"?????*mjfxu???Qp??g?x??????ᕴ?,[hڮH???\??ʲ,???<?     
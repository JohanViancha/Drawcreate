PGDMP         
            
    x         
   DRAWCREATE    11.8    11.8 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    41868 
   DRAWCREATE    DATABASE     �   CREATE DATABASE "DRAWCREATE" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
    DROP DATABASE "DRAWCREATE";
             postgres    false            �            1255    50012 7   agregar_categoria(character varying, character varying)    FUNCTION     �   CREATE FUNCTION public.agregar_categoria(character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	INSERT INTO categoria (nom_cat, desc_cat) values ($1,$2);
END
$_$;
 N   DROP FUNCTION public.agregar_categoria(character varying, character varying);
       public       postgres    false            �            1255    66446 �   agregar_persona(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.agregar_persona(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	INSERT INTO persona (nom_per,doc_per,genero_per,tipo_per,correo_per,tipdoc_per,cel_per,dir_per)
	values ($1,$2,$3,$4,$5,$6,$7,$8);
END
$_$;
 �   DROP FUNCTION public.agregar_persona(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);
       public       postgres    false            �            1255    58176 ?   agregar_producto(character varying, character varying, integer)    FUNCTION       CREATE FUNCTION public.agregar_producto(character varying, character varying, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	INSERT INTO producto (codbarr_pro, nom_pro,precio_pro,stock_pro,iva_pro,cod_cat) values ($1,$2,0,0,0,$3);
END
$_$;
 V   DROP FUNCTION public.agregar_producto(character varying, character varying, integer);
       public       postgres    false            �            1255    50000 #   bloquear_usuario(character varying)    FUNCTION     a  CREATE FUNCTION public.bloquear_usuario(character varying) RETURNS boolean
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
       public       postgres    false            �            1255    50029 )   cambiarestado_categoria(integer, boolean)    FUNCTION     �   CREATE FUNCTION public.cambiarestado_categoria(integer, boolean) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	UPDATE categoria set est_cat = $2 where cod_cat = $1;
END
$_$;
 @   DROP FUNCTION public.cambiarestado_categoria(integer, boolean);
       public       postgres    false            �            1255    58244 4   iniciar_sesion(character varying, character varying)    FUNCTION     D  CREATE FUNCTION public.iniciar_sesion(character varying, character varying) RETURNS TABLE(id_usuario integer, nombre character varying, apellido character varying, correo character varying, documento character varying, rol character varying, tipo_documento character varying, fecha_registro date, genero character varying, celular character varying)
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
						return query select -3,'El usuario usuario y/o contraseña son incorrectos'::varchar,'Por favor intente de nuevo'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar;

					end if;
		
				elsif (estado = 'I') then 
					return query select -1,'El usuario está inactivo'::varchar,'Por favor comuniquese con el administrador'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar;

				else
					return query select -2,'El usuario está bloqueado por intentos excedidos'::varchar,'Por favor comuniquese con el administrador'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar;			
				end if;
		else

			return query select -4,'No existe ningun usuario registrado con ese correo electronico'::varchar,'Por favor verifique los datos ingresados'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar;		

		end if;
		
		else
		
			return query select -5,'No hay registro de usuarios'::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar,''::varchar;
	end if;

END;
$_$;
 K   DROP FUNCTION public.iniciar_sesion(character varying, character varying);
       public       postgres    false            �            1255    50009    listar_categorias(integer)    FUNCTION     `  CREATE FUNCTION public.listar_categorias(integer) RETURNS TABLE(id_cat integer, nombre character varying, descripcion character varying, estado boolean)
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
       public       postgres    false            �            1255    58447    listar_permisos(integer)    FUNCTION     �  CREATE FUNCTION public.listar_permisos(integer) RETURNS TABLE(ide integer, nombre character varying, descripcion character varying)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN	
if($1 <> 0)then
	return query select per.id_perm, nom_perm,des_perm from permisos per inner join rol_permisos rp on per.id_perm = rp.id_perm
	inner join rol rol on rol.id_rol = rp.id_rol where rp.id_rol = $1;
	else
	return query select * from permisos;
end if;

END;
$_$;
 /   DROP FUNCTION public.listar_permisos(integer);
       public       postgres    false            �            1255    66449 "   listar_personas(character varying)    FUNCTION     �  CREATE FUNCTION public.listar_personas(character varying) RETURNS TABLE(ide integer, nombre character varying, documento character varying, genero character varying, correo character varying, tipodocumento character varying, celular character varying, direccion character varying)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	return query select id_per, nom_per, doc_per, genero_per,correo_per, tipdoc_per, cel_per, dir_per from persona where tipo_per = $1;
END;
$_$;
 9   DROP FUNCTION public.listar_personas(character varying);
       public       postgres    false            �            1255    58235    listar_productos(integer)    FUNCTION     �  CREATE FUNCTION public.listar_productos(integer) RETURNS TABLE(ide integer, codigo character varying, nombre character varying, categoria character varying, precio money, stock integer, iva numeric)
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
       public       postgres    false            �            1255    58446    listar_roles(integer)    FUNCTION     -  CREATE FUNCTION public.listar_roles(integer) RETURNS TABLE(ide integer, nombre character varying, estado boolean)
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	if($1 != 0)then
		
		return query select * from rol where est_cat = true;
	
	else
		return query select * from rol;

	end if;
	
	
END;
$_$;
 ,   DROP FUNCTION public.listar_roles(integer);
       public       postgres    false            �            1255    50028 B   modificar_categoria(integer, character varying, character varying)    FUNCTION     �   CREATE FUNCTION public.modificar_categoria(integer, character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
BEGIN
	UPDATE categoria set nom_cat = $2, desc_cat = $3 where cod_cat = $1;
END
$_$;
 Y   DROP FUNCTION public.modificar_categoria(integer, character varying, character varying);
       public       postgres    false            �            1259    41879 	   categoria    TABLE     �   CREATE TABLE public.categoria (
    cod_cat integer NOT NULL,
    nom_cat character varying(50) NOT NULL,
    desc_cat character varying(250) NOT NULL,
    est_cat boolean DEFAULT true
);
    DROP TABLE public.categoria;
       public         postgres    false            �            1259    41877    categoria_cod_cat_seq    SEQUENCE     �   CREATE SEQUENCE public.categoria_cod_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.categoria_cod_cat_seq;
       public       postgres    false    199            �           0    0    categoria_cod_cat_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.categoria_cod_cat_seq OWNED BY public.categoria.cod_cat;
            public       postgres    false    198            �            1259    41979    compra    TABLE     �   CREATE TABLE public.compra (
    id_com integer NOT NULL,
    fecha_com timestamp without time zone NOT NULL,
    total_com money NOT NULL,
    id_per integer NOT NULL,
    id_usu integer NOT NULL
);
    DROP TABLE public.compra;
       public         postgres    false            �            1259    41973    compra_id_com_seq    SEQUENCE     �   CREATE SEQUENCE public.compra_id_com_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.compra_id_com_seq;
       public       postgres    false    215            �           0    0    compra_id_com_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.compra_id_com_seq OWNED BY public.compra.id_com;
            public       postgres    false    212            �            1259    41975    compra_id_per_seq    SEQUENCE     �   CREATE SEQUENCE public.compra_id_per_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.compra_id_per_seq;
       public       postgres    false    215            �           0    0    compra_id_per_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.compra_id_per_seq OWNED BY public.compra.id_per;
            public       postgres    false    213            �            1259    41977    compra_id_usu_seq    SEQUENCE     �   CREATE SEQUENCE public.compra_id_usu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.compra_id_usu_seq;
       public       postgres    false    215            �           0    0    compra_id_usu_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.compra_id_usu_seq OWNED BY public.compra.id_usu;
            public       postgres    false    214            �            1259    66429    configuracion_correo    TABLE       CREATE TABLE public.configuracion_correo (
    id_concor integer NOT NULL,
    host_concor character varying(50) NOT NULL,
    pue_concor character varying(5),
    corren_concor character varying(100) NOT NULL,
    nomrem_concor character varying(250) NOT NULL
);
 (   DROP TABLE public.configuracion_correo;
       public         postgres    false            �            1259    66427 "   configuracion_correo_id_concor_seq    SEQUENCE     �   CREATE SEQUENCE public.configuracion_correo_id_concor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.configuracion_correo_id_concor_seq;
       public       postgres    false    225            �           0    0 "   configuracion_correo_id_concor_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.configuracion_correo_id_concor_seq OWNED BY public.configuracion_correo.id_concor;
            public       postgres    false    224            �            1259    42001    detalle_compra    TABLE     �   CREATE TABLE public.detalle_compra (
    cod_pro integer NOT NULL,
    id_com integer NOT NULL,
    subtotal_com money NOT NULL,
    cant_com integer NOT NULL
);
 "   DROP TABLE public.detalle_compra;
       public         postgres    false            �            1259    41997    detalle_compra_cod_pro_seq    SEQUENCE     �   CREATE SEQUENCE public.detalle_compra_cod_pro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.detalle_compra_cod_pro_seq;
       public       postgres    false    218            �           0    0    detalle_compra_cod_pro_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.detalle_compra_cod_pro_seq OWNED BY public.detalle_compra.cod_pro;
            public       postgres    false    216            �            1259    41999    detalle_compra_id_com_seq    SEQUENCE     �   CREATE SEQUENCE public.detalle_compra_id_com_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.detalle_compra_id_com_seq;
       public       postgres    false    218            �           0    0    detalle_compra_id_com_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.detalle_compra_id_com_seq OWNED BY public.detalle_compra.id_com;
            public       postgres    false    217            �            1259    41956    detalle_venta    TABLE     �   CREATE TABLE public.detalle_venta (
    cod_prod integer NOT NULL,
    id_venta integer NOT NULL,
    subtotal_venta money NOT NULL,
    cant_venta integer NOT NULL
);
 !   DROP TABLE public.detalle_venta;
       public         postgres    false            �            1259    41952    detalle_venta_cod_prod_seq    SEQUENCE     �   CREATE SEQUENCE public.detalle_venta_cod_prod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.detalle_venta_cod_prod_seq;
       public       postgres    false    211            �           0    0    detalle_venta_cod_prod_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.detalle_venta_cod_prod_seq OWNED BY public.detalle_venta.cod_prod;
            public       postgres    false    209            �            1259    41954    detalle_venta_id_venta_seq    SEQUENCE     �   CREATE SEQUENCE public.detalle_venta_id_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.detalle_venta_id_venta_seq;
       public       postgres    false    211            �           0    0    detalle_venta_id_venta_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.detalle_venta_id_venta_seq OWNED BY public.detalle_venta.id_venta;
            public       postgres    false    210            �            1259    66437    mensajes_correo    TABLE     �   CREATE TABLE public.mensajes_correo (
    id_mencor integer NOT NULL,
    asu_mencor character varying(100) NOT NULL,
    men_mencor text,
    est_mencor boolean
);
 #   DROP TABLE public.mensajes_correo;
       public         postgres    false            �            1259    66435    mensajes_correo_id_mencor_seq    SEQUENCE     �   CREATE SEQUENCE public.mensajes_correo_id_mencor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.mensajes_correo_id_mencor_seq;
       public       postgres    false    227            �           0    0    mensajes_correo_id_mencor_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.mensajes_correo_id_mencor_seq OWNED BY public.mensajes_correo.id_mencor;
            public       postgres    false    226            �            1259    58198    permisos    TABLE     �   CREATE TABLE public.permisos (
    id_perm integer NOT NULL,
    nom_perm character varying(250) NOT NULL,
    des_perm character varying(250) NOT NULL
);
    DROP TABLE public.permisos;
       public         postgres    false            �            1259    58196    permisos_id_perm_seq    SEQUENCE     �   CREATE SEQUENCE public.permisos_id_perm_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.permisos_id_perm_seq;
       public       postgres    false    222            �           0    0    permisos_id_perm_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.permisos_id_perm_seq OWNED BY public.permisos.id_perm;
            public       postgres    false    221            �            1259    41887    persona    TABLE     s  CREATE TABLE public.persona (
    id_per integer NOT NULL,
    nom_per character varying(100) NOT NULL,
    doc_per character varying(30) NOT NULL,
    genero_per character varying(15) NOT NULL,
    tipo_per character varying(20) NOT NULL,
    correo_per character varying(100) NOT NULL,
    tipdoc_per character varying(150),
    cel_per character varying(20),
    dir_per character varying(255),
    CONSTRAINT ck_genero_per CHECK (((genero_per)::text = ANY (ARRAY[('Masculino'::character varying)::text, ('Femenino'::character varying)::text, ('Otro'::character varying)::text, ('No aplica'::character varying)::text])))
);
    DROP TABLE public.persona;
       public         postgres    false            �            1259    41885    persona_id_per_seq    SEQUENCE     �   CREATE SEQUENCE public.persona_id_per_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.persona_id_per_seq;
       public       postgres    false    201            �           0    0    persona_id_per_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.persona_id_per_seq OWNED BY public.persona.id_per;
            public       postgres    false    200            �            1259    41897    producto    TABLE       CREATE TABLE public.producto (
    cod_pro integer NOT NULL,
    codbarr_pro character varying(30) NOT NULL,
    nom_pro character varying(250) NOT NULL,
    precio_pro money NOT NULL,
    stock_pro integer NOT NULL,
    iva_pro numeric(4,2) NOT NULL,
    cod_cat integer NOT NULL
);
    DROP TABLE public.producto;
       public         postgres    false            �            1259    41895    producto_cod_cat_seq    SEQUENCE     �   CREATE SEQUENCE public.producto_cod_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.producto_cod_cat_seq;
       public       postgres    false    204            �           0    0    producto_cod_cat_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.producto_cod_cat_seq OWNED BY public.producto.cod_cat;
            public       postgres    false    203            �            1259    41893    producto_cod_pro_seq    SEQUENCE     �   CREATE SEQUENCE public.producto_cod_pro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.producto_cod_pro_seq;
       public       postgres    false    204            �           0    0    producto_cod_pro_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.producto_cod_pro_seq OWNED BY public.producto.cod_pro;
            public       postgres    false    202            �            1259    58190    rol    TABLE     �   CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nom_rol character varying(40) NOT NULL,
    est_rol boolean NOT NULL
);
    DROP TABLE public.rol;
       public         postgres    false            �            1259    58188    rol_id_rol_seq    SEQUENCE     �   CREATE SEQUENCE public.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.rol_id_rol_seq;
       public       postgres    false    220            �           0    0    rol_id_rol_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;
            public       postgres    false    219            �            1259    58207    rol_permisos    TABLE     `   CREATE TABLE public.rol_permisos (
    id_perm integer NOT NULL,
    id_rol integer NOT NULL
);
     DROP TABLE public.rol_permisos;
       public         postgres    false            �            1259    41871    usuario    TABLE     �  CREATE TABLE public.usuario (
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
       public         postgres    false            �            1259    41869    usuario_cod_usu_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_cod_usu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.usuario_cod_usu_seq;
       public       postgres    false    197            �           0    0    usuario_cod_usu_seq    SEQUENCE OWNED BY     J   ALTER SEQUENCE public.usuario_cod_usu_seq OWNED BY public.usuario.id_usu;
            public       postgres    false    196            �            1259    41934    venta    TABLE     �   CREATE TABLE public.venta (
    id_venta integer NOT NULL,
    fecha_venta timestamp without time zone NOT NULL,
    total_venta money NOT NULL,
    id_per integer NOT NULL,
    id_usu integer NOT NULL
);
    DROP TABLE public.venta;
       public         postgres    false            �            1259    41930    venta_id_per_seq    SEQUENCE     �   CREATE SEQUENCE public.venta_id_per_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.venta_id_per_seq;
       public       postgres    false    208            �           0    0    venta_id_per_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.venta_id_per_seq OWNED BY public.venta.id_per;
            public       postgres    false    206            �            1259    41932    venta_id_usu_seq    SEQUENCE     �   CREATE SEQUENCE public.venta_id_usu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.venta_id_usu_seq;
       public       postgres    false    208            �           0    0    venta_id_usu_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.venta_id_usu_seq OWNED BY public.venta.id_usu;
            public       postgres    false    207            �            1259    41928    venta_id_venta_seq    SEQUENCE     �   CREATE SEQUENCE public.venta_id_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.venta_id_venta_seq;
       public       postgres    false    208            �           0    0    venta_id_venta_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.venta_id_venta_seq OWNED BY public.venta.id_venta;
            public       postgres    false    205            �
           2604    41882    categoria cod_cat    DEFAULT     v   ALTER TABLE ONLY public.categoria ALTER COLUMN cod_cat SET DEFAULT nextval('public.categoria_cod_cat_seq'::regclass);
 @   ALTER TABLE public.categoria ALTER COLUMN cod_cat DROP DEFAULT;
       public       postgres    false    199    198    199            �
           2604    41982    compra id_com    DEFAULT     n   ALTER TABLE ONLY public.compra ALTER COLUMN id_com SET DEFAULT nextval('public.compra_id_com_seq'::regclass);
 <   ALTER TABLE public.compra ALTER COLUMN id_com DROP DEFAULT;
       public       postgres    false    215    212    215            �
           2604    41983    compra id_per    DEFAULT     n   ALTER TABLE ONLY public.compra ALTER COLUMN id_per SET DEFAULT nextval('public.compra_id_per_seq'::regclass);
 <   ALTER TABLE public.compra ALTER COLUMN id_per DROP DEFAULT;
       public       postgres    false    215    213    215            �
           2604    41984    compra id_usu    DEFAULT     n   ALTER TABLE ONLY public.compra ALTER COLUMN id_usu SET DEFAULT nextval('public.compra_id_usu_seq'::regclass);
 <   ALTER TABLE public.compra ALTER COLUMN id_usu DROP DEFAULT;
       public       postgres    false    215    214    215            �
           2604    66432    configuracion_correo id_concor    DEFAULT     �   ALTER TABLE ONLY public.configuracion_correo ALTER COLUMN id_concor SET DEFAULT nextval('public.configuracion_correo_id_concor_seq'::regclass);
 M   ALTER TABLE public.configuracion_correo ALTER COLUMN id_concor DROP DEFAULT;
       public       postgres    false    224    225    225            �
           2604    42004    detalle_compra cod_pro    DEFAULT     �   ALTER TABLE ONLY public.detalle_compra ALTER COLUMN cod_pro SET DEFAULT nextval('public.detalle_compra_cod_pro_seq'::regclass);
 E   ALTER TABLE public.detalle_compra ALTER COLUMN cod_pro DROP DEFAULT;
       public       postgres    false    216    218    218            �
           2604    42005    detalle_compra id_com    DEFAULT     ~   ALTER TABLE ONLY public.detalle_compra ALTER COLUMN id_com SET DEFAULT nextval('public.detalle_compra_id_com_seq'::regclass);
 D   ALTER TABLE public.detalle_compra ALTER COLUMN id_com DROP DEFAULT;
       public       postgres    false    218    217    218            �
           2604    41959    detalle_venta cod_prod    DEFAULT     �   ALTER TABLE ONLY public.detalle_venta ALTER COLUMN cod_prod SET DEFAULT nextval('public.detalle_venta_cod_prod_seq'::regclass);
 E   ALTER TABLE public.detalle_venta ALTER COLUMN cod_prod DROP DEFAULT;
       public       postgres    false    211    209    211            �
           2604    41960    detalle_venta id_venta    DEFAULT     �   ALTER TABLE ONLY public.detalle_venta ALTER COLUMN id_venta SET DEFAULT nextval('public.detalle_venta_id_venta_seq'::regclass);
 E   ALTER TABLE public.detalle_venta ALTER COLUMN id_venta DROP DEFAULT;
       public       postgres    false    211    210    211            �
           2604    66440    mensajes_correo id_mencor    DEFAULT     �   ALTER TABLE ONLY public.mensajes_correo ALTER COLUMN id_mencor SET DEFAULT nextval('public.mensajes_correo_id_mencor_seq'::regclass);
 H   ALTER TABLE public.mensajes_correo ALTER COLUMN id_mencor DROP DEFAULT;
       public       postgres    false    226    227    227            �
           2604    58201    permisos id_perm    DEFAULT     t   ALTER TABLE ONLY public.permisos ALTER COLUMN id_perm SET DEFAULT nextval('public.permisos_id_perm_seq'::regclass);
 ?   ALTER TABLE public.permisos ALTER COLUMN id_perm DROP DEFAULT;
       public       postgres    false    221    222    222            �
           2604    41890    persona id_per    DEFAULT     p   ALTER TABLE ONLY public.persona ALTER COLUMN id_per SET DEFAULT nextval('public.persona_id_per_seq'::regclass);
 =   ALTER TABLE public.persona ALTER COLUMN id_per DROP DEFAULT;
       public       postgres    false    201    200    201            �
           2604    41900    producto cod_pro    DEFAULT     t   ALTER TABLE ONLY public.producto ALTER COLUMN cod_pro SET DEFAULT nextval('public.producto_cod_pro_seq'::regclass);
 ?   ALTER TABLE public.producto ALTER COLUMN cod_pro DROP DEFAULT;
       public       postgres    false    204    202    204            �
           2604    41901    producto cod_cat    DEFAULT     t   ALTER TABLE ONLY public.producto ALTER COLUMN cod_cat SET DEFAULT nextval('public.producto_cod_cat_seq'::regclass);
 ?   ALTER TABLE public.producto ALTER COLUMN cod_cat DROP DEFAULT;
       public       postgres    false    204    203    204            �
           2604    58193 
   rol id_rol    DEFAULT     h   ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);
 9   ALTER TABLE public.rol ALTER COLUMN id_rol DROP DEFAULT;
       public       postgres    false    219    220    220            �
           2604    41874    usuario id_usu    DEFAULT     q   ALTER TABLE ONLY public.usuario ALTER COLUMN id_usu SET DEFAULT nextval('public.usuario_cod_usu_seq'::regclass);
 =   ALTER TABLE public.usuario ALTER COLUMN id_usu DROP DEFAULT;
       public       postgres    false    196    197    197            �
           2604    41937    venta id_venta    DEFAULT     p   ALTER TABLE ONLY public.venta ALTER COLUMN id_venta SET DEFAULT nextval('public.venta_id_venta_seq'::regclass);
 =   ALTER TABLE public.venta ALTER COLUMN id_venta DROP DEFAULT;
       public       postgres    false    205    208    208            �
           2604    41938    venta id_per    DEFAULT     l   ALTER TABLE ONLY public.venta ALTER COLUMN id_per SET DEFAULT nextval('public.venta_id_per_seq'::regclass);
 ;   ALTER TABLE public.venta ALTER COLUMN id_per DROP DEFAULT;
       public       postgres    false    206    208    208            �
           2604    41939    venta id_usu    DEFAULT     l   ALTER TABLE ONLY public.venta ALTER COLUMN id_usu SET DEFAULT nextval('public.venta_id_usu_seq'::regclass);
 ;   ALTER TABLE public.venta ALTER COLUMN id_usu DROP DEFAULT;
       public       postgres    false    208    207    208            �          0    41879 	   categoria 
   TABLE DATA               H   COPY public.categoria (cod_cat, nom_cat, desc_cat, est_cat) FROM stdin;
    public       postgres    false    199   ؾ       �          0    41979    compra 
   TABLE DATA               N   COPY public.compra (id_com, fecha_com, total_com, id_per, id_usu) FROM stdin;
    public       postgres    false    215   ��       �          0    66429    configuracion_correo 
   TABLE DATA               p   COPY public.configuracion_correo (id_concor, host_concor, pue_concor, corren_concor, nomrem_concor) FROM stdin;
    public       postgres    false    225   I�       �          0    42001    detalle_compra 
   TABLE DATA               Q   COPY public.detalle_compra (cod_pro, id_com, subtotal_com, cant_com) FROM stdin;
    public       postgres    false    218   f�       �          0    41956    detalle_venta 
   TABLE DATA               W   COPY public.detalle_venta (cod_prod, id_venta, subtotal_venta, cant_venta) FROM stdin;
    public       postgres    false    211   k�       �          0    66437    mensajes_correo 
   TABLE DATA               X   COPY public.mensajes_correo (id_mencor, asu_mencor, men_mencor, est_mencor) FROM stdin;
    public       postgres    false    227   �       �          0    58198    permisos 
   TABLE DATA               ?   COPY public.permisos (id_perm, nom_perm, des_perm) FROM stdin;
    public       postgres    false    222   ��       �          0    41887    persona 
   TABLE DATA               {   COPY public.persona (id_per, nom_per, doc_per, genero_per, tipo_per, correo_per, tipdoc_per, cel_per, dir_per) FROM stdin;
    public       postgres    false    201   '�       �          0    41897    producto 
   TABLE DATA               j   COPY public.producto (cod_pro, codbarr_pro, nom_pro, precio_pro, stock_pro, iva_pro, cod_cat) FROM stdin;
    public       postgres    false    204   ]�       �          0    58190    rol 
   TABLE DATA               7   COPY public.rol (id_rol, nom_rol, est_rol) FROM stdin;
    public       postgres    false    220   D�       �          0    58207    rol_permisos 
   TABLE DATA               7   COPY public.rol_permisos (id_perm, id_rol) FROM stdin;
    public       postgres    false    223   z�       �          0    41871    usuario 
   TABLE DATA               �   COPY public.usuario (id_usu, nom_usu, ape_usu, correo_usu, docum_usu, estado_usu, genero_usu, con_usu, id_rol, tipdoc_usu, fecreg_usu, cel_usu) FROM stdin;
    public       postgres    false    197   ��       �          0    41934    venta 
   TABLE DATA               S   COPY public.venta (id_venta, fecha_venta, total_venta, id_per, id_usu) FROM stdin;
    public       postgres    false    208   ��       �           0    0    categoria_cod_cat_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.categoria_cod_cat_seq', 7, true);
            public       postgres    false    198            �           0    0    compra_id_com_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.compra_id_com_seq', 10, true);
            public       postgres    false    212            �           0    0    compra_id_per_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.compra_id_per_seq', 1, false);
            public       postgres    false    213            �           0    0    compra_id_usu_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.compra_id_usu_seq', 1, false);
            public       postgres    false    214            �           0    0 "   configuracion_correo_id_concor_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.configuracion_correo_id_concor_seq', 1, false);
            public       postgres    false    224            �           0    0    detalle_compra_cod_pro_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.detalle_compra_cod_pro_seq', 1, false);
            public       postgres    false    216            �           0    0    detalle_compra_id_com_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.detalle_compra_id_com_seq', 1, false);
            public       postgres    false    217            �           0    0    detalle_venta_cod_prod_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.detalle_venta_cod_prod_seq', 1, false);
            public       postgres    false    209            �           0    0    detalle_venta_id_venta_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.detalle_venta_id_venta_seq', 1, false);
            public       postgres    false    210            �           0    0    mensajes_correo_id_mencor_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.mensajes_correo_id_mencor_seq', 1, false);
            public       postgres    false    226            �           0    0    permisos_id_perm_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.permisos_id_perm_seq', 6, true);
            public       postgres    false    221            �           0    0    persona_id_per_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.persona_id_per_seq', 20, true);
            public       postgres    false    200            �           0    0    producto_cod_cat_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.producto_cod_cat_seq', 1, false);
            public       postgres    false    203            �           0    0    producto_cod_pro_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.producto_cod_pro_seq', 20, true);
            public       postgres    false    202            �           0    0    rol_id_rol_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.rol_id_rol_seq', 3, true);
            public       postgres    false    219            �           0    0    usuario_cod_usu_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.usuario_cod_usu_seq', 8, true);
            public       postgres    false    196            �           0    0    venta_id_per_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.venta_id_per_seq', 1, false);
            public       postgres    false    206            �           0    0    venta_id_usu_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.venta_id_usu_seq', 1, false);
            public       postgres    false    207            �           0    0    venta_id_venta_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.venta_id_venta_seq', 10, true);
            public       postgres    false    205            �
           2606    41884    categoria categoria_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (cod_cat);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public         postgres    false    199                       2606    41986    compra compra_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (id_com);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public         postgres    false    215                       2606    66434 .   configuracion_correo configuracion_correo_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.configuracion_correo
    ADD CONSTRAINT configuracion_correo_pkey PRIMARY KEY (id_concor);
 X   ALTER TABLE ONLY public.configuracion_correo DROP CONSTRAINT configuracion_correo_pkey;
       public         postgres    false    225                       2606    42007 "   detalle_compra detalle_compra_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT detalle_compra_pkey PRIMARY KEY (cod_pro, id_com);
 L   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT detalle_compra_pkey;
       public         postgres    false    218    218            	           2606    41962     detalle_venta detalle_venta_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_pkey PRIMARY KEY (cod_prod, id_venta);
 J   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT detalle_venta_pkey;
       public         postgres    false    211    211                       2606    66445 $   mensajes_correo mensajes_correo_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.mensajes_correo
    ADD CONSTRAINT mensajes_correo_pkey PRIMARY KEY (id_mencor);
 N   ALTER TABLE ONLY public.mensajes_correo DROP CONSTRAINT mensajes_correo_pkey;
       public         postgres    false    227                       2606    58206    permisos permisos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (id_perm);
 @   ALTER TABLE ONLY public.permisos DROP CONSTRAINT permisos_pkey;
       public         postgres    false    222            �
           2606    41892    persona persona_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (id_per);
 >   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_pkey;
       public         postgres    false    201                       2606    41903    producto producto_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (cod_pro);
 @   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_pkey;
       public         postgres    false    204                       2606    58211    rol_permisos rol_permisos_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.rol_permisos
    ADD CONSTRAINT rol_permisos_pkey PRIMARY KEY (id_perm, id_rol);
 H   ALTER TABLE ONLY public.rol_permisos DROP CONSTRAINT rol_permisos_pkey;
       public         postgres    false    223    223                       2606    58195    rol rol_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);
 6   ALTER TABLE ONLY public.rol DROP CONSTRAINT rol_pkey;
       public         postgres    false    220                       2606    49998    persona uq_correo_per 
   CONSTRAINT     V   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT uq_correo_per UNIQUE (correo_per);
 ?   ALTER TABLE ONLY public.persona DROP CONSTRAINT uq_correo_per;
       public         postgres    false    201            �
           2606    49996    usuario uq_correo_usu 
   CONSTRAINT     V   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uq_correo_usu UNIQUE (correo_usu);
 ?   ALTER TABLE ONLY public.usuario DROP CONSTRAINT uq_correo_usu;
       public         postgres    false    197                       2606    50004    persona uq_doc_per 
   CONSTRAINT     P   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT uq_doc_per UNIQUE (doc_per);
 <   ALTER TABLE ONLY public.persona DROP CONSTRAINT uq_doc_per;
       public         postgres    false    201            �
           2606    41876    usuario usuario_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usu);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    197                       2606    41941    venta venta_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (id_venta);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    208                       2606    41963    detalle_venta fk_dt_codprod    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_dt_codprod FOREIGN KEY (cod_prod) REFERENCES public.producto(cod_pro);
 E   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_dt_codprod;
       public       postgres    false    204    2821    211                        2606    42008    detalle_compra fk_dt_codprod    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_dt_codprod FOREIGN KEY (cod_pro) REFERENCES public.producto(cod_pro);
 F   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT fk_dt_codprod;
       public       postgres    false    204    2821    218            !           2606    42013    detalle_compra fk_dt_idcom    FK CONSTRAINT     }   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_dt_idcom FOREIGN KEY (id_com) REFERENCES public.compra(id_com);
 D   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT fk_dt_idcom;
       public       postgres    false    2827    218    215                       2606    41968    detalle_venta fk_dt_idventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_dt_idventa FOREIGN KEY (id_venta) REFERENCES public.venta(id_venta);
 E   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_dt_idventa;
       public       postgres    false    2823    211    208            "           2606    58212    rol_permisos fk_idperm    FK CONSTRAINT     }   ALTER TABLE ONLY public.rol_permisos
    ADD CONSTRAINT fk_idperm FOREIGN KEY (id_perm) REFERENCES public.permisos(id_perm);
 @   ALTER TABLE ONLY public.rol_permisos DROP CONSTRAINT fk_idperm;
       public       postgres    false    222    223    2833            #           2606    58217    rol_permisos fk_idrol    FK CONSTRAINT     u   ALTER TABLE ONLY public.rol_permisos
    ADD CONSTRAINT fk_idrol FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);
 ?   ALTER TABLE ONLY public.rol_permisos DROP CONSTRAINT fk_idrol;
       public       postgres    false    223    220    2831                       2606    41904    producto fk_producto_codcat    FK CONSTRAINT     �   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_codcat FOREIGN KEY (cod_cat) REFERENCES public.categoria(cod_cat);
 E   ALTER TABLE ONLY public.producto DROP CONSTRAINT fk_producto_codcat;
       public       postgres    false    204    199    2813                       2606    58229    usuario fk_rolusu    FK CONSTRAINT     {   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_rolusu FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol) NOT VALID;
 ;   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_rolusu;
       public       postgres    false    220    197    2831                       2606    41942    venta fk_venta_idper    FK CONSTRAINT     x   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_idper FOREIGN KEY (id_per) REFERENCES public.persona(id_per);
 >   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_idper;
       public       postgres    false    208    201    2815                       2606    41987    compra fk_venta_idper    FK CONSTRAINT     y   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_venta_idper FOREIGN KEY (id_per) REFERENCES public.persona(id_per);
 ?   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_venta_idper;
       public       postgres    false    215    2815    201                       2606    41947    venta fk_venta_idusu    FK CONSTRAINT     x   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_idusu FOREIGN KEY (id_usu) REFERENCES public.usuario(id_usu);
 >   ALTER TABLE ONLY public.venta DROP CONSTRAINT fk_venta_idusu;
       public       postgres    false    2811    208    197                       2606    41992    compra fk_venta_idusu    FK CONSTRAINT     y   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_venta_idusu FOREIGN KEY (id_usu) REFERENCES public.usuario(id_usu);
 ?   ALTER TABLE ONLY public.compra DROP CONSTRAINT fk_venta_idusu;
       public       postgres    false    2811    215    197            �   �   x�]�KnAD��S�	��=I6��`���cHGf�n$�g�bx�O�R�U�jK
��l"�<I]B�5���g7�O?���S5` _�dHŤ�{;F�1�vcX ��E^*��5�A�Kž�'���*�j�6}Q�d�x��aJ�tz�Q�Ld+~����,0�Y��ݥ�����7�r����n_��sW�j�      �   �   x�U�A
C!е9�_t��$Ѩ=K���_Dp#<&�HQ(�������@�?"e�n7X5:�ì��"���v�b�UG�����%�
���T��%7h��9�������XZd>[�[�9��{�M��%/hi�o%��wDV      �      x������ � �      �   �   x�U��q!E��>�����2��a!�����"���� �(\�1\�*�3�H�p"15*ZbP���zm�Y�;q����~U����y%d��4�0� XD16r��H�E�wZj��`+��r1ؿ0	��T/	oc}�-������ZrP'3ɳNBR�"n�)���籖��BT�q�^�H$B�#R�7�{j���2W�GNv��7��-B���A���HK�r�T�w�G�M�I�W���������6r&      �     x�U�;rE1Ck�U�H�� �����a���g�iܾ�X~�=�@�����7����߽�W��N"R���(�	� m�Z ��C�K\�р�HyG��ӳ�`Jo�5=(<�'-�l�v0�b��K�g V��ʑ��.�9��B��� a�$:�,��#�z������3K���4˧j8��8)�t��N0��	iB��!�1����m-��@��hg���r,fv-E��ਮ��QR�02|0ġv�r�q����y� ��pt      �      x������ � �      �   {   x�3�tO-.�<�9O!%U�,5�$��3 H��$��P�9�dES�BE��Q�%����e�����2A�P��R�\���� &�e�j~~nA��P1.3ts�RSS򋀎.@5&����� �b�      �   &  x�u��j�0���Svn�-�Ine�V�ر5v:�v[ַ�Ӯ4��N��OG g~l^���Bx�����b8�C�3l7�*p���DޤD7��l�G�u����c���<��݄RLd7��0L:�]���
��r�	!���� 9-P��O���G:���!�h�'ȺR6s��Z��nمZ����6��GM��%@��J��6�ƶ`%����s��v�A��U�R,6�ѷ�M��7/Y W�u#�j�����QBO�`����D}��.��c(�b�,��$�|      �   �  x�}�=��@�k�)T��!9��r�m� iӌe�p {�J�;���b�H��l�4�)��B�%����?�>4,;k�Gk�N?h�c�d] ������'N,���)+�/�eTTn����N%�������=���H[��:pRt�D`�m��5W�O�VT\_��h)ƨF�)O��&lW]6�(q@u�!±/�2=��w.hwU�"��/cWIڹkc�ϠH7��|���?Ż��ʢ<���n�����o�˼񼪣a���%AM��G�ø�n͘�/!.Ӊ�0��~\4ӆn+�h�eY������.�(���`�����~Y1���T�.r"��Eh�|��KY2ێ�kh����5�fO�97K�Z�ȸ���ĉ�5��zg�$�Z��s�ߗ��zƢMj��]��|��t=�K,�$HI��>Ջ���I�_��ۯo�R��K>O������;c�Q��(      �   &   x�3�tL����,.)JL�/�,�2�tO-.3c���� �T	�      �       x�3�4�2bc 6bS0m�s��qqq C��      �     x���AN�0EדS��;��]Q%$p�n�xJ9���T�N����4 �BhV�������Dޜ�dy��D3p>Z�hpZ���!F
�8WdR5�y����ni"o}V�	ۜq���M��W�/�.�v��1���/xJ� Z?�b"��޴���\%�FwR���<$�7��K.K�ncB���zbqf&�^.�*_�+(�]+T����ߡ�R��s���E���=EOgx��x@���:����������u�|䋼���xXX��      �   �   x�U�A� �3~E=�h����E-��F�.R
��� ��W^���{���N���j�����\LY<2�j@H4��Td�tq�I6j;tD�Ibfڒ�U�� e��GRQ׽�Q_l����[��4����;m��4�g���r�g4�T"���E     
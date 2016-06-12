-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-06-2016 a las 19:12:20
-- Versión del servidor: 5.5.49-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `ecommerce`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_address`(in user_id int)
BEGIN
	
	if (select id from ubicacion where usuario_id = user_id) then
		delete from ubicacion where usuario_id = user_id;
	else
		select ('la ubicacion del usuario no existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_category`(in id_c int)
BEGIN
	if(select id from categoria where id = id_c) then
		delete from categoria where id = id_c;
	else
		select ('no exite cierta categoria');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_country`(in id_c int)
BEGIN
	if (select id from pais where id = id_c) then
		delete from pais where id = id_c;
		select ('success');
	else
		select ('no existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_product`(in id_p int)
BEGIN
		if(select id from producto where id = id_p) then
			delete from producto where id = id_p;
		else
			select ('No existe el producto');
		end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_rol`(in id_r int)
BEGIN
	if(select id from rol where id = id_r) then
		delete from rol where id = id_r;
	else
		select ('no exite el rol');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_usu_rol`()
BEGIN
	if(select id from usuario_has_role where usuario_id = usu_id) then
		delete from usuario_has_role where usuario_id = usu_id;
	else
		select('no existe el usuario');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_address`(in city int, in user_id int, in address varchar(20))
BEGIN
	if(select usuario_id from ubicacion where usuario = user_id) then
		select('este usuario ya tiene una ubicacion');
	else
		if (select id from usuario where id = user_id ) then
			insert into ubicacion value(city, user_id, address);
		else
			select ('el usuario no esta registrado');
		end if;
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_category`(in nom varchar(45), in desp varchar(45))
BEGIN
	if(select nombre from categoria where nombre = nom) then
		select('ya existe');
	else
		insert into categoria value(nom, descp);
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_city`(in nombre varchar(45), in p_id int)
BEGIN
	if(select id from pais where id = p_id)then
		insert into ciudad value(nombre, p_id);
	else
		select('No existe el pais');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_country`(in nom varchar(45), in descp varchar(45))
BEGIN
	if(select nombre from pais where nombre = nom) then
		select('ya existe');
	else
		insert into pais value(nom, descp);
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_order_buyer`(in id_pro int, in id_usu int, in dat datetime, in been varchar(45))
BEGIN
	if(select id from producto where id = id_pro) then
		if(select id from usuario where id = id_usu) then
			insert into orden_comprador value(id_pro, id_usu, dat, been);
		else
			select('el usuario no existe');
		end if;
	else
		select('el producto');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_product`(in nom varchar(45), in price float, in amount int, in brand varchar(45), in id_usu int, in id_sub_cat int, in been varchar(45), in dat datetime, in img varchar(45))
BEGIN
	insert into producto value(id_p, nom, price, amount, brand, id_usu, id_sub_cat, been, dat, img);
	select ('se inserto corretamente');
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_rol`(in title varchar(45), in desp varchar(45))
BEGIN
	if(select titulo from rol where titulo = title) then
		select('el rol ya existe');
	else
		insert into rol value(title, desp);
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_sub_cat`(in nom varchar(45), in desp varchar(45),in id_cat int)
BEGIN
	if(select id from categoria where id = id_cat) then
		insert into sub_categoria value(nom, desp, id_cat);
	else
		select('la categoria no existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_usuario`(in nom varchar(45), in pass varchar(45), in email varchar(25), in tel varchar(45), in dat datetime)
BEGIN
	
	if(select nombre from usuario where nombre = nom) then
		select('Ya existe');
	else
		insert into usuario value(nom, pass, email, tel ,dat);
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_usu_rol`(in rol int, in usu_id int)
BEGIN
	if(select id from usuario where id = usu_id) then
		if(select id from rol where id = rol)then
			insert into usuario_has_role value(id_r, rol, usu_id);
		else
			select('no existe el rol');
		end if;
	else
		select('no existe el usuario');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_val`(in id_or_com int, in id_usu int, in rango int, in coment varchar(1000), in dat datetime)
BEGIN
	if(select id from orden_comprador where id = id_or_com) then
		insert into valoracion value(id_or_com, id_usu, rango, coment, dat);
	else
		select('No existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_address`(out city int, in user_id int, out address varchar(20))
BEGIN
	if (select id from ubicacion where usuario_id = user_id) then
		select ciudad into city from ubicacion where  usuario_id = user_id;
		select direccion into address from ubicacion where  usuario_id = user_id;
	else
		select('no existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_category`()
BEGIN
	select * from category;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_countries`(in id_c int, out nom varchar(45), out desp varchar(45))
BEGIN
	if( id is not null ) then
		select nombre into nom from pais where id = id_c;
		select desp into desp from pais where id = id_c;
	else 
		select ('id null');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_order_buy`(in id_usu int)
BEGIN
	select * from orden_comprador where id_usuario = id_usu;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_product`(in id_p int, out id_s int, out nom varchar(45), out price float, out amount int, out brand varchar(45), out id_usu int, out id_sub_cat int, out been varchar(45), out dat datetime, out img varchar(45))
BEGIN
	if(select id from producto where id = id_p) then
		select id into id_s from producto where id = id_p;
		select nombre into nom from producto where id = id_p; 
		select precio into price from producto where id = id_p; 
		select cantidad into amount from producto where id = id_p; 
		select marca into brand from producto where id = id_p; 
		select id_usuario into id_usu from producto where id = id_p; 
		select id_sub_categiria into id_sub_cat from producto where id = id_p; 
		select estado into been from producto where id = id_p;
		select fecha into dat from producto where id = id_p; 
		select imagenes into img from producto where id = id_p; 
	else
		select ('no found');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_rol`()
BEGIN
	select * from rol;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_sub_cat`()
BEGIN
	select * from sub_category;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Show_user`(in id_s int, out nom varchar(45), out pass varchar(45), out mail varchar(25), out tel varchar(45), out dat datetime)
BEGIN
	if(select id from usuario where id = id_s) then
		select nombre into nom from usuario where id = id_s;
		select passw into pass from usuario where id = id_s;
		select email into mail from usuario where id = id_s;
		select telefono into tel from usuario where id = id_s;
		select fecha into dat from usuario where id = id_s;
	else
		select ('no existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_address`(in city int, in user_id int, in address varchar(20))
BEGIN
	if(select usuario_id from ubicacion where usuario_id = user_id) then
		update ubicacion
		set ciudad_id = city, usuario_id = user_id, direccion = address
		where usuario_id = user_id;
	else
		select ('no existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_country`(in id_c int, in nom varchar(45), in descp varchar(45))
BEGIN
	if(select id from pais where id = id_c) then
		update pais
		set nombre = nom, descripcion = descp
		where id = id_c;
	else
		select('el pais no existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_product`(in id_p int, in nom varchar(45), in price float, in amount int, in brand varchar(45), in id_usu int, in id_sub_cat int, in been varchar(45), in dat datetime, in img varchar(45))
BEGIN
	if(select id from producto where id = id_p) then
		update producto 
		set nombre = nom, precio = price, cantidad = amount, marca = brand, id_usuario = id_usu, id_sub_categiria = id_sub_cat, estado = been, fecha = dat, imagenes = img
		where id = id_p;
	else
		select('No existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_usuario`(in id_s int, in nom varchar(45), in pass varchar(45), in mail varchar(25), in tel varchar(45))
BEGIN
	if(select id from usuario where id = id_s) then
		if(nom is null || pass is null || mail is null || tel is null) then
			select ('hay campos nulos');
		else
			update usuario 
			set nombre = nom, passw = pass, email = mail, telefono = tel 
			where id = id_s;
		end if;
	else
		select('No existe');
	end if;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_usu_rol`(in rol int, in usu_id int)
BEGIN
	if(select id from usuario_has_role where usuario_id = usu_id) then
		update usuario_has_role
		set rol_id = rol
		where usuario_id = usu_id;
	else
		select('no existe el usuario');
	end if;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AccessToken`
--

CREATE TABLE IF NOT EXISTS `AccessToken` (
  `id` varchar(255) NOT NULL,
  `ttl` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ACL`
--

CREATE TABLE IF NOT EXISTS `ACL` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(512) DEFAULT NULL,
  `property` varchar(512) DEFAULT NULL,
  `accessType` varchar(512) DEFAULT NULL,
  `permission` varchar(512) DEFAULT NULL,
  `principalType` varchar(512) DEFAULT NULL,
  `principalId` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Deporte', 'Publica articulos deportivos'),
(2, 'electronica', 'electrodomesticos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE IF NOT EXISTS `ciudad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `pais_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ciudad_pais1_idx` (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_comprador`
--

CREATE TABLE IF NOT EXISTS `orden_comprador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_producto_o` int(11) NOT NULL,
  `id_usuario_o` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `estado` varchar(45) NOT NULL DEFAULT 'pendiente o concretado',
  PRIMARY KEY (`id`),
  KEY `id_producto_idx` (`id_producto_o`),
  KEY `id_usuario_idx` (`id_usuario_o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE IF NOT EXISTS `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `precio` float NOT NULL,
  `cantidad` int(11) NOT NULL,
  `marca` varchar(45) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_sub_categiria` int(11) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `fecha` datetime NOT NULL,
  `imagenes` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `id_sub_categoria_idx` (`id_sub_categiria`),
  KEY `id_usuario_idx` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Role`
--

CREATE TABLE IF NOT EXISTS `Role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RoleMapping`
--

CREATE TABLE IF NOT EXISTS `RoleMapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `principalType` varchar(512) DEFAULT NULL,
  `principalId` varchar(512) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_categoria`
--

CREATE TABLE IF NOT EXISTS `sub_categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria_idx` (`id_categoria`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `sub_categoria`
--

INSERT INTO `sub_categoria` (`id`, `nombre`, `descripcion`, `id_categoria`) VALUES
(1, 'tenis', 'Hola mundo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE IF NOT EXISTS `ubicacion` (
  `id` int(11) NOT NULL,
  `ciudad_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

CREATE TABLE IF NOT EXISTS `User` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `realm` varchar(512) DEFAULT NULL,
  `username` varchar(512) DEFAULT NULL,
  `password` varchar(512) NOT NULL,
  `credentials` text,
  `challenges` text,
  `email` varchar(512) NOT NULL,
  `emailVerified` tinyint(1) DEFAULT NULL,
  `verificationToken` varchar(512) DEFAULT NULL,
  `status` varchar(512) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_role`
--

CREATE TABLE IF NOT EXISTS `usuario_has_role` (
  `id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoracion`
--

CREATE TABLE IF NOT EXISTS `valoracion` (
  `id` int(11) NOT NULL,
  `id_ordern_comprador` int(11) NOT NULL,
  `id_usuario_v` int(11) NOT NULL,
  `rango` int(11) NOT NULL,
  `comentario` varchar(1000) NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD CONSTRAINT `fk_ciudad_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `orden_comprador`
--
ALTER TABLE `orden_comprador`
  ADD CONSTRAINT `id_producto_o` FOREIGN KEY (`id_producto_o`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_usuario_o` FOREIGN KEY (`id_usuario_o`) REFERENCES `User` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `id_sub_categoria` FOREIGN KEY (`id_sub_categiria`) REFERENCES `sub_categoria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `User` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sub_categoria`
--
ALTER TABLE `sub_categoria`
  ADD CONSTRAINT `id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

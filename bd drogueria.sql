-- MySQL Workbench Synchronization
-- Generated: 2023-07-17 16:48
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Aprendiz

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `drogueria_db`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

ALTER TABLE `drogueria_db`.`factura` 
DROP FOREIGN KEY `fk_factura_compania1`,
DROP FOREIGN KEY `fk_factura_termino1`;

ALTER TABLE `drogueria_db`.`producto` 
DROP FOREIGN KEY `fk_producto_categoria1`;

ALTER TABLE `drogueria_db`.`factura_producto` 
DROP FOREIGN KEY `fk_producto_has_factura_factura1`;

ALTER TABLE `drogueria_db`.`persona` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `drogueria_db`.`compania` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `drogueria_db`.`factura` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
ADD COLUMN `sub_total` FLOAT(11) NOT NULL AFTER `hora`,
ADD COLUMN `tasa_impuesto` FLOAT(11) NOT NULL AFTER `sub_total`;

ALTER TABLE `drogueria_db`.`termino` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `drogueria_db`.`producto` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `drogueria_db`.`categoria` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `drogueria_db`.`factura_producto` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `drogueria_db`.`factura` 
DROP FOREIGN KEY `fk_factura_persona`;

ALTER TABLE `drogueria_db`.`factura` ADD CONSTRAINT `fk_factura_persona`
  FOREIGN KEY (`id_persona`)
  REFERENCES `drogueria_db`.`persona` (`id_persona`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_factura_compania1`
  FOREIGN KEY (`id_compania`)
  REFERENCES `drogueria_db`.`compania` (`id_compania`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_factura_termino1`
  FOREIGN KEY (`id_termino`)
  REFERENCES `drogueria_db`.`termino` (`id_termino`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `drogueria_db`.`producto` 
ADD CONSTRAINT `fk_producto_categoria1`
  FOREIGN KEY (`id_categoria`)
  REFERENCES `drogueria_db`.`categoria` (`id_categoria`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `drogueria_db`.`factura_producto` 
DROP FOREIGN KEY `fk_producto_has_factura_producto1`;

ALTER TABLE `drogueria_db`.`factura_producto` ADD CONSTRAINT `fk_producto_has_factura_producto1`
  FOREIGN KEY (`id_producto`)
  REFERENCES `drogueria_db`.`producto` (`id_producto`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_producto_has_factura_factura1`
  FOREIGN KEY (`id_factura`)
  REFERENCES `drogueria_db`.`factura` (`id_factura`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

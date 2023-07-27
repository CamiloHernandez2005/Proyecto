-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema farmacia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema farmacia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `farmacia` DEFAULT CHARACTER SET utf8 ;
USE `farmacia` ;

-- -----------------------------------------------------
-- Table `farmacia`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`persona` (
  `id_persona` INT NOT NULL,
  `identificacion` VARCHAR(45) NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(250) NULL,
  `telefono` VARCHAR(45) NULL,
  `direccion` VARCHAR(150) NULL,
  `personacol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE INDEX `identificacion_UNIQUE` (`identificacion` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`compania`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`compania` (
  `id_compania` SMALLINT NOT NULL,
  `nit` VARCHAR(45) NOT NULL,
  `compania` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_compania`),
  UNIQUE INDEX `nit_UNIQUE` (`nit` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`termino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`termino` (
  `id_termino` TINYINT NOT NULL,
  `termino` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_termino`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`factura` (
  `id_factura` BIGINT NOT NULL AUTO_INCREMENT,
  `id_persona` INT NOT NULL,
  `id_compania` SMALLINT NULL,
  `id_termino` TINYINT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `sub_total` FLOAT NOT NULL,
  `tasa_impuesto` FLOAT NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_factura_persona_idx` (`id_persona` ASC) VISIBLE,
  INDEX `fk_factura_compania1_idx` (`id_compania` ASC) VISIBLE,
  INDEX `fk_factura_termino1_idx` (`id_termino` ASC) VISIBLE,
  CONSTRAINT `fk_factura_persona`
    FOREIGN KEY (`id_persona`)
    REFERENCES `farmacia`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_compania1`
    FOREIGN KEY (`id_compania`)
    REFERENCES `farmacia`.`compania` (`id_compania`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_termino1`
    FOREIGN KEY (`id_termino`)
    REFERENCES `farmacia`.`termino` (`id_termino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`categoria` (
  `id_categoria` SMALLINT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `id_categoria` SMALLINT NOT NULL,
  `producto` VARCHAR(150) NOT NULL,
  `existencia` INT NOT NULL DEFAULT 0,
  `valor_unitario_venta` FLOAT NOT NULL,
  `valor_unitario_compra` FLOAT NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `fk_producto_categoria1_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `farmacia`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`factura_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`factura_producto` (
  `id_factura` BIGINT NOT NULL,
  `id_producto` INT NOT NULL,
  `valor_unitario` FLOAT NOT NULL,
  `cantidad` SMALLINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_factura`, `id_producto`),
  INDEX `fk_factura_has_producto_producto1_idx` (`id_producto` ASC) VISIBLE,
  INDEX `fk_factura_has_producto_factura1_idx` (`id_factura` ASC) VISIBLE,
  CONSTRAINT `fk_factura_has_producto_factura1`
    FOREIGN KEY (`id_factura`)
    REFERENCES `farmacia`.`factura` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_has_producto_producto1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `farmacia`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`persona` (
  `id_persona` INT NOT NULL,
  `identificacion` VARCHAR(45) NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(250) NULL,
  `telefono` VARCHAR(45) NULL,
  `direccion` VARCHAR(150) NULL,
  `personacol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE INDEX `identificacion_UNIQUE` (`identificacion` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`profesor` (
  `id_profesor` INT NOT NULL,
  `titulacion` VARCHAR(45) NOT NULL,
  `fecha_titulacion` DATE NOT NULL,
  INDEX `fk_table1_persona1_idx` (`id_profesor` ASC) VISIBLE,
  PRIMARY KEY (`id_profesor`),
  CONSTRAINT `fk_table1_persona1`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `farmacia`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`estudiante` (
  `id_estudiante` INT NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  PRIMARY KEY (`id_estudiante`),
  CONSTRAINT `fk_estudiante_persona1`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `farmacia`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`programa` (
  `id_programa` SMALLINT NOT NULL,
  `programa` VARCHAR(150) NOT NULL,
  `nivel` VARCHAR(45) NOT NULL,
  `semestres` TINYINT NOT NULL,
  PRIMARY KEY (`id_programa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`inscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`inscripcion` (
  `id_inscripcion` INT NOT NULL,
  `id_estudiante` INT NOT NULL,
  `id_programa` SMALLINT NOT NULL,
  `fecha_inscripcion` DATE NOT NULL,
  `fecha_graduacion` DATE NULL,
  PRIMARY KEY (`id_inscripcion`),
  INDEX `fk_inscripcion_estudiante1_idx` (`id_estudiante` ASC) VISIBLE,
  INDEX `fk_inscripcion_programa1_idx` (`id_programa` ASC) VISIBLE,
  CONSTRAINT `fk_inscripcion_estudiante1`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `farmacia`.`estudiante` (`id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripcion_programa1`
    FOREIGN KEY (`id_programa`)
    REFERENCES `farmacia`.`programa` (`id_programa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`materia` (
  `id_materia` SMALLINT NOT NULL,
  `materia` VARCHAR(45) NOT NULL,
  `semestre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_materia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`profesor_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`profesor_materia` (
  `id_profesor` INT NOT NULL,
  `id_materia` SMALLINT NOT NULL,
  PRIMARY KEY (`id_profesor`, `id_materia`),
  INDEX `fk_profesor_has_materia_materia1_idx` (`id_materia` ASC) VISIBLE,
  INDEX `fk_profesor_has_materia_profesor1_idx` (`id_profesor` ASC) VISIBLE,
  CONSTRAINT `fk_profesor_has_materia_profesor1`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `farmacia`.`profesor` (`id_profesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profesor_has_materia_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `farmacia`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`matricula` (
  `id_matricula` INT NOT NULL,
  `id_inscripcion` INT NOT NULL,
  `periodo` TINYINT NOT NULL,
  `año` SMALLINT NOT NULL,
  PRIMARY KEY (`id_matricula`),
  INDEX `fk_matricula_inscripcion1_idx` (`id_inscripcion` ASC) VISIBLE,
  CONSTRAINT `fk_matricula_inscripcion1`
    FOREIGN KEY (`id_inscripcion`)
    REFERENCES `farmacia`.`inscripcion` (`id_inscripcion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`materia_matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`materia_matricula` (
  `id_materia` SMALLINT NOT NULL,
  `id_matricula` INT NOT NULL,
  PRIMARY KEY (`id_materia`, `id_matricula`),
  INDEX `fk_materia_has_matricula_matricula1_idx` (`id_matricula` ASC) VISIBLE,
  INDEX `fk_materia_has_matricula_materia1_idx` (`id_materia` ASC) VISIBLE,
  CONSTRAINT `fk_materia_has_matricula_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `farmacia`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_has_matricula_matricula1`
    FOREIGN KEY (`id_matricula`)
    REFERENCES `farmacia`.`matricula` (`id_matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

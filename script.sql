-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Enfermeiros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Enfermeiros` (
  `EnfermeirosID` INT NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`EnfermeirosID`, `Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Especialidade` (
  `EspecialidadeID` INT NOT NULL,
  `Nome` VARCHAR(50) NULL,
  `Especialidadecol` VARCHAR(45) NOT NULL,
  `Enfermeiros_EnfermeirosID` INT NOT NULL,
  `Enfermeiros_Nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`EspecialidadeID`),
  CONSTRAINT `fk_Especialidade_Enfermeiros1`
    FOREIGN KEY (`Enfermeiros_EnfermeirosID` , `Enfermeiros_Nome`)
    REFERENCES `mydb`.`Enfermeiros` (`EnfermeirosID` , `Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medicos` (
  `MedicoID` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `EspecialidadeID` INT NOT NULL,
  `Especialidade_EspecialidadeID` INT NOT NULL,
  PRIMARY KEY (`EspecialidadeID`, `MedicoID`),
    FOREIGN KEY (`Especialidade_EspecialidadeID`)
    REFERENCES `mydb`.`Especialidade` (`EspecialidadeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


ALTER TABLE medicos
ADD em_atividade BOOLEAN;

UPDATE medicos
SET em_atividade = TRUE;


UPDATE medicos
SET em_atividade = FALSE
WHERE id IN (1, 2); 

- -----------------------------------------------------
-- Table `mydb`.`Convenios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Convenios` (
  `ConvenioID` INT NOT NULL,
  `Nome` VARCHAR(50) NULL,
  PRIMARY KEY (`ConvenioID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pacientes` (
  `PacientesID` INT NOT NULL,
  `Nome` VARCHAR(50) NULL,
  `ConvenioI` INT NOT NULL,
  `Convenios_ConvenioID` INT NOT NULL,
  `Medicos_MedicoID` INT NOT NULL,
  `Medicos_EspecialidadeID` INT NOT NULL,
  PRIMARY KEY (`PacientesID`, `ConvenioI`),
  CONSTRAINT `fk_Pacientes_Convenios1`
    FOREIGN KEY (`Convenios_ConvenioID`)
    REFERENCES `mydb`.`Convenios` (`ConvenioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pacientes_Medicos1`
    FOREIGN KEY (`Medicos_MedicoID` , `Medicos_EspecialidadeID`)
    REFERENCES `mydb`.`Medicos` (`MedicoID` , `EspecialidadeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consulta` (
  `ConsultaID` INT NOT NULL,
  `DataConsulta` DATE NOT NULL,
  `Medicos` INT NOT NULL,
  `PacienteID` INT NOT NULL,
  `Enfermeiros_EnfermeirosID` INT NOT NULL,
  `Enfermeiros_Nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ConsultaID`, `DataConsulta`, `Medicos`, `PacienteID`),
  CONSTRAINT `fk_Consulta_Enfermeiros1`
    FOREIGN KEY (`Enfermeiros_EnfermeirosID` , `Enfermeiros_Nome`)
    REFERENCES `mydb`.`Enfermeiros` (`EnfermeirosID` , `Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Receituario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Receituario` (
  `ReceituarioID` INT NOT NULL,
  `Consulta` INT NULL,
  `Medicamento` VARCHAR(100) NOT NULL,
  `Consulta_ConsultaID` INT NOT NULL,
  `Consulta_DataConsulta` DATE NOT NULL,
  `Consulta_Medicos` INT NOT NULL,
  `Consulta_PacienteID` INT NOT NULL,
  PRIMARY KEY (`ReceituarioID`, `Consulta`),
  CONSTRAINT `fk_Receituario_Consulta1`
    FOREIGN KEY (`Consulta_ConsultaID` , `Consulta_DataConsulta` , `Consulta_Medicos` , `Consulta_PacienteID`)
    REFERENCES `mydb`.`Consulta` (`ConsultaID` , `DataConsulta` , `Medicos` , `PacienteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipos de quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipos de quarto` (
  `Varchar` VARCHAR(20) NOT NULL,
  `preço_diario` VARCHAR(45) NOT NULL,
  `Receituario_ReceituarioID` INT NOT NULL,
  `Receituario_Consulta` INT NOT NULL,
  PRIMARY KEY (`Varchar`),
  CONSTRAINT `fk_Tipos de quarto_Receituario1`
    FOREIGN KEY (`Receituario_ReceituarioID` , `Receituario_Consulta`)
    REFERENCES `mydb`.`Receituario` (`ReceituarioID` , `Consulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Internaçoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Internaçoes` (
  `InternaçoesID` INT NOT NULL,
  `DataInternação` INT NOT NULL,
  `Paciente ID` INT NOT NULL,
  `TipoQuarto` VARCHAR(50) NULL,
  `Enfermeiros_EnfermeirosID` INT NOT NULL,
  `Enfermeiros_Nome` VARCHAR(50) NOT NULL,
  `Tipos de quarto_Varchar` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`InternaçoesID`, `DataInternação`, `Paciente ID`),
  CONSTRAINT `fk_Internaçoes_Enfermeiros1`
    FOREIGN KEY (`Enfermeiros_EnfermeirosID` , `Enfermeiros_Nome`)
    REFERENCES `mydb`.`Enfermeiros` (`EnfermeirosID` , `Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Internaçoes_Tipos de quarto1`
    FOREIGN KEY (`Tipos de quarto_Varchar`)
    REFERENCES `mydb`.`Tipos de quarto` (`Varchar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
    
    
SELECT p.nome AS nome_paciente, m.nome AS nome_medico
FROM pacientes AS p
JOIN medicos AS m ON p.medico_id = m.id
WHERE m.id = 1; 

SELECT data, procedimento, COUNT(id) AS total_procedimentos
FROM procedimentos
WHERE data BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY data, procedimento;

SELECT nome, especialidade
FROM medicos
WHERE em_atividade = TRUE;

SELECT m.especialidade, COUNT(p.id) AS total_pacientes
FROM medicos AS m
LEFT JOIN pacientes AS p ON m.id = p.medico_id
GROUP BY m.especialidade;
















SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


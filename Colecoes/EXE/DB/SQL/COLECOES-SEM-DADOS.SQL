/******************************************************************************/
/***          Generated by IBExpert 2006.03.07 14/06/2006 15:35:53          ***/
/******************************************************************************/

/*
SET SQL DIALECT 3;

SET NAMES ISO8859_1;

CREATE DATABASE '127.0.0.1:D:\Trabalho\Delphi\Cole��es\DB\COLECOES.GDB'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 1024
DEFAULT CHARACTER SET ISO8859_1;
*/


/******************************************************************************/
/***                               Generators                               ***/
/******************************************************************************/

CREATE GENERATOR CATEGORIAS_GEN;
SET GENERATOR CATEGORIAS_GEN TO 0;

CREATE GENERATOR CONTEUDO_GEN;
SET GENERATOR CONTEUDO_GEN TO 0;

CREATE GENERATOR EDICOES_GEN;
SET GENERATOR EDICOES_GEN TO 0;

CREATE GENERATOR EDITORAS_GEN;
SET GENERATOR EDITORAS_GEN TO 0;

CREATE GENERATOR PUBLICACOES_GEN;
SET GENERATOR PUBLICACOES_GEN TO 0;

CREATE GENERATOR TIPOS_GEN;
SET GENERATOR TIPOS_GEN TO 0;



SET TERM ^ ;



/******************************************************************************/
/***                           Stored Procedures                            ***/
/******************************************************************************/

CREATE PROCEDURE "CATEGORIAS_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE "CONTEUDO_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE "EDICOES_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE "EDITORAS_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE PESQ_CONTEUDO (
    PESQ VARCHAR(100) CHARACTER SET ISO8859_1)
RETURNS (
    NO_PUBLICACAO VARCHAR(50) CHARACTER SET ISO8859_1,
    AN_EDICAO INTEGER,
    NU_EDICAO INTEGER,
    NU_PAGINA INTEGER,
    TX_CONTEUDO VARCHAR(100) CHARACTER SET ISO8859_1)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE PROC_CALCFEIERTAGE (
    IN_START DATE,
    IN_STOP DATE)
RETURNS (
    OUT_START TIMESTAMP,
    OUT_STOP TIMESTAMP,
    OUT_NAME VARCHAR(50) CHARACTER SET ISO8859_1)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE PROC_DAYSOFMONTH (
    AYEAR INTEGER,
    AMONTH INTEGER)
RETURNS (
    RESULT INTEGER)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE PROC_DECODEDATE (
    ADATE TIMESTAMP)
RETURNS (
    AYEAR INTEGER,
    AMONTH INTEGER,
    ADAY INTEGER)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE PROC_EASTERSUNDAY (
    IN_YEAR INTEGER)
RETURNS (
    OUT_DATE DATE)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE PROC_ENCODEDATE (
    AYEAR INTEGER,
    AMONTH INTEGER,
    ADAY INTEGER)
RETURNS (
    RESULT DATE)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE PROC_INCDATE (
    IN_DATE TIMESTAMP,
    IN_SECONDS INTEGER,
    IN_MINUTES INTEGER,
    IN_HOURS INTEGER,
    IN_DAYS INTEGER,
    IN_MONTHS INTEGER,
    IN_YEARS INTEGER)
RETURNS (
    OUT_RESULT TIMESTAMP)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE PROC_MODULUS (
    DIVIDEND INTEGER,
    DIVISOR INTEGER)
RETURNS (
    RESULT INTEGER)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE "PUBLICACOES_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  EXIT;
END^


CREATE PROCEDURE "TIPOS_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  EXIT;
END^



SET TERM ; ^


/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/



CREATE TABLE CATEGORIAS (
    CD_CATEGORIA  INTEGER NOT NULL,
    NO_CATEGORIA  VARCHAR(30) CHARACTER SET ISO8859_1 NOT NULL COLLATE PT_BR,
    NR_CATEGORIA  VARCHAR(15) CHARACTER SET ISO8859_1 NOT NULL COLLATE PT_BR,
    DT_CRIACAO    TIMESTAMP DEFAULT 'NOW' NOT NULL,
    DT_ALTERACAO  TIMESTAMP DEFAULT 'NOW' NOT NULL,
    IN_PDA        CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL,
    ID            INTEGER NOT NULL,
    IN_DIRTY      CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'T' NOT NULL,
    IN_DELETED    CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL
);

CREATE TABLE CONTEUDO (
    CD_CONTEUDO   INTEGER NOT NULL,
    NU_PAGINA     INTEGER NOT NULL,
    CD_EDICAO     INTEGER NOT NULL,
    TX_CONTEUDO   VARCHAR(100) CHARACTER SET ISO8859_1 COLLATE PT_BR,
    DT_CRIACAO    TIMESTAMP DEFAULT 'NOW' NOT NULL,
    DT_ALTERACAO  TIMESTAMP DEFAULT 'NOW' NOT NULL,
    IN_PDA        CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL,
    ID            INTEGER NOT NULL,
    IN_DIRTY      CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'T' NOT NULL,
    IN_DELETED    CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL
);

CREATE TABLE EDICOES (
    CD_EDICAO      INTEGER NOT NULL,
    CD_PUBLICACAO  INTEGER NOT NULL,
    AN_EDICAO      INTEGER NOT NULL,
    NU_EDICAO      INTEGER NOT NULL,
    DT_CRIACAO     TIMESTAMP DEFAULT 'NOW' NOT NULL,
    DT_ALTERACAO   TIMESTAMP DEFAULT 'NOW' NOT NULL,
    IN_PDA         CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL,
    ID             INTEGER NOT NULL,
    IN_DIRTY       CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'T' NOT NULL,
    IN_DELETED     CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL
);

CREATE TABLE EDITORAS (
    CD_EDITORA    INTEGER NOT NULL,
    NO_EDITORA    VARCHAR(30) CHARACTER SET ISO8859_1 NOT NULL COLLATE PT_BR,
    NR_EDITORA    VARCHAR(15) CHARACTER SET ISO8859_1 NOT NULL COLLATE PT_BR,
    DT_CRIACAO    TIMESTAMP DEFAULT 'NOW' NOT NULL,
    DT_ALTERACAO  TIMESTAMP DEFAULT 'NOW' NOT NULL,
    IN_PDA        CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL,
    ID            INTEGER NOT NULL,
    IN_DIRTY      CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'T' NOT NULL,
    IN_DELETED    CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL
);

CREATE TABLE PUBLICACOES (
    CD_PUBLICACAO  INTEGER NOT NULL,
    CD_EDITORA     INTEGER NOT NULL,
    CD_TIPO        INTEGER NOT NULL,
    CD_CATEGORIA   INTEGER NOT NULL,
    NO_PUBLICACAO  VARCHAR(30) CHARACTER SET ISO8859_1 NOT NULL COLLATE PT_BR,
    NR_PUBLICACAO  VARCHAR(15) CHARACTER SET ISO8859_1 NOT NULL COLLATE PT_BR,
    DT_CRIACAO     TIMESTAMP DEFAULT 'NOW' NOT NULL,
    DT_ALTERACAO   TIMESTAMP DEFAULT 'NOW' NOT NULL,
    IN_PDA         CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL,
    ID             INTEGER NOT NULL,
    IN_DIRTY       CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'T' NOT NULL,
    IN_DELETED     CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL
);

CREATE TABLE TIPOS (
    CD_TIPO       INTEGER NOT NULL,
    NO_TIPO       VARCHAR(30) CHARACTER SET ISO8859_1 NOT NULL COLLATE PT_BR,
    NR_TIPO       VARCHAR(15) CHARACTER SET ISO8859_1 NOT NULL COLLATE PT_BR,
    DT_CRIACAO    TIMESTAMP DEFAULT 'NOW' NOT NULL,
    DT_ALTERACAO  TIMESTAMP DEFAULT 'NOW' NOT NULL,
    IN_PDA        CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL,
    ID            INTEGER NOT NULL,
    IN_DIRTY      CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'T' NOT NULL,
    IN_DELETED    CHAR(1) CHARACTER SET ISO8859_1 DEFAULT 'F' NOT NULL
);



/******************************************************************************/
/***                                 Views                                  ***/
/******************************************************************************/


/* View: VIEW_CONTEUDOS */
CREATE VIEW VIEW_CONTEUDOS(
    NO_PUBLICACAO,
    AN_EDICAO,
    NU_EDICAO,
    NU_PAGINA,
    TX_CONTEUDO)
AS
SELECT PUBLICACOES.NO_PUBLICACAO,
       EDICOES.AN_EDICAO, EDICOES.NU_EDICAO,
       CONTEUDO.NU_PAGINA, CONTEUDO.TX_CONTEUDO
FROM PUBLICACOES,EDICOES,CONTEUDO
WHERE PUBLICACOES.CD_PUBLICACAO = EDICOES.CD_PUBLICACAO
AND   EDICOES.CD_EDICAO = CONTEUDO.CD_EDICAO
/*AND   UPPER(CONTEUDO.TX_CONTEUDO) LIKE '%USB%'*/
/*ORDER BY CONTEUDO.TX_CONTEUDO*/
ORDER BY PUBLICACOES.NO_PUBLICACAO, EDICOES.AN_EDICAO, EDICOES.NU_EDICAO,
         CONTEUDO.NU_PAGINA
;


/* Check constraints definition */

ALTER TABLE CATEGORIAS ADD CHECK (CD_CATEGORIA > 0);
ALTER TABLE CATEGORIAS ADD CHECK (IN_PDA IN ('T', 'F'));
ALTER TABLE CATEGORIAS ADD CHECK (ID >= 0);
ALTER TABLE CATEGORIAS ADD CHECK (IN_DIRTY IN ('T', 'F'));
ALTER TABLE CATEGORIAS ADD CHECK (IN_DELETED IN ('T', 'F'));
ALTER TABLE TIPOS ADD CHECK (CD_TIPO > 0);
ALTER TABLE TIPOS ADD CHECK (IN_PDA IN ('T', 'F'));
ALTER TABLE TIPOS ADD CHECK (ID >= 0);
ALTER TABLE TIPOS ADD CHECK (IN_DIRTY IN ('T', 'F'));
ALTER TABLE TIPOS ADD CHECK (IN_DELETED IN ('T', 'F'));
ALTER TABLE EDITORAS ADD CHECK (CD_EDITORA > 0);
ALTER TABLE EDITORAS ADD CHECK (ID >= 0);
ALTER TABLE EDITORAS ADD CHECK (IN_DIRTY IN ('T', 'F'));
ALTER TABLE EDITORAS ADD CHECK (IN_DELETED IN ('T', 'F'));
ALTER TABLE EDITORAS ADD CHECK (IN_PDA IN ('T', 'F'));
ALTER TABLE PUBLICACOES ADD CHECK (CD_PUBLICACAO > 0);
ALTER TABLE PUBLICACOES ADD CHECK (CD_EDITORA > 0);
ALTER TABLE PUBLICACOES ADD CHECK (CD_TIPO > 0);
ALTER TABLE PUBLICACOES ADD CHECK (CD_CATEGORIA > 0);
ALTER TABLE PUBLICACOES ADD CHECK (ID >= 0);
ALTER TABLE PUBLICACOES ADD CHECK (IN_DIRTY IN ('T', 'F'));
ALTER TABLE PUBLICACOES ADD CHECK (IN_DELETED IN ('T', 'F'));
ALTER TABLE PUBLICACOES ADD CHECK (IN_PDA IN ('T', 'F'));
ALTER TABLE EDICOES ADD CHECK (CD_EDICAO > 0);
ALTER TABLE EDICOES ADD CHECK (CD_PUBLICACAO > 0);
ALTER TABLE EDICOES ADD CHECK (AN_EDICAO >= 0);
ALTER TABLE EDICOES ADD CHECK (NU_EDICAO >= 0);
ALTER TABLE EDICOES ADD CHECK (IN_PDA IN ('T', 'F'));
ALTER TABLE EDICOES ADD CHECK (ID >= 0);
ALTER TABLE EDICOES ADD CHECK (IN_DIRTY IN ('T', 'F'));
ALTER TABLE EDICOES ADD CHECK (IN_DELETED IN ('T', 'F'));
ALTER TABLE CONTEUDO ADD CHECK (CD_CONTEUDO > 0);
ALTER TABLE CONTEUDO ADD CHECK (NU_PAGINA > 0);
ALTER TABLE CONTEUDO ADD CHECK (CD_EDICAO > 0);
ALTER TABLE CONTEUDO ADD CHECK (IN_PDA IN ('T', 'F'));
ALTER TABLE CONTEUDO ADD CHECK (ID >= 0);
ALTER TABLE CONTEUDO ADD CHECK (IN_DIRTY IN ('T', 'F'));
ALTER TABLE CONTEUDO ADD CHECK (IN_DELETED IN ('T', 'F'));


/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/

ALTER TABLE CATEGORIAS ADD PRIMARY KEY (CD_CATEGORIA);
ALTER TABLE CONTEUDO ADD PRIMARY KEY (CD_CONTEUDO);
ALTER TABLE EDICOES ADD PRIMARY KEY (CD_EDICAO);
ALTER TABLE EDITORAS ADD PRIMARY KEY (CD_EDITORA);
ALTER TABLE PUBLICACOES ADD PRIMARY KEY (CD_PUBLICACAO);
ALTER TABLE TIPOS ADD PRIMARY KEY (CD_TIPO);


/******************************************************************************/
/***                              Foreign Keys                              ***/
/******************************************************************************/

ALTER TABLE CONTEUDO ADD FOREIGN KEY (CD_EDICAO) REFERENCES EDICOES (CD_EDICAO);
ALTER TABLE EDICOES ADD FOREIGN KEY (CD_PUBLICACAO) REFERENCES PUBLICACOES (CD_PUBLICACAO);
ALTER TABLE PUBLICACOES ADD FOREIGN KEY (CD_CATEGORIA) REFERENCES CATEGORIAS (CD_CATEGORIA);
ALTER TABLE PUBLICACOES ADD FOREIGN KEY (CD_EDITORA) REFERENCES EDITORAS (CD_EDITORA);
ALTER TABLE PUBLICACOES ADD FOREIGN KEY (CD_TIPO) REFERENCES TIPOS (CD_TIPO);


/******************************************************************************/
/***                                Indices                                 ***/
/******************************************************************************/

CREATE UNIQUE INDEX AK_CATEGORIAS_1 ON CATEGORIAS (NO_CATEGORIA);
CREATE UNIQUE INDEX AK_CATEGORIAS_2 ON CATEGORIAS (NR_CATEGORIA);
CREATE UNIQUE INDEX AK_CONTEUDO_1 ON CONTEUDO (CD_EDICAO, CD_CONTEUDO);
CREATE UNIQUE INDEX AK_CONTEUDO_2 ON CONTEUDO (CD_EDICAO, NU_PAGINA);
CREATE INDEX AK_CONTEUDO_3 ON CONTEUDO (TX_CONTEUDO);
CREATE UNIQUE INDEX AK_EDICOES_1 ON EDICOES (CD_PUBLICACAO, CD_EDICAO);
CREATE UNIQUE INDEX AK_EDICOES_2 ON EDICOES (CD_EDICAO, AN_EDICAO, NU_EDICAO);
CREATE UNIQUE INDEX AK_EDITORAS_1 ON EDITORAS (NO_EDITORA);
CREATE UNIQUE INDEX AK_EDITORAS_2 ON EDITORAS (NR_EDITORA);
CREATE UNIQUE INDEX AK_PUBLICACOES_1 ON PUBLICACOES (NO_PUBLICACAO);
CREATE UNIQUE INDEX AK_PUBLICACOES_2 ON PUBLICACOES (NR_PUBLICACAO);
CREATE UNIQUE INDEX AK_TIPOS_1 ON TIPOS (NO_TIPO);
CREATE UNIQUE INDEX AK_TIPOS_2 ON TIPOS (NR_TIPO);


/******************************************************************************/
/***                                Triggers                                ***/
/******************************************************************************/


SET TERM ^ ;


/******************************************************************************/
/***                          Triggers for tables                           ***/
/******************************************************************************/



/* Trigger: TRG_CATEGORIAS_BI */
CREATE TRIGGER TRG_CATEGORIAS_BI FOR CATEGORIAS
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CD_CATEGORIA IS NULL) THEN
      NEW.CD_CATEGORIA = GEN_ID(CATEGORIAS_GEN, 1);
  IF (NEW.NO_CATEGORIA IS NULL) THEN
      NEW.NO_CATEGORIA = NEW.NR_CATEGORIA;
  NEW.DT_CRIACAO = 'now';
  NEW.DT_ALTERACAO = NEW.DT_CRIACAO;
END
^

/* Trigger: TRG_CATEGORIAS_BU */
CREATE TRIGGER TRG_CATEGORIAS_BU FOR CATEGORIAS
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.DT_ALTERACAO = 'now';
END
^

/* Trigger: TRG_CONTEUDO_BI */
CREATE TRIGGER TRG_CONTEUDO_BI FOR CONTEUDO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CD_CONTEUDO IS NULL) THEN
      NEW.CD_CONTEUDO = GEN_ID(CONTEUDO_GEN, 1);
  NEW.DT_CRIACAO = 'now';
  NEW.DT_ALTERACAO = NEW.DT_CRIACAO;
END
^

/* Trigger: TRG_CONTEUDO_BU */
CREATE TRIGGER TRG_CONTEUDO_BU FOR CONTEUDO
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.DT_ALTERACAO = 'now';
END
^

/* Trigger: TRG_EDICOES_BI */
CREATE TRIGGER TRG_EDICOES_BI FOR EDICOES
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CD_EDICAO IS NULL) THEN
      NEW.CD_EDICAO = GEN_ID(EDICOES_GEN, 1);
  NEW.DT_CRIACAO = 'now';
  NEW.DT_ALTERACAO = NEW.DT_CRIACAO;
END
^

/* Trigger: TRG_EDICOES_BU */
CREATE TRIGGER TRG_EDICOES_BU FOR EDICOES
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.DT_ALTERACAO = 'now';
END
^

/* Trigger: TRG_EDITORAS_BI */
CREATE TRIGGER TRG_EDITORAS_BI FOR EDITORAS
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CD_EDITORA IS NULL) THEN
      NEW.CD_EDITORA = GEN_ID(EDITORAS_GEN, 1);
  IF (NEW.NO_EDITORA IS NULL) THEN
      NEW.NO_EDITORA = NEW.NR_EDITORA;
  NEW.DT_CRIACAO = 'now';
  NEW.DT_ALTERACAO = NEW.DT_CRIACAO;
END
^

/* Trigger: TRG_EDITORAS_BU */
CREATE TRIGGER TRG_EDITORAS_BU FOR EDITORAS
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.DT_ALTERACAO = 'now';
END
^

/* Trigger: TRG_PUBLICACOES_BI */
CREATE TRIGGER TRG_PUBLICACOES_BI FOR PUBLICACOES
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CD_PUBLICACAO IS NULL) THEN
      NEW.CD_PUBLICACAO = GEN_ID(PUBLICACOES_GEN, 1);
  IF (NEW.NO_PUBLICACAO IS NULL) THEN
      NEW.NO_PUBLICACAO = NEW.NR_PUBLICACAO;
  NEW.DT_CRIACAO = 'now';
  NEW.DT_ALTERACAO = NEW.DT_CRIACAO;
END
^

/* Trigger: TRG_PUBLICACOES_BU */
CREATE TRIGGER TRG_PUBLICACOES_BU FOR PUBLICACOES
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.DT_ALTERACAO = 'now';
END
^

/* Trigger: TRG_TIPOS_BI */
CREATE TRIGGER TRG_TIPOS_BI FOR TIPOS
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CD_TIPO IS NULL) THEN
      NEW.CD_TIPO = GEN_ID(TIPOS_GEN, 1);
  IF (NEW.NO_TIPO IS NULL) THEN
      NEW.NO_TIPO = NEW.NR_TIPO;
  NEW.DT_CRIACAO = 'now';
  NEW.DT_ALTERACAO = NEW.DT_CRIACAO;
END
^

/* Trigger: TRG_TIPOS_BU */
CREATE TRIGGER TRG_TIPOS_BU FOR TIPOS
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
  NEW.DT_ALTERACAO = 'now';
END
^

SET TERM ; ^



/******************************************************************************/
/***                           Stored Procedures                            ***/
/******************************************************************************/


SET TERM ^ ;

ALTER PROCEDURE "CATEGORIAS_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  NEW_VALUE = GEN_ID(CATEGORIAS_GEN, 1);
END
^

ALTER PROCEDURE "CONTEUDO_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  NEW_VALUE = GEN_ID(CONTEUDO_GEN, 1);
END
^

ALTER PROCEDURE "EDICOES_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  NEW_VALUE = GEN_ID(EDICOES_GEN, 1);
END
^

ALTER PROCEDURE "EDITORAS_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  NEW_VALUE = GEN_ID(EDITORAS_GEN, 1);
END
^

ALTER PROCEDURE PESQ_CONTEUDO (
    PESQ VARCHAR(100) CHARACTER SET ISO8859_1)
RETURNS (
    NO_PUBLICACAO VARCHAR(50) CHARACTER SET ISO8859_1,
    AN_EDICAO INTEGER,
    NU_EDICAO INTEGER,
    NU_PAGINA INTEGER,
    TX_CONTEUDO VARCHAR(100) CHARACTER SET ISO8859_1)
AS
BEGIN
FOR SELECT PUBLICACOES.NO_PUBLICACAO,
           EDICOES.AN_EDICAO, EDICOES.NU_EDICAO,
           CONTEUDO.NU_PAGINA, CONTEUDO.TX_CONTEUDO
    FROM PUBLICACOES,EDICOES,CONTEUDO
    WHERE PUBLICACOES.CD_PUBLICACAO = EDICOES.CD_PUBLICACAO
    AND   EDICOES.CD_EDICAO = CONTEUDO.CD_EDICAO
    AND   UPPER(CONTEUDO.TX_CONTEUDO) LIKE '%' ||:PESQ ||'%'
ORDER BY EDICOES.NU_EDICAO,CONTEUDO.NU_PAGINA
INTO :NO_PUBLICACAO,
     :AN_EDICAO,
     :NU_EDICAO,
     :NU_PAGINA,
     :TX_CONTEUDO
DO SUSPEND;
END
^

ALTER PROCEDURE PROC_CALCFEIERTAGE (
    IN_START DATE,
    IN_STOP DATE)
RETURNS (
    OUT_START TIMESTAMP,
    OUT_STOP TIMESTAMP,
    OUT_NAME VARCHAR(50) CHARACTER SET ISO8859_1)
AS
DECLARE VARIABLE var_Year     INTEGER;
DECLARE VARIABLE var_StopYear INTEGER;
DECLARE VARIABLE var_Ostern   DATE;
BEGIN
   /* returns german "Feiertage" which are in range of the input params */
   /* author: Markus Ostenried, chef_007@gmx.net, markus@authentic-media.com */

   var_Year     = EXTRACT(YEAR FROM IN_START);
   var_StopYear = EXTRACT(YEAR FROM IN_STOP);

   WHILE (var_Year <= var_StopYear) DO BEGIN
     /* Neujahr */
     OUT_START = CAST('01.01.' || var_Year || ' 00:00:00' AS TIMESTAMP);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Neujahr';
       SUSPEND;
     END

     /* Heilige drei Koenige */
     OUT_START = CAST('06.01.' || var_Year || ' 00:00:00' AS TIMESTAMP);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Heilige drei Koenige';
       SUSPEND;
     END

     /* Maifeiertag */
     OUT_START = CAST('01.05.' || var_Year || ' 00:00:00' AS TIMESTAMP);
     OUT_STOP  = CAST(OUT_START AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Maifeiertag';
       SUSPEND;
     END

     /* Tag der dt. Einheit */
     OUT_START = CAST('03.10.' || var_Year || ' 00:00:00' AS TIMESTAMP);
     OUT_STOP  = CAST(OUT_START AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Tag der dt. Einheit';
       SUSPEND;
     END

     /* 1. Weihnachtsfeiertag */
     OUT_START = CAST('25.12.' || var_Year || ' 00:00:00' AS TIMESTAMP);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = '1. Weihnachtsfeiertag';
       SUSPEND;
     END

     /* 2. Weihnachtsfeiertag */
     OUT_START = CAST('26.12.' || var_Year || ' 00:00:00' AS TIMESTAMP);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = '2. Weihnachtsfeiertag';
       SUSPEND;
     END

     EXECUTE PROCEDURE PROC_EASTERSUNDAY(var_Year)
       RETURNING_VALUES(var_Ostern);

     /* Ostersonntag */
     OUT_START = CAST(var_Ostern AS DATE) + CAST('00:00:00' AS TIME);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Ostersonntag';
       SUSPEND;
     END

     /* Ostermontag */
     OUT_START = CAST(var_Ostern AS DATE) + 1 + CAST('00:00:00' AS TIME);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Ostermontag';
       SUSPEND;
     END

     /* Aschermittwoch */
     OUT_START = CAST(var_Ostern AS DATE) - 46 + CAST('00:00:00' AS TIME);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Aschermittwoch';
       SUSPEND;
     END

     /* Karfreitag */
     OUT_START = CAST(var_Ostern AS DATE) - 2 + CAST('00:00:00' AS TIME);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Karfreitag';
       SUSPEND;
     END

     /* Christi Himmelfahrt */
     OUT_START = CAST(var_Ostern AS DATE) + 39 + CAST('00:00:00' AS TIME);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Christi Himmelfahrt';
       SUSPEND;
     END

     /* Pfingstsonntag */
     OUT_START = CAST(var_Ostern AS DATE) + 49 + CAST('00:00:00' AS TIME);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Pfingstsonntag';
       SUSPEND;
     END

     /* Pfingstmontag */
     OUT_START = CAST(var_Ostern AS DATE) + 50 + CAST('00:00:00' AS TIME);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Pfingstmontag';
       SUSPEND;
     END

     /* Fronleichnam */
     OUT_START = CAST(var_Ostern AS DATE) + 60 + CAST('00:00:00' AS TIME);
     OUT_STOP  = CAST(OUT_START  AS DATE) + CAST('23:59:59' AS TIME);

     IF (NOT (OUT_STOP < IN_START) AND NOT (OUT_START > IN_STOP)) THEN BEGIN
       OUT_NAME = 'Fronleichnam';
       SUSPEND;
     END

     var_Year = var_Year + 1;
   END

/*
   http://www.weltzeituhr.com/infos/kirchliche_feiertage.htm
   Aschermittwoch      : 46 Tage vor Ostersonntag
   Karfreitag          :  2 Tage vor Ostersonntag
   Christi Himmelfahrt : 39 Tage nach Ostersonntag
   Pfingstsonntag      : 49 Tage nach Ostersonntag
   Fronleichnam        : 60 Tage nach Ostersonntag
*/

END
^

ALTER PROCEDURE PROC_DAYSOFMONTH (
    AYEAR INTEGER,
    AMONTH INTEGER)
RETURNS (
    RESULT INTEGER)
AS
DECLARE VARIABLE WorkDate   DATE;
BEGIN
   RESULT = 31;

   WHILE (RESULT > 28 AND WorkDate IS NULL) DO
   BEGIN
     EXECUTE PROCEDURE Proc_EncodeDate(AYEAR, AMONTH, RESULT)
       RETURNING_VALUES(WorkDate);

     WHEN ANY DO RESULT = RESULT -1;
   END
END
^

ALTER PROCEDURE PROC_DECODEDATE (
    ADATE TIMESTAMP)
RETURNS (
    AYEAR INTEGER,
    AMONTH INTEGER,
    ADAY INTEGER)
AS
BEGIN
   AYEAR  = EXTRACT(Year from ADATE);
   AMONTH = EXTRACT(Month from ADATE);
   ADAY   = EXTRACT(Day from ADATE);
   SUSPEND;
END
^

ALTER PROCEDURE PROC_EASTERSUNDAY (
    IN_YEAR INTEGER)
RETURNS (
    OUT_DATE DATE)
AS
DECLARE VARIABLE var_Month  INTEGER;
DECLARE VARIABLE var_Day    INTEGER;
DECLARE VARIABLE var_Moon   INTEGER;
DECLARE VARIABLE var_Epact  INTEGER;
DECLARE VARIABLE var_Sunday INTEGER;
DECLARE VARIABLE var_Gold   INTEGER;
DECLARE VARIABLE var_Cent   INTEGER;
DECLARE VARIABLE var_Corx   INTEGER;
DECLARE VARIABLE var_Corz   INTEGER;
DECLARE VARIABLE var_Tmp    INTEGER;
BEGIN
   /*{ The Golden Number of the year in the 19 year Metonic Cycle: }*/
   EXECUTE PROCEDURE PROC_MODULUS(:IN_YEAR, 19)
     RETURNING_VALUES(:var_Gold);

   var_Gold = var_Gold + 1;
   /*{ Calculate the Century: }*/
   var_Cent = CAST(IN_YEAR/100-0.49 AS INTEGER) + 1;
   /*{ Number of years in which leap year was dropped in order... }*/
   /*{ to keep in step with the sun: }*/
   var_Corx = (3 * var_Cent);
   var_Corx = CAST(var_Corx/4-0.49 AS INTEGER) - 12;
   /*{ Special correction to syncronize Easter with moon's orbit: }*/
   var_Corz = (8 * var_Cent + 5);
   var_Corz = CAST(var_Corz/25-0.49 AS INTEGER) - 5;
   /*{ Find Sunday: }*/
   var_Sunday = (5 * IN_YEAR);
   var_Sunday = CAST(var_Sunday/4-0.49 AS INTEGER) - var_Corx - 10;
   /*{ Set Epact - specifies occurrence of full moon: }*/
   var_Epact = (11 * var_Gold + 20 + var_Corz - var_Corx);

   EXECUTE PROCEDURE PROC_MODULUS(:var_Epact, 30)
     RETURNING_VALUES(:var_Epact);

   IF (var_Epact < 0) THEN BEGIN
     var_Epact = var_Epact + 30;
   END

   IF (((var_Epact = 25) AND (var_Gold > 11)) OR (var_Epact = 24)) THEN BEGIN
     var_Epact = var_Epact + 1;
   END

   /*{ Find Full Moon: }*/
   var_Moon = 44 - var_Epact;

   IF (var_Moon < 21) THEN BEGIN
     var_Moon = var_Moon + 30;
   END

   /*{ Advance to Sunday: }*/
   var_Tmp = var_Sunday + var_Moon;

   EXECUTE PROCEDURE PROC_MODULUS(:var_Tmp, 7)
     RETURNING_VALUES(:var_Tmp);

   var_Moon = var_Moon + 7 - var_Tmp;

   IF (var_Moon > 31) THEN BEGIN
     var_Month = 4;
     var_Day = var_Moon - 31;
   END
   ELSE BEGIN
     var_Month = 3;
     var_Day = var_Moon;
   END

   EXECUTE PROCEDURE PROC_EncodeDate(:IN_YEAR, :var_Month, :var_Day)
     RETURNING_VALUES(:OUT_DATE);

   SUSPEND;
END
^

ALTER PROCEDURE PROC_ENCODEDATE (
    AYEAR INTEGER,
    AMONTH INTEGER,
    ADAY INTEGER)
RETURNS (
    RESULT DATE)
AS
BEGIN
   RESULT = CAST(ADAY || '.' || AMONTH || '.' || AYEAR AS DATE);
   SUSPEND;
END
^

ALTER PROCEDURE PROC_INCDATE (
    IN_DATE TIMESTAMP,
    IN_SECONDS INTEGER,
    IN_MINUTES INTEGER,
    IN_HOURS INTEGER,
    IN_DAYS INTEGER,
    IN_MONTHS INTEGER,
    IN_YEARS INTEGER)
RETURNS (
    OUT_RESULT TIMESTAMP)
AS
DECLARE VARIABLE var_SecondsOfTime INTEGER;
DECLARE VARIABLE var_Time          TIME;
DECLARE VARIABLE var_Day           INTEGER;
DECLARE VARIABLE var_Month         INTEGER;
DECLARE VARIABLE var_Year          INTEGER;
DECLARE VARIABLE var_ModHour       INTEGER;
DECLARE VARIABLE var_ModMonth      INTEGER;
DECLARE VARIABLE var_DaysPerMonth  INTEGER;
BEGIN
   IF (IN_SECONDS IS NULL) THEN IN_SECONDS = 0;
   IF (IN_MINUTES IS NULL) THEN IN_MINUTES = 0;
   IF (IN_HOURS   IS NULL) THEN IN_HOURS   = 0;
   IF (IN_DAYS    IS NULL) THEN IN_DAYS    = 0;
   IF (IN_MONTHS  IS NULL) THEN IN_MONTHS  = 0;
   IF (IN_YEARS   IS NULL) THEN IN_YEARS   = 0;

   /* function IncTime(ADateTime: TDateTime; Hours, Minutes, */
   /*   Seconds, MSecs: Integer): TDateTime;  */
   /* RESULT := ADateTime + (Hours div 24) + (((Hours mod 24) */
   /*   * 3600000 + Minutes * 60000 + Seconds * 1000 + MSecs) / MSecsPerDay); */

   var_Time = CAST(IN_DATE AS TIME);
   var_SecondsOfTime = EXTRACT(HOUR   FROM var_Time)*60*60 +
                       EXTRACT(MINUTE FROM var_Time)*60 +
                       EXTRACT(SECOND FROM var_Time) +
                       IN_HOURS * 60 * 60 + IN_MINUTES * 60 + IN_SECONDS;
   IN_DAYS = IN_DAYS + CAST(var_SecondsOfTime/(24 * 60 * 60) - 0.49 AS INTEGER);

   EXECUTE PROCEDURE PROC_MODULUS(var_SecondsOfTime, 86400)
     RETURNING_VALUES(var_SecondsOfTime);

   var_Time = CAST('00:00' AS TIME);
   var_Time = var_Time + var_SecondsOfTime;

   EXECUTE PROCEDURE PROC_DecodeDate(IN_DATE)
     RETURNING_VALUES(var_Year ,var_Month, var_Day);

   var_Year = var_Year + IN_YEARS;
   var_Year = var_Year + CAST(IN_MONTHS/12-0.49 AS INTEGER);

   EXECUTE PROCEDURE PROC_MODULUS(IN_MONTHS, 12)
     RETURNING_VALUES(var_ModMonth);

   var_Month = var_Month + var_ModMonth;

   IF (var_Month < 1) THEN
   BEGIN
     var_Month = var_Month + 12;
     var_Year = var_Year - 1;
   END
   ELSE IF (var_Month > 12) THEN
   BEGIN
     var_Month = var_Month - 12;
     var_Year = var_Year + 1;
   END

   EXECUTE PROCEDURE PROC_DAYSOFMONTH(var_Year, var_Month)
     RETURNING_VALUES(var_DaysPerMonth);

   IF (var_Day > var_DaysPerMonth) THEN
   BEGIN
     EXECUTE PROCEDURE PROC_DAYSOFMONTH(var_Year, var_Month)
       RETURNING_VALUES(var_Day);
   END

   EXECUTE PROCEDURE PROC_EncodeDate(var_Year, var_Month, var_Day)
     RETURNING_VALUES(OUT_RESULT);

   OUT_RESULT = OUT_RESULT + IN_DAYS;
   OUT_RESULT = CAST(OUT_RESULT AS DATE) + var_Time;

/*
function IncDate(ADate: TDateTime; Days, Months, Years: Integer): TDateTime;
var
   D, M, Y: Word;
   Day, Month, Year: Longint;
begin
   DecodeDate(ADate, Y, M, D);
   Year := Y;
   Month := M;
   Day := D;
   Inc(Year, Years);
   Inc(Year, Months div 12);
   Inc(Month, Months mod 12);

   if Month < 1 then
   begin
     Inc(Month, 12);
     Dec(Year);
   end
   else if Month > 12 then
   begin
     Dec(Month, 12);
     Inc(Year);
   end;

   if Day > DaysPerMonth(Year, Month) then
     Day := DaysPerMonth(Year, Month);

   Result := EncodeDate(Year, Month, Day) + Days + Frac(ADate);
end;
*/
END
^

ALTER PROCEDURE PROC_MODULUS (
    DIVIDEND INTEGER,
    DIVISOR INTEGER)
RETURNS (
    RESULT INTEGER)
AS
BEGIN
   /* This procedure calculates the modulus of two numbers */
   IF(DIVIDEND = 0) THEN RESULT = 0;
   ELSE RESULT = DIVIDEND-(CAST((DIVIDEND / DIVISOR) - 0.49 AS INTEGER) * DIVISOR);
   /* SUSPEND;  Ed.- this isn't recommended */
END
^

ALTER PROCEDURE "PUBLICACOES_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  NEW_VALUE = GEN_ID(PUBLICACOES_GEN, 1);
END
^

ALTER PROCEDURE "TIPOS_AutoInc"
RETURNS (
    NEW_VALUE INTEGER)
AS
BEGIN
  NEW_VALUE = GEN_ID(TIPOS_GEN, 1);
END
^


SET TERM ; ^

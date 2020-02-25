CREATE DATABASE `ingestion`;
USE `ingestion`;

CREATE TABLE `datatypes` (
    `id`            bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `T_BIT`         bit            COMMENT 'M_max=64. 64bit=8 bytes',
    -- Attribute M of numberic is display width, NOT constrain the range of values
    `T_TINYINT`     tinyint        COMMENT 'M is no effect',
    `T_SMALLINT`    smallint,
    `T_MEDIUMINT`   mediumint,
    `T_INT`         int,
    `T_BIGINT`      bigint,
    `T_BOOL`        boolean        COMMENT 'alias of tinyint(1)',
    `T_DECIMAL`     decimal(19,4)  COMMENT 'alias: DEC, FIXED, NUMERIC; default [M, D]=[0, 0]',
    `T_FLOAT`       float,
    `T_DOUBLE`      double         COMMENT 'alias: REAL',
    `T_DATE`        date,
    `T_TIME`        time(6)        COMMENT 'Precision: microsecond',
    `T_DATETIME`    datetime(6)    COMMENT 'Precision: microsecond',
    `T_TIMESTAMP`   timestamp(6)   COMMENT 'Precision: microsecond',
    `T_YEAR`        year,
    `T_CHAR`        char(7),
    `T_VARCHAR`     varchar(7)     COMMENT 'M is required',
    `T_BINARY`      binary(7),
    `T_VARBINARY`   varbinary(7)   COMMENT 'M is required',
    `T_BLOB`        blob,
    `T_TEXT`        text           COMMENT 'a.k.a CLOB',
    `T_ENUM`        enum('SUN','MON','TUE','WED','THU','FRI','SAT'),
    `T_SET`         set('a','b','c','d'),
    `T_JSON`        json,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

INSERT INTO `datatypes`
SET
    `T_BIT`         = 0,
    `T_TINYINT`     = POWER(2,  7) - 1,
    `T_SMALLINT`    = POWER(2, 15) - 1,
    `T_MEDIUMINT`   = POWER(2, 23) - 1,
    `T_INT`         = POWER(2, 31) - 1,
    `T_BIGINT`      = POWER(2, 63) - 1,
    `T_BOOL`        = TRUE,
    `T_DECIMAL`     = (1 + SQRT(5)) / 2,    -- Godern ratio
    `T_FLOAT`       = EXP(1),               -- Euler's Number
    `T_DOUBLE`      = PI(),
    `T_DATE`        = CURRENT_DATE(),
    `T_TIME`        = CURRENT_TIME(6),      -- Precision: microsecond
    `T_DATETIME`    = NOW(6),               -- Precision: microsecond
    `T_TIMESTAMP`   = CURRENT_TIMESTAMP(6), -- Precision: microsecond
    `T_YEAR`        = YEAR(NOW()),
    `T_CHAR`        = LEFT(MD5(RAND()), 7),
    `T_VARCHAR`     = LEFT(MD5(RAND()), 7),
    `T_BINARY`      = LEFT(MD5(RAND()), 7),
    `T_VARBINARY`   = LEFT(MD5(RAND()), 7),
    `T_BLOB`        = MD5(RAND()),
    `T_TEXT`        = MD5(RAND()),
    `T_ENUM`        = 'MON',
    `T_SET`         = 'd,b',
    `T_JSON`        = '["abc", 10, null, true, {"k1": "value", "k2": 10}]'
;

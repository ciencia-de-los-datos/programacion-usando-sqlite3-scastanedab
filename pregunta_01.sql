-- 
--  La tabla `tbl1` tiene la siguiente estructura:
-- 
--    K0  CHAR(1)
--    K1  INT
--    c12 FLOAT
--    c13 INT
--    c14 DATE
--    c15 FLOAT
--    c16 CHAR(4)
--
--  Escriba una consulta en SQL que devuelva la suma del campo c12.
-- 
--  Rta/
--     SUM(c12)
--  0  15137.63
--
--  >>> Escriba su codigo a partir de este punto <<<

import pandas as pd

import sqlite3

conn = sqlite3.connect(":memory:")  ## aca se indica el nombre de la db.
cur = conn.cursor()

with open("tbl1.csv", "rt") as f:
    datos = f.readlines()

datos = [line.replace('\n', '') for line in datos]
datos = [line.split(",") for line in datos]
datos = [tuple(line) for line in datos]

conn.executescript(
    """
DROP TABLE IF EXISTS tbl1;

CREATE TABLE tbl1 (K0  CHAR(1), K1  INT, c12 FLOAT, c13 INT, c14 DATE, c15 FLOAT, c16 CHAR(4));
"""
)
conn.commit()

#cur.execute("SELECT name FROM sqlite_master WHERE type='table';").fetchall()

cur.executemany("INSERT INTO tbl1 VALUES (?,?,?,?,?,?,?)", datos)

#cur.execute("SELECT * FROM tbl1 LIMIT 1;").fetchall()

pd.DataFrame({'SUM(c12)':cur.execute("SELECT sum(c12) FROM tbl1").fetchall()})

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

--
with open("tbl1.csv", "rt") as f:
  data = f.readlines()


conn.executescript(
    """
DROP TABLE IF EXISTS tbl1;

CREATE TABLE tbl1(K0       CHAR(1),
                  K1       INT,
                  c12      FLOAT,
                  c13      INT,
                  c14      DATE,
                  c15      FLOAT,
                  c16      CHAR(4));
"""
)
conn.commit()

cur.execute("SELECT name FROM sqlite_master WHERE type='table';").fetchall() #para ver las tablas creadas

data = [line.replace('\n', '') for line in data]
data = [line.split(",") for line in data]
data = [tuple(line) for line in data]

cur.executemany("INSERT INTO tbl1 VALUES (?,?,?,?,?,?,?)", data)

cur.execute("SELECT * FROM tbl1 LIMIT 1;").fetchall() #para verificar el primer registro 

#cur.execute("SELECT sum(c12) FROM tbl1").fetchall()

pd.DataFrame({'SUM(c12)':cur.execute("SELECT sum(c12) FROM tbl1").fetchall()})

DROP TABLE IF EXISTS saldoestoque;
CREATE TABLE saldoestoque (
	est VARCHAR(10),
	dep VARCHAR(10),
	item VARCHAR(20),
	mrp VARCHAR(10),
	qtde FLOAT);

DROP TABLE IF EXISTS saldoestoqueadicional;
CREATE TABLE saldoestoqueadicional(
	est VARCHAR(10),
	dep VARCHAR(10),
	item VARCHAR(20),
	mrp VARCHAR(10),
	qtde FLOAT);

DROP TABLE IF EXISTS saldoestoquetotal;
CREATE TABLE saldoestoquetotal(
	est VARCHAR(10),
	dep VARCHAR(10),
	item VARCHAR(20),
	qtde_atual FLOAT,
	qtde_disp FLOAT,
	custo FLOAT,
	origem VARCHAR(20),
	aloc_notas FLOAT,
	disp dep FLOAT,
	mrp VARCHAR(10));

.separator ";"
.import unisoma_saldo_estoq_full.csv saldoestoquetotal
/*Elimina header*/
DELETE FROM saldoestoquetotal WHERE ROWID IN (SELECT ROWID FROM saldoestoquetotal WHERE ROWID  LIMIT 1);
/*Acerta formatos de alguns números.*/
UPDATE saldoestoquetotal
	SET qtde_atual = ROUND(CAST(REPLACE(REPLACE(qtde_atual, ".", ""), ',', '.') AS NUMERIC), 6),
		qtde_disp = ROUND(CAST(REPLACE(REPLACE(qtde_disp, ".", ""), ',', '.') AS NUMERIC), 6),
		custo = ROUND(CAST(REPLACE(REPLACE(custo, ".", ""), ',', '.') AS NUMERIC), 6);

/*Importa arquivo separado por tab.*/
.mode tabs
.import saldoestoque.txt saldoestoque
DELETE FROM saldoestoque WHERE ROWID IN (SELECT ROWID FROM saldoestoque WHERE ROWID  LIMIT 1);

.import saldoestoqueadicional.txt saldoestoqueadicional
DELETE FROM saldoestoqueadicional WHERE ROWID IN (SELECT ROWID FROM saldoestoqueadicional WHERE ROWID  LIMIT 1);


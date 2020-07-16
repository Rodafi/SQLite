--Criando a tabela

CREATE TABLE teste (
	item VARCHAR(10),
	leadtime float);

--Inserindo chaves repetidas com valores diferentes e chaves repetidas com mesmo valor
insert into teste values ("maça",2);
insert into teste values ("maça",2.1);
insert into teste values ("abobora",3);
insert into teste values ("abobora",3.1);
insert into teste values ("abobora",3.2);
insert into teste values ("abobora",3.3);

--Vemos que para uma mesma chave temos valores diferente.
select distinct item, leadtime from teste;

--Vemos que para uma mesma chave temos valores diferente e essas estão repetidas ainda (numero de ocorrencias).
select
	a.item,
	a.valor,
	count(b.leadtime) as ocorrencias
from( 
	select distinct
		item,
		leadtime as valor
	from teste) a
inner join
	teste b
on
	a.item=b.item and a.valor=b.leadtime
group by a.item, a.valor;

--Contando o numero de valores diferentes para a mesma chave
select item, count(leadtime) from (select distinct item, leadtime from teste) group by item;

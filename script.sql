--DDL Desafio1
CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT null,
    cpf CHAR(11) NOT null,
);

CREATE TABLE certidao (
    id SERIAL PRIMARY KEY,
    cliente_id INT not null,
    data_emissao DATE,
    hora_emissao TIME, 
    validade DATE,
    codigo_validacao VARCHAR(100)
);

alter table certidao 
add constraint fk_cliente_id FOREIGN key (cliente_id) references cliente (id);

CREATE TABLE debito (
    id SERIAL PRIMARY KEY,
    cliente_id INT not null,
    valor REAL NOT null,
    data_vecimento DATE NOT null
);

alter table debito 
add constraint fk_cliente_id FOREIGN key (cliente_id) references cliente (id);

CREATE table imovel (
    id SERIAL PRIMARY KEY,
    cliente_id INT not null,
    endereco VARCHAR(150) NOT null,
    contrato_ativo BOOLEAN NOT null
);

alter table imovel 
add constraint fk_cliente_id FOREIGN key (cliente_id) references cliente (id);

--DML – Desafio1

insert into cliente (nome, cpf) 
values ('Julia Machado', '12345678978'),
('Jaqueline de Lima', '12978478511'),
('Natalia Rabello', '12345678745'),
('João Batista', '54478895512'),
('Cleusa Bittencourt', '54774554866'),
('Guilherme Silva', '00100244155'),
('Taina Cardoso', '45645678978');


insert into certidao (cliente_id, data_emissao, hora_emissao, validade, codigo_validacao)
values ('1', '11/08/2023', '10:15:00', '11/09/2023', 'ABC001'),
('2', '11/08/2023', '15:52:00', '11/09/2023', 'ABC002'),
('3', '11/08/2023', '16:14:00', '11/09/2023', 'ABC003'),
('4', '10/08/2023', '14:32:00', '10/09/2023', 'ABC004'),
('5', '10/08/2023', '09:45:00', '10/09/2023', 'ABC005'),
('6', '09/08/2023', '11:55:00', '09/09/2023', 'ABC006'),
('7', '09/08/2023', '10:01:00', '09/09/2023', 'ABC007'),
('1', '10/06/2023', '10:17:11', '10/07/2023', 'ABC008'),
('2', '28/01/2023', '15:52:00', '28/02/2023', 'ABC009'),
('2', '13/03/2023', '16:14:00', '13/04/2023', 'ABC010'),
('2', '10/05/2023', '14:32:00', '10/06/2023', 'ABC011'),
('5', '10/08/2023', '09:45:00', '10/09/2023', 'ABC012'),
('6', '19/06/2023', '11:55:00', '19/07/2023', 'ABC013'),
('7', '09/02/2023', '11:11:00', '09/03/2023', 'ABC014'),
('2', '17/04/2023', '15:54:00', '17/05/2023', 'ABC015'),
('7', '12/06/2023', '14:14:00', '12/07/2023', 'ABC016'),
('7', '30/03/2023', '11:32:00', '03/04/2023', 'ABC017');

insert into debito (cliente_id, valor, data_vecimento)
values ('3', '157.25', '10/09/2023'),
('6', '255.98', '20/08/2023'),
('3', '95.33', '30/08/2023'),
('4', '15.12', '15/09/2023');

insert into imovel (cliente_id, endereco, contrato_ativo)
values ('1', 'Rua Italia, 98 - Brasil', true),
('2', 'Rua França, 155 - Brasil', true),
('3', 'Rua Italia, 98 - Brasil', true),
('4', 'Rua Roma, 1144 - Brasil', false),
('5', 'Rua Africa, 4511 - Brasil', true),
('6', 'Rua Veneza, 74 - Brasil', true),
('7', 'Rua Canada, 748 - Brasil', true);

--Exercises

--A)	
select * from cliente ;  

--B)	
select * from certidao;

--C)	
select * from debito where cliente_id = '3';

--D)	
select * from imovel where contrato_ativo = true;

--E)	
select * from certidao 
where data_emissao between '01/06/2023' and '01/09/2023' 
and cliente_id = '1';

--F)	
select cliente_id, round (SUM(valor),2) as total_debito from debito
where cliente_id = '3'
group by cliente_id ;

--G)	
select * from certidao 
where codigo_validacao is not null
and validade is not null;

--H)	
select cl.id, cl.nome, de.valor as Valor_Debito
from cliente cl 
inner join debito de 
on cl.id = de.cliente_id; 

--I)	
select extract (month from data_emissao) as mes, 
count(*) as quantidade_certidao
from certidao
group by mes;

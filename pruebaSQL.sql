create table aerolinea(
    id_aerolinea number(5) primary key,
    nombre_aerolinea varchar2(30) not null
);

create table aeropuerto(
    id_aeropuerto number(5) primary key,
    nombre_aeropuerto varchar2(30) not null
);

create table movimiento(
    id_movimiento number(5) primary key,
    descripcion varchar2(30) not null
);

create table vuelo(
    id_aerolinea number(5) not null,
    id_aeropuerto number(5) not null,
    id_movimiento number(5) not null,
    dia date not null,
    constraint fk_aerolinea foreign key(id_aerolinea) references aerolinea(id_aerolinea),
    constraint fk_movimiento foreign key(id_movimiento) references movimiento(id_movimiento),
    constraint fk_aeropuerto foreign key(id_aeropuerto) references aeropuerto(id_aeropuerto)
);

insert into aerolinea values(1, 'Volaris');
insert into aerolinea values(2, 'Aeromar');
insert into aerolinea values(3, 'Interjet');
insert into aerolinea values(4, 'Aeromexico');

insert into aeropuerto values(1, 'Benito Juarez');
insert into aeropuerto values(2, 'Guanajuato');
insert into aeropuerto values(3, 'La paz');
insert into aeropuerto values(4, 'Oaxaca');

insert into movimiento values(1, 'Salida');
insert into movimiento values(2, 'Llegada');

insert into vuelo values(1, 1, 1,DATE '2021-05-02');
insert into vuelo values(2, 1, 1,DATE '2021-05-02');
insert into vuelo values(3, 2, 2,DATE '2021-05-02');
insert into vuelo values(4, 3, 2,DATE '2021-05-02');
insert into vuelo values(1, 3, 2,DATE '2021-05-02');
insert into vuelo values(2, 1, 1,DATE '2021-05-02');
insert into vuelo values(2, 3, 1,DATE '2021-05-04');
insert into vuelo values(3, 4, 1,DATE '2021-05-04');
insert into vuelo values(3, 4, 1,DATE '2021-05-04');






select id_aerolinea from (
   select count(ID_AEROLINEA), id_aerolinea 
   from vuelo group by id_aerolinea order by count(id_aerolinea) desc)
   where rownum = 1;

select count(ID_AEROLINEA), id_aerolinea 
   from vuelo group by id_aerolinea order by count(id_aerolinea) desc;
   
select aeropuerto.nombre_aeropuerto from
 (select id_aeropuerto from (
   select count(ID_AEROpuerto), id_aeropuerto 
   from vuelo group by id_aeropuerto order by count(id_aeropuerto) desc)
   where rownum < 3) q1
 join aeropuerto
on aeropuerto.id_aeropuerto = q1.id_aeropuerto;

select dia from (
select count(dia) as total, dia from vuelo group by dia order by dia asc
)
where rownum = 1;

select aerolinea.nombre_aerolinea from ( 
select id_aerolinea from (
select distinct count(id_aerolinea) as total, id_aerolinea, dia from vuelo  group by id_aerolinea, dia
) where total > 2) q1
join 
aerolinea
on aerolinea.id_aerolinea = q1.id_aerolinea;
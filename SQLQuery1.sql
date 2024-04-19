create database Museo

use Museo

create table Piezas (
    Codigo char(5) not null,
    Nombre varchar(50)
)

create table Pintores (
    Id char(5) not null,
    Nombre varchar(35)
)

create table Exposicion (
    CodPieza char(5) not null,
    IdPintor char(5) not null,
    Precio decimal(18,2)
)

-- primary key
alter table Piezas 
add constraint PK_CodigoPieza 
primary key (Codigo)

alter table Pintores 
add constraint PK_IdPintor
primary key (Id)

-- foreign key
alter table Exposicion
add constraint FK_CodigoPieza
foreign key (CodPieza)
references Piezas(Codigo)

alter table Exposicion
add constraint FK_IdPintor
foreign key (IdPintor)
references Pintores(Id)

insert into Piezas (Codigo, Nombre) values ('PA001','La última Cena');
insert into Piezas (Codigo, Nombre) values ('PA002','La Gioconda');
insert into Piezas (Codigo, Nombre) values ('PA003','La Noche Estrellada');
insert into Piezas (Codigo, Nombre) values ('PA004','Las Tres Gracias');
insert into Piezas (Codigo, Nombre) values ('PA005','El Grito');
insert into Piezas (Codigo, Nombre) values ('PA006','El Guernica');
insert into Piezas (Codigo, Nombre) values ('PA007','La Creación de Adán');
insert into Piezas (Codigo, Nombre) values ('PA008','Los Girasoles');
insert into Piezas (Codigo, Nombre) values ('PA009','La Tentación de San Antonio');
insert into Piezas (Codigo, Nombre) values ('PA010','Los fusilamientos del 3 de mayo');
insert into Piezas (Codigo, Nombre) values ('PA011','El Taller de BD');

select * from Piezas

insert into Pintores (Id, Nombre) values ('NA001','Goya')
insert into Pintores (Id, Nombre) values ('NA002','Dalí')
insert into Pintores (Id, Nombre) values ('NA003','Van Gogh')
insert into Pintores (Id, Nombre) values ('NA004','Miguel Angel')
insert into Pintores (Id, Nombre) values ('NA005','Pablo Picasso')
insert into Pintores (Id, Nombre) values ('NA006','Rubens')
insert into Pintores (Id, Nombre) values ('NA007','Da Vinci')
insert into Pintores (Id, Nombre) values ('NA008','Kevin')

select * from Pintores

insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA001','NA007',12000.80)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA002','NA007',13500.70)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA003','NA003',18000.13)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA004','NA006',25000.00)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA005','NA003',30879.00)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA006','NA005',25000.25)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA007','NA004',50000.75)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA008','NA003',10000.80)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA009','NA002',13000.10)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA010','NA001',9000.05)
insert into Exposicion (CodPieza, IdPintor, Precio) values ('PA011','NA008',null)

select * from Exposicion

-- Consultas

-- 1.
select Nombre from Piezas

-- 2.
select Nombre from Pintores

-- 3.
select round(avg(Precio),2) from Exposicion

-- 4.
select P.Nombre 
from Pintores as P
join Exposicion as E on P.Id = E.IdPintor
join Piezas as Pie on E.CodPieza = Pie.Codigo
where Pie.Nombre = 'El Grito'

-- 5.
select Pie.Nombre 
from Pintores as P
Join Exposicion as E on P.Id = E.IdPintor
join Piezas as Pie on E.CodPieza = Pie.Codigo
where P.Nombre = 'Van Gogh'

-- 6.
select top 3 Pie.Nombre 
from Piezas as Pie
join Exposicion as E on Pie.Codigo = E.CodPieza
order by E.Precio desc

-- 7.
select top 3 P.Nombre, E.Precio
from Pintores as P
join Exposicion as E on P.Id = E.IdPintor
join Piezas as Pie on E.CodPieza = Pie.Codigo
order by E.Precio desc

-- 8.
select P.Nombre, count(Pie.Codigo) as PiezasExpuestas
from Pintores as P
join Exposicion as E on P.Id = E.IdPintor
join Piezas as Pie on E.CodPieza = Pie.Codigo
group by P.Nombre

-- 9.
select Pie.Nombre from Pintores as P
join Exposicion as E on P.Id = E.IdPintor
join Piezas as Pie on E.CodPieza = Pie.Codigo
where P.Nombre in ('Van Gogh', 'Da Vinci')

-- 10.
update Exposicion set Precio = Precio + 1;
select * from Exposicion

-- 11.
update Pintores set Nombre = 'Vicent Van Gogh' where Nombre = 'Van Gogh';
select Nombre from Pintores

-- 12.
update Pintores set Nombre = 'Leonardo Da Vinci' where Nombre = 'Da Vinci'
select Nombre from Pintores

-- 13.
delete from Exposicion
where IdPintor = (select Id from Pintores where Nombre = 'Kevin');
select Nombre from Pintores
select * from Exposicion

-- 14.
delete from Pintores
where Id not in (
    select top 1 E.IdPintor from Exposicion as E
    Group by E.IdPintor
    order by count(E.IdPintor) asc
)

select Nombre from Pintores

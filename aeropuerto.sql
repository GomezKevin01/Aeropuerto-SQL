create database  aeropuerto;
--drop database aeropuerto
go
use aeropuerto;
--use base_consorcio
go



CREATE TABLE aeropuerto(
    idAeropuerto int identity primary key not null,
    nombre VARCHAR(150) not null,
)

Create table aerolinea (idaerolinea int primary key not null, 
						cuit int not null, 
					    nombre varchar(50),
					    					 					     					     					     				     					     
						)

create table avion(
idavion int primary key not null,
idaerolinea int not null,
fabricante int null,
cantasientos int not null ,
tipo varchar(50) null
Constraint FK_aerolinea FOREIGN KEY (idaerolinea)  REFERENCES aerolinea(idaerolinea)					 					     					     					     				     					     
)

create table vuelo (
idvuelo int identity primary key,
destino varchar(50) not null,
idaeropuerto int,
hora int, 
fecha datetime,
idavion int,
CONSTRAINT FK_avion FOREIGN KEY (idavion) REFERENCES avion(idavion),
CONSTRAINT FK_idaeropuerto2 FOREIGN KEY (idaeropuerto) REFERENCES aeropuerto (idAeropuerto) --aca hay claves con nombres reptidos
)


CREATE TABLE tarifa(
    idtarifa int primary key,
    clase varchar(10),
    precio float,
    impuesto float
    );

CREATE TABLE asiento(
    idasiento int primary key,
    letra char(1),
    numero int
    );

CREATE TABLE pais(
    idPais INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(40) NOT NULL
)

CREATE TABLE pago(
    idPago INT PRIMARY KEY IDENTITY,
    dniPasajero INT NOT NULL,
    fecha DATETIME NOT NULL,
    nroComprobante INT NOT NULL,
    monto FLOAT NOT NULL
    --CONSTRAINT UQ_idpago UNIQUE(idpago)
    --impuesto FLOAT NULL,
    --idTarifa INT,
    --CONSTRAINT FK_pago_tarifa FOREIGN KEY (idTarifa) REFERENCES tarifa(idtarifa) 
)


-----------------------------------
CREATE TABLE pasajero(
    dniPasajero INT primary key not null,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    fechaNac DATETIME,
    idPais INT NOT NULL,
    tel BIGINT NULL,
    sexo VARCHAR(1),
    email VARCHAR(80),
    CONSTRAINT CK_sexo CHECK (sexo='F' OR sexo='M'),
    CONSTRAINT FK_pasajero_pais FOREIGN KEY (idPais) REFERENCES pais(idPais)
)

CREATE TABLE Reserva(
    idReserva int identity primary key not null,
    fecha date not null,
    observacion varchar(150),
    idVuelo int not null,
    idPago int not null,
    idAsiento int not null,
    idTarifa int not null,
	dnipasajero int not null,
	CONSTRAINT FK_reserva_pasajero FOREIGN KEY (dnipasajero) REFERENCES pasajero(dnipasajero),
    CONSTRAINT FK_reserva_vuelo FOREIGN KEY (idVuelo) REFERENCES vuelo(idVuelo),
    CONSTRAINT FK_reserva_pago FOREIGN KEY (idPago) REFERENCES pago(idPago),
    CONSTRAINT FK_reserva_asiento FOREIGN KEY (idAsiento) REFERENCES asiento(idAsiento),
    CONSTRAINT FK_reserva_tarifa FOREIGN KEY (idTarifa) REFERENCES tarifa(idTarifa),
    --CONSTRAINT UQ_idreserva UNIQUE(idreserva),
	CONSTRAINT UQ_idpago UNIQUE(idpago)
	
)
 -----INSERCION DE DATOS
GO
--TABLA AEROPUERTO
--creamos un proceimiento para cargar datos a la tabla aeropuerto
create procedure inserta_aeropuerto3(
--drop procedure inserta_aeropuerto3
--no creo el atributo idaeropuerto porque es autoincremental pero en los casos que no son autoincremental hay que crearlos todos
@nombre varchar(150)
)
as
insert into aeropuerto(nombre) values (@nombre);
--cargamos los datos al procedimeinto
--el primer campo no ingreso nada porque es autoincremental
exec inserta_aeropuerto3 'belgrano';
exec inserta_aeropuerto3 'san martin';
exec inserta_aeropuerto3 'Artigas';
exec inserta_aeropuerto3 'Rosas';
select * from aeropuerto;



--TABLA AEROLINEAS
create procedure inserta_aerolinea(
@idaerolinea int,
@cuit int ,
@nombre varchar(50))
as
insert into aerolinea(idaerolinea,cuit,nombre) values (@idaerolinea, @cuit,@nombre);
--drop procedure inserta_aerolinea

exec inserta_aerolinea '1','000000001','Aerolínea argentina' ;
exec inserta_aerolinea '2','000000010','Air Flight' ;
exec inserta_aerolinea '3','000001110','Fly Bondi' ;
exec inserta_aerolinea '4','020300010','Latam airlines' ;
select * from aerolinea;

-- TABLA AVION
create procedure inserta_avion2(
@idavion int,
@idaerolinea int ,
@fabricante int ,
@cantasientos int,
@tipo varchar(50) 
)
as
insert into avion(idavion, idaerolinea,fabricante,cantasientos,tipo) values (@idavion, @idaerolinea,@fabricante,@cantasientos,@tipo);
-------------------------------------------------------------------------------------------------------------------
exec inserta_avion2 '1','3' ,'2','50','vip';
exec inserta_avion2 '2','3' ,'2','100','super vip`';
exec inserta_avion2 '3','2' ,'2','100',' vip';
exec inserta_avion2 '4','2' ,'2','100','super vip';
exec inserta_avion2 '5','1' ,'2','40','express';
exec inserta_avion2 '6','4' ,'2','100','particular';
select *from avion
order by idavion asc;

--TABLA VUELO
--tampoco se ingresa idvuelo ya que es autoincremental
 
insert into vuelo (destino,idaeropuerto,hora,fecha,idavion) values ('brazil' , 3,'08','20200911',2);
insert into vuelo (destino,idaeropuerto,hora,fecha,idavion) values ('paraguay' , 4,'19','20200912',3);
insert into vuelo (destino,idaeropuerto,hora,fecha,idavion) values ('uruguay' , 4,'21','20200913',4);
insert into vuelo (destino,idaeropuerto,hora,fecha,idavion) values ('japón' , 2,'24','20200914',1);
insert into vuelo (destino,idaeropuerto,hora,fecha,idavion) values ('angola' , 3,'10','20200905',2);
insert into vuelo (destino,idaeropuerto,hora,fecha,idavion) values ('eeuu' , 3,'12','20200606',3);
insert into vuelo (destino,idaeropuerto,hora,fecha,idavion) values ('mexico' , 4,'14','20200907',4);
insert into vuelo (destino,idaeropuerto,hora,fecha,idavion) values ('españa' , 2,'16','20201010',4);
select * from  vuelo;

--TABLA TARIFA
insert into tarifa(idtarifa,clase,precio,impuesto) values (1,'turista' , 2000,21);
insert into tarifa(idtarifa,clase,precio,impuesto) values (2,'normal' , 1000,21);
insert into tarifa(idtarifa,clase,precio,impuesto) values (3,'vip' , 5000,30); 
select * from tarifa;
--TABLA PAIS
insert into pais (nombre) values ('chile');
insert into pais (nombre) values ('brazil');
insert into pais (nombre) values ('paraguay');
insert into pais (nombre) values ('uruguay');
insert into pais (nombre) values ('angola');
insert into pais (nombre) values ('eeuu');
insert into pais (nombre) values ('mexico');
insert into pais (nombre) values ('españa');
select * from pais;
---TABLA ASIENTO
insert into asiento (idasiento,letra,numero) values (1,'A',1);
insert into asiento (idasiento,letra,numero) values (2,'A',2);
insert into asiento (idasiento,letra,numero) values (3,'A',3);
insert into asiento (idasiento,letra,numero) values (4,'A',4);
insert into asiento (idasiento,letra,numero) values (5,'B',1);
insert into asiento (idasiento,letra,numero) values (6,'B',2);
insert into asiento (idasiento,letra,numero) values (7,'B',3);
insert into asiento (idasiento,letra,numero) values (8,'B',4);
insert into asiento (idasiento,letra,numero) values (9,'C',1);
insert into asiento (idasiento,letra,numero) values (10,'C',2);
insert into asiento (idasiento,letra,numero) values (11,'C',3);
insert into asiento (idasiento,letra,numero) values (12,'C',4);
insert into asiento (idasiento,letra,numero) values (13,'D',1);
insert into asiento (idasiento,letra,numero) values (14,'D',2);
insert into asiento (idasiento,letra,numero) values (15,'D',3);
insert into asiento (idasiento,letra,numero) values (16,'D',4);
select *from asiento;

--TABLA PASAJERO
insert into pasajero (dniPasajero,nombre,apellido,fechaNac,idPais,tel,sexo,email) values (23532341,'santiago','garrido','19850701',1,379400000,'M','santi@hotmail.com'); 
insert into pasajero (dniPasajero,nombre,apellido,fechaNac,idPais,tel,sexo,email) values (33412341,'kevin','gomez','19900701',2,3794236745,'M','kevin@hotmail.com'); 
insert into pasajero (dniPasajero,nombre,apellido,fechaNac,idPais,tel,sexo,email) values (23464341,'nico','kryvenki','19900701',3,3794341212,'M','nico@hotmail.com'); 
insert into pasajero (dniPasajero,nombre,apellido,fechaNac,idPais,tel,sexo,email) values (23232341,'martin','coutinho','19900701',6,379498766234,'M','martin@hotmail.com'); 
insert into pasajero (dniPasajero,nombre,apellido,fechaNac,idPais,tel,sexo,email) values (43412341,'ismael','coronel','19900701',7,3794457643,'M','coronel@hotmail.com'); 
insert into pasajero (dniPasajero,nombre,apellido,fechaNac,idPais,tel,sexo,email) values (10532332,'maria','gimenez','20001012',8,3794437192,'F','maria@hotmail.com'); 

select *from pasajero;

--Uso de transacciones, si se produce un error se volverá a un estado anterior mediante un roolback, sino terminar la transacción con un commit
begin try
begin tran
--declare @idpago int
--TABLA PAGO
insert into pago (dniPasajero,fecha,nroComprobante,monto) values (23532341,'21210101',00001,1000);
insert into pago (dniPasajero,fecha,nroComprobante,monto) values (33412341,'21210101',00002,3000);
insert into pago (dniPasajero,fecha,nroComprobante,monto) values (31883884,'21210101',00003,5000);
insert into pago (dniPasajero,fecha,nroComprobante,monto) values (23464341,'21210101',00004,1000);
insert into pago (dniPasajero,fecha,nroComprobante,monto) values (23232341,'21210101',00005,3000);
insert into pago (dniPasajero,fecha,nroComprobante,monto) values (43412341,'21210101',00006,5000);
--set @idpago = SCOPE_IDENTITY()
--select * from pago;

--TABLA RESERVA
insert into reserva(fecha,observacion,idVuelo,idPago,idAsiento,idTarifa,dniPasajero) values('20200101','',2,1,1,1,23532341);
insert into reserva(fecha,observacion,idVuelo,idPago,idAsiento,idTarifa,dniPasajero) values('20200101','',1,2,2,2,33412341);
insert into reserva(fecha,observacion,idVuelo,idPago,idAsiento,idTarifa,dniPasajero) values('20200101','',3,3,3,3,23464341);
insert into reserva(fecha,observacion,idVuelo,idPago,idAsiento,idTarifa,dniPasajero) values('20200101','',4,4,4,3,23232341);
insert into reserva(fecha,observacion,idVuelo,idPago,idAsiento,idTarifa,dniPasajero) values('20200101','',1,5,5,2,43412341);
insert into reserva(fecha,observacion,idVuelo,idPago,idAsiento,idTarifa,dniPasajero) values('20200101','',4,6,6,1,10532332);

--select * from reserva;

commit tran
end try
begin catch
  rollback tran
  print 'ERROR: NO SE LOGRÓ CONCRETAR LA TRANSACCIÓN'
end catch

--agregue 3 procedimientos de carga  
------------------------FIN DE CARGA--------------------------
--Funciones
/* una función es un conjunto de instrucciones SQL que realizan una tarea específica de manera automática.
favorecen a la eutilización del código, acepta entradas en forma de parámetros y devuelve un valor. */

-- 1-chile
-- 2-brazil
-- 3-paraguay
-- 4-uruguay
-- 5-angola
-- 6-eeuu
-- 7-mexico
-- 8-españa

--esta funcion  sirve para saber cuanto pasajeros hay por pais
 
CREATE FUNCTION cantidadporpais
(  
	@Valor int
)
RETURNS TABLE
AS
RETURN
(
	SELECT * FROM pasajero WHERE idPais = @Valor
)
GO
select * from cantidadporpais(1);




 --Un procedimiento almacenado está formado por un conjunto de instrucciones  que definen un determinado proceso a ejecutar,
--puede aceptar parámetros de entrada y devolver un valor o conjunto de resultados
--este procedimiento realiza la misma búsqueda que la función anterior y es para demostrar las diferencias que poseen entre si
create procedure cantidadporpais1(
@valor int)
as
SELECT * FROM pasajero WHERE idPais = @Valor ;
go
exec cantidadporpais1 1;

-- esta funcion nos permite ver los pasajeros por tipo de tarifa
-- 1 -turista
-- 2 -viaje nomral
-- 3 - vip
create function totaltipotarifa
( @valor int)
returns table
as return(
select pasajero.dniPasajero,pasajero.nombre,pasajero.apellido,Reserva.idreserva, tarifa.idtarifa from pasajero
inner join Reserva on (pasajero.dniPasajero = Reserva.dnipasajero)
inner join tarifa on (tarifa.idtarifa = Reserva.idtarifa)
where tarifa.idtarifa = @valor)


go
select *from totaltipotarifa(3)





/** TRIGGERS RESERVA */



--registro de modificaciones/eliminaciones
CREATE TABLE reg_reserva(

	idReserva int,
	fecha date not null,
    observacion varchar(150),
    idVuelo int not null,
    idPago int not null,
    idAsiento int not null,
    idTarifa int not null,
	dnipasajero int,
	fecha_mod date not null,
	descripcion varchar(50) ,
	usuario varchar(30),
);

/** TRIGGER POR MODIFICACION */
--se crea el TRIGGER After Update para cuando se modifica una reserva
CREATE TRIGGER reserva_AU_modif
ON reserva
--por update
FOR UPDATE
AS
BEGIN
	--declaraciones
	declare @idReserva int
	declare @fecha	 date
	declare @idVuelo	 int
	declare @idPago	 int
	declare @idAsiento	 int
	declare @idTarifa	 int
	declare @dnipasajero int
	--asignaciones
	select @idReserva	  = idReserva from inserted
	select @fecha	  = fecha from inserted
	select @idVuelo = idVuelo from inserted
	select @idPago	  = idPago from inserted
	select @idAsiento = idAsiento from inserted
	select @idTarifa = idTarifa from inserted
	select @dnipasajero = dnipasajero from inserted
	--agregar al registro
	insert into reg_reserva(idReserva,fecha,idVuelo,idPago,idAsiento,idTarifa,dnipasajero,fecha_mod,descripcion,usuario) values (@idReserva,@fecha,@idVuelo,@idPago,@idAsiento,@idTarifa,@dnipasajero,getdate(),'Modificacion',SYSTEM_USER); 
END

/** TRIGGER POR ELIMINACION */
CREATE TRIGGER reserva_AU_elim
ON reserva
--por eliminacion
FOR DELETE
AS
BEGIN
	--declaraciones
	declare @idReserva int
	declare @fecha	 date
	declare @idVuelo	 int
	declare @idPago	 int
	declare @idAsiento	 int
	declare @idTarifa	 int
	declare @dnipasajero int
	--asignaciones
	select @idReserva	  = idReserva from deleted
	select @fecha	  = fecha from deleted
	select @idVuelo = idVuelo from deleted
	select @idPago	  = idPago from deleted
	select @idAsiento = idAsiento from deleted
	select @idTarifa = idTarifa from deleted
	select @dnipasajero = @dnipasajero from deleted
	--agregar al registro
	insert into reg_reserva(idReserva,fecha,idVuelo,idPago,idAsiento,idTarifa,dnipasajero,fecha_mod,descripcion,usuario) values (@idReserva,@fecha,@idVuelo,@idPago,@idAsiento,@idTarifa,@dnipasajero,getdate(),'Eliminacion',SYSTEM_USER);
END


--modificacion 1
UPDATE reserva
SET fecha = '2021-03-12'
WHERE idReserva = 2;

--modificacion 2
UPDATE reserva
SET fecha = '2020-11-21'
WHERE idReserva = 3;

--modificacion 3
UPDATE reserva
SET fecha = '2021-01-12'
WHERE idReserva = 6;

--eliminacion
DELETE reserva
WHERE idReserva = 1;
--eliminacion 2
DELETE reserva
WHERE idReserva = 2;

-- MOSTRAR TODAS LOS REGISTROS DE MODIFICACION/ELIMINACION
SELECT * FROM reg_reserva;


--Reservas
SELECT * FROM Reserva;

/** INDICES AGRUPADOS Y NO AGRUPADOS */

--index agrupado (ya hay un index de pk_dnipasajero)
CREATE CLUSTERED INDEX PK_Pasajero
on pasajero (dniPasajero,Nombre)

CREATE CLUSTERED INDEX IX_REG_RESERVA
	ON reg_reserva (descripcion)

--comprobamos si nuestra tabla ya tiene algun tipo de indice
EXECUTE sp_helpindex 'pasajero' -- en éste caso ya tiene un indice PK de tipo agrupado
EXECUTE sp_helpindex 'reg_reserva'


--index no agrupado de nombre
CREATE NONCLUSTERED INDEX IX_Pasajero_Nombre
on pasajero (Nombre)
--index por pais
CREATE NONCLUSTERED INDEX IX_Pasajero_Pais
on pasajero (idPais)

--muestra ordenado por nombre
SELECT dniPasajero,nombre FROM pasajero;
--muestra ordenado por pais
SELECT dniPasajero,idPais,apellido,fechaNac FROM pasajero;



/** BACKUP y RESTORE */

--Backup
BACKUP DATABASE [Aeropuerto] 
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\Aeropuerto.bak' 
WITH NOFORMAT, NOINIT,  
NAME = N'Aeropuerto-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Restore
USE [master]
RESTORE DATABASE [Aeropuerto] 
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\Aeropuerto.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5
GO



/* BORRADO */

/* ---------------------
*  -	DELETE
*  ---------------------
*/

--tablas
/*DELETE FROM reserva;
DELETE FROM aeropuerto;
DELETE FROM aerolinea;
DELETE FROM asiento;
DELETE FROM avion;
DELETE FROM pago;
DELETE FROM pais;
DELETE FROM pasajero;
DELETE FROM tarifa;
DELETE FROM vuelo;
--registros
DELETE FROM reg_reserva;
*/
/* ---------------------
*  -	DROP
*  ---------------------
*/

--tablas
/*DROP TABLE reserva;
DROP TABLE aeropuerto;
DROP TABLE aerolinea;
DROP TABLE asiento;
DROP TABLE avion;
DROP TABLE pago;
DROP TABLE pais;
DROP TABLE pasajero;
DROP TABLE tarifa;
DROP TABLE vuelo;
--registros
DROP TABLE reg_reserva;
*/

-- Permisos
-- Este usuario tiene el rol de solo lectura y solamente puede trabajar en la base de datos aeropuerto
create login kevin with password= 'admin'
use aeropuerto
create user kevin for login kevin
alter role db_datareader add member kevin
alter role db_denydatawriter add member kevin

-- Este usuario tiene el rol de solo escritura y solamente puede trabajar en la base de datos aeropuerto
create login martin with password= 'admin'
use aeropuerto
create user martin for login martin
alter role db_datawriter add member martin
alter role db_denydatareader add member martin

--Este usuario puede ejecutar cualquier comando del lenguaje de definición de datos (DDL) en una base de datos.
CREATE LOGIN nicolas with password='admin'
USE aeropuerto
CREATE USER nicolas FOR LOGIN nicolas
ALTER ROLE db_ddladmin ADD member nicolas

--Este usuario tiene el rol de crear copias de seguridad de la BD
CREATE LOGIN santiago with password='admin'
USE aeropuerto
CREATE USER santiago FOR LOGIN santiago
ALTER ROLE db_backupoperator ADD member santiago


/*   
			VISTAS			
							*/
--Vista de Aviones con su cantidad de asientos, su tipo y su aerolinea.
create view Aviones with encryption
as
select avion.idavion,avion.cantasientos,avion.tipo,aerolinea.nombre as 'Aerolinea'
from avion
INNER JOIN aerolinea ON avion.idaerolinea = aerolinea.idaerolinea 

select * from Aviones


--Prueba de Seguridad--
sp_helptext Aviones


--Vista de las Reservas, quien las hizo con sus datos y el valor de la misma.
create view Reservas1 with encryption
--drop view reservas1
as
select reserva.idReserva,pasajero.nombre, pasajero.apellido, pasajero.sexo, pasajero.dniPasajero,Reserva.fecha, pago.monto AS Pago
from pasajero
INNER JOIN Reserva ON pasajero.dniPasajero = Reserva.dnipasajero
INNER JOIN pago ON Reserva.idPago = pago.idPago

select * from Reservas1

--Prueba de Seguridad--
sp_helptext Reservas1


--Prueba de una consulta por medio de vista sin seguridad
create view Destinos
as
select vuelo.destino , vuelo.fecha, aeropuerto.nombre AS Aeropuerto
from vuelo
INNER JOIN aeropuerto ON vuelo.idaeropuerto = aeropuerto.idAeropuerto
----
select * from Destinos
--Prueba de Seguridad (Sin encriptación)
sp_helptext Destinos

--reiniciar autoincremental de cualquier tabla (aeropuerto)
DBCC CHECKIDENT (aeropuerto, RESEED, 0)


--Algunas consultas
-- Cantidad de pasajeros por pais
select  pa.nombre as Pais, count(p.dnipasajero) as 'Cantidad pasajeros'
from pasajero p
inner join pais pa
on p.idpais = pa.idpais
group by pa.nombre 

-- Detalle de la reserva
select r.idreserva, r.fecha as 'Fecha reserva', concat(p.apellido, ' ' ,p.nombre) as Pasajero, v.destino, v.fecha as 'Fecha del vuelo', v.hora as 'Hora del vuelvo', concat(a.letra,' ' ,a.numero) as Asiento, (pa.monto * t.impuesto)/100 + pa.monto + t.precio as
'Total a pagar'
from reserva r
inner join pasajero p
on r.dnipasajero = p.dniPasajero
inner join vuelo v
on r.idvuelo = v.idvuelo
inner join asiento a
on r.idAsiento = a.idasiento
inner join pago pa
on r.idpago = pa.idpago
inner join tarifa t
on r.idtarifa = t.idtarifa
order by r.idReserva
 
 --Detalle de vuelos disponibles
 select v.idvuelo, v.destino, v.fecha, v.hora, a.tipo, ae.nombre as Aerolinea
 from vuelo v
 inner join avion a
 on v.idavion = a.idavion
 inner join aerolinea ae
 on a.idaerolinea = ae.idaerolinea





 /* FUNCIONES O PROCEDIMIENTOS EXTENDIDOS PARA DOCUMENTACION */

--prueba: propiedad extendidad de aeropuerto-nombre
exec sp_addextendedproperty  
     @name = N'SNO' 
    ,@value = N'El nombre del Aeropuerto VARCHAR 150' 
    ,@level0type = N'Schema', @level0name = 'dbo' 
    ,@level1type = N'Table',  @level1name = 'aeropuerto' 
    ,@level2type = N'Column', @level2name = 'nombre'
go

--Agregar propiedad a Pasajero
exec sp_addextendedproperty  
     @name = N'MS_Description' 
    ,@value = N'Pasajero del aeropuerto' 
    ,@level0type = N'Schema', @level0name = 'dbo' 
    ,@level1type = N'Table',  @level1name = 'pasajero' 
go

--Agregar propiedad a Aeropuerto
exec sp_addextendedproperty  
     @name = N'MS_Description' 
    ,@value = N'Entidad de Aeropuerto con varios Vuelos' 
    ,@level0type = N'Schema', @level0name = 'dbo' 
    ,@level1type = N'Table',  @level1name = 'aeropuerto' 
go

--Agregar propiedad a TRIGGER reserva_AU_modif
exec sp_addextendedproperty  
     @name = N'MS_Description' 
    ,@value = N'AFTER UPDATE Se activa cuando se modifica un registro' 
    ,@level0type = N'Schema', @level0name = 'dbo' 
    ,@level1type = N'Table',  @level1name = 'Reserva'
	,@level2type = N'Trigger', @level2name = 'reserva_AU_modif'
go

--Actualizar propiedad extendida Aeropuerto
EXEC sp_updateextendedproperty   
    @name = N'MS_Description'  
    ,@value = 'Entidad de Aeropuerto'  
    ,@level0type = N'Schema', @level0name = dbo  
    ,@level1type = N'Table',  @level1name = 'aeropuerto'  
GO 

--Eliminar propiedad extendida aeropuerto-nombre
EXEC sp_dropextendedproperty   
     @name = 'SNO'   
    ,@level0type = 'schema'   ,@level0name = 'dbo'  
	,@level1type = 'table'  ,@level1name = 'aeropuerto'  
    ,@level2type = 'column'  ,@level2name = 'nombre';  
GO  



-- Schemas de SQL
SELECT
	*
FROM sys.schemas;

-- Muestra todas las Tablas con su Schema
SELECT
	schemas.name AS SchemaName,
	tables.name AS TableName
FROM sys.schemas
INNER JOIN sys.tables
ON schemas.schema_id = tables.schema_id
WHERE tables.is_ms_shipped = 0
ORDER BY schemas.name, tables.name;



-- Mostrar Extended_properties con nombre del OBJETO y su descripcion
SELECT
	Child.type_desc AS Object_Type,
	extended_properties.name AS Extended_Property_Name,
	CAST(extended_properties.value AS NVARCHAR(MAX)) AS Extended_Property_Value,
	schemas.name AS Schema_Name,
	Child.name AS Object_Name,
	Parent.name AS Parent_Object_Name,
	columns.name AS Parent_Column_Name,
	indexes.name AS Index_Name
FROM sys.extended_properties
INNER JOIN sys.objects Child
ON extended_properties.major_id = Child.object_id
INNER JOIN sys.schemas
ON schemas.schema_id = Child.schema_id
LEFT JOIN sys.objects Parent
ON Parent.object_id = Child.parent_object_id
LEFT JOIN sys.columns
ON Child.object_id = columns.object_id
AND extended_properties.minor_id = columns.column_id
AND extended_properties.class_desc = 'OBJECT_OR_COLUMN'
AND extended_properties.minor_id <> 0
LEFT JOIN sys.indexes
ON Child.object_id = indexes.object_id
AND extended_properties.minor_id = indexes.index_id
AND extended_properties.class_desc = 'INDEX'
WHERE Child.type_desc IN ('CHECK_CONSTRAINT', 'DEFAULT_CONSTRAINT', 'FOREIGN_KEY_CONSTRAINT', 'PRIMARY_KEY_CONSTRAINT', 'SQL_TRIGGER', 'USER_TABLE')
ORDER BY Child.type_desc ASC;



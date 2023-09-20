create database GanadoControlDB
go

use GanadoControlDB
go

--use master
--go
--drop database GanadoControlDB
--go

create table Usuario(
	IdUsuario int primary key identity(0,1),
	[NombreUsuario] varchar(30),
	Contraseña varbinary(max),
	Correo varchar(30),
	Rol varchar(30)
)
go

alter table Usuario
add Activo bit 
go

create table Finca
(
	IdFinca int primary key identity(0,1),
	Nombre varchar(50),
	Ubicacion varchar(100),
	Hectareas int
)
go

create table DetalleFinca(
	IdDetalleFinca int primary key identity(0,1),
	IdUsuario int foreign key references Usuario(IdUsuario),
	IdFinca int foreign key references Finca(IdFinca),
	--primary key (IdUsuario, IdFinca)
)
go

create table Ganado(
	IdGanado varchar(30) primary key,
	Raza varchar(40),
	Peso float(2),
	FechaNacimiento date,
	Tipo varchar(30),
	IdPadre varchar(30) foreign key references Ganado(IdGanado),
	IdMadre varchar(30) foreign key references Ganado(IdGanado),
	IdFinca int foreign key references Finca(IdFinca),
	--FotoUrl varchar(max)
)
go

create table Grupo(
	IdGrupo int primary key identity(0,1),
	Nombre varchar(50),
)
go

create table DetalleGrupo(
	IdFinca int foreign key references Finca(IdFinca),
	IdGrupo int foreign key references Grupo(IdGrupo),
	primary key (IdFinca, IdGrupo)
)
go

create table Farmaco(
	IdFarmaco int primary key identity(0,1),
	Nombre varchar(30),
	NombreProveedor varchar(30),
	--vacuna, desparasitante, medicamento
	Tipo varchar(30),
	UnidadMedida varchar(10),
	FechaCaducidad date,
	FechaEntrega date,
	Precio float(2),
	Cantidad int,
)
go

create table Inseminacion(
	--IdInseminacion int primary key identity(0,1),
	IdGanado varchar(30) foreign key references Ganado(IdGanado),
	FechaInseminacion date,
	primary key (IdGanado, FechaInseminacion)
)
go

create table Parto(
	IdParto int primary key identity (0,1),
	IdGanado varchar(30) foreign key references Ganado(IdGanado),
	Tipo varchar(30)
)
go

create table ProblemaFisico(
	--IdProblemaFisico int primary key identity(0,1),
	IdGanado varchar(30) foreign key references Ganado(IdGanado),
	NombreParte varchar(30),
	primary key (IdGanado, NombreParte)
)
go

create table Tratamiento(
	IdTratamiento int primary key identity(0,1),
	IdGanado varchar(30) foreign key references Ganado(IdGanado),
	IdFarmaco int foreign key references Farmaco(IdFarmaco),
	Fecha date,
	TIpo varchar(30),
	Dosis float(2),
	Observacion varchar(50),
	AreaAplicacion varchar(30)
)
go

create table Recordatorio(
	IdRecordatorio int primary key identity(0,1),
	Fecha date,
	Titulo varchar(50),
	Descripcion varchar(100),
	IdGanado varchar(30) foreign key references Ganado(IdGanado)
)
go

--create table Foto(
--	IdFoto int primary key identity(0,1),
--	FotoURL varchar(max)
--)

create table DetalleGanado(
	IdGanado varchar(30) foreign key references Ganado(IdGanado),
	--IdFoto int foreign key references Foto(IdFoto)
	FotoURL varchar(max)
)
go

create table DetallGrupo(
	IdGrupo int foreign key references Grupo(IdGrupo),
	--IdFoto int foreign key references Foto(IdFoto)
	FotoURL varchar(max)
)
go

create table DetalleFincaFoto(
	IdFinca int foreign key references Finca(IdFinca),
	--IdFoto int foreign key references Foto(IdFoto)
	FotoURL varchar(max)
)
go

alter table Parto
add Exitoso bit 
go
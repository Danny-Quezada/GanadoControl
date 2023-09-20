use GanadoControlDB
go

---------PROCEDIMIENTOS
create symmetric key SK
with algorithm = AES_256
encryption by password = 'p4ssw#rDp4ssw#rD'

--declare @password varchar(25)

alter procedure IngresarUsuario
						@correo varchar(200),
						@contraseña varchar(200),
						@rol varchar(200),
						@nombreUsuario varchar(200)
						--@contraseña varchar(max)
as
	
	if exists(select * from Usuario where Correo = @correo)
		THROW 50000, 'Ese correo ya está en uso por otro usuario', 1;
	else
	begin
		if exists(select * from Usuario where NombreUsuario = @nombreUsuario)
			THROW 50000, 'Ese nombre de usuario ya está en uso por otro usuario', 1;
		else
			Open symmetric key SK DECRYPTION BY PASSWORD='p4ssw#rDp4ssw#rD'
			insert Usuario values (@nombreUsuario, 
			ENCRYPTBYKEY(KEY_GUID('SK'), CONVERT(VARBINARY(60),@contraseña)), @correo, @rol,1)
			close symmetric key SK
	end

alter procedure ValidarIngreso @nombreUsuario varchar(200), @contraseña varchar(max)
as
	Open symmetric key SK DECRYPTION BY PASSWORD='p4ssw#rDp4ssw#rD'
	if exists (select * from Usuario 
				where NombreUsuario = @nombreUsuario 
				and @contraseña = DECRYPTBYKEY(Contraseña)
				and Activo = 1)
	begin
		select IdUsuario, Rol
		from Usuario
		where NombreUsuario = @nombreUsuario 
		and @contraseña = DECRYPTBYKEY(Contraseña)
		and Activo = 1
	end
	else
		--select 'Acceso denegado' as [Resultado]
		THROW 50000, 'Acceso denegado', 1;
	close symmetric key SK

create login GanadoControlAdmin with password = 'g4n4d0Controladmin2023'
sp_adduser GanadoControlAdmin, GanadoControlAdmin
create role Administrador
grant execute on ValidarIngreso to Administrador
grant execute on IngresarUsuario to Administrador
GRANT VIEW DEFINITION ON SYMMETRIC KEY::SK TO Administrador
sp_addrolemember Administrador, GanadoControlAdmin

exec IngresarUsuario 'ejemplo@gmail.com', '123', 'Finquero', 'Juan2023'
select * from Usuario
exec IngresarUsuario 'ejemplo@gmail.com', '123', 'Finquero', 'Juan2022'
exec IngresarUsuario 'ejemplo2@gmail.com', '123', 'Finquero', 'Juan2023'

--delete from Usuario
exec ValidarIngreso 'Juan2023', '123'

--CREACION DE PROCEDIMIENTOS DE INSERTADO
--GANADO
--GRUPO
--FINCA
--REMEDIO
--TRATAMIENTO
--PARTO
--RECORDATORIO

´--Creacion de métodos para insertar Ganado
--IdGanado varchar(30) primary key,
--	Raza varchar(40),
--	Peso float(2),
--	FechaNacimiento date,
--	Tipo varchar(30),
--	IdPadre varchar(30) foreign key references Ganado(IdGanado),
--	IdMadre varchar(30) foreign key references Ganado(IdGanado),
--	IdFinca int foreign key references Finca(IdFinca),

create proc InsertarGanado @raza varchar(40), @peso float(2), @fechaNacimiento date,
							@tipo varchar(30), @idPadre varchar(30), @idMadre varchar(30),
							@idFinca int
as
	insert into Ganado values(@raza, @peso, @fechaNacimiento, @tipo, @idPadre, @idMadre, @idFinca)

create proc EditarGanado @raza varchar(40), @peso float(2), @fechaNacimiento date,
							@tipo varchar(30), @idPadre varchar(30), @idMadre varchar(30),
							@idFinca int
as
	--update Ganado
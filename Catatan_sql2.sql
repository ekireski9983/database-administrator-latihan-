create database perusahaan
use perusahaan
drop table pegawai
CREATE TABLE pegawai
(
NIP VARCHAR (4),
NAMA VARCHAR (50),
KOTA VARCHAR (25),
TGLLAHIR DATETIME,
JK VARCHAR(1),
KJ VARCHAR (4),
CONSTRAINT pk_pegawai PRIMARY KEY (NIP)
)
--inputkan datanya sebagai berikut
insert into pegawai (NIP,NAMA,KOTA,TGLLAHIR,JK,KJ)
Values 
('N01','YAHYA','JAKARTA','1980-01-20','L','J02'),
('N02','BAYU','JAKARTA','1980-02-08','L','J01'),
('N03','M ZAINI DAHLAN','CIBINOG','1981-12-03','L','J03'),
('N04','AHMAD RIZAL','JAKARTA','1983-03-17','L','J03'),
('N05','MULIA','JAKARTA','1986-06-05','L','J04'),
('N06','UMI','JAKARTA','1986-01-06','P','J06'),
('N07','LUKMANUL HAKIM','DEPOK','1982-06-24','L','J03')
select*from pegawai
---procedure pegawai
drop PROCEDURE tampilpegawai
drop PROCEDURE tampilpegawaiNIP
CREATE PROCEDURE tampilpegawai AS
BEGIN
SELECT * FROM pegawai END;

CREATE PROCEDURE tampilpegawaiNIP @nip VARCHAR(4)
AS BEGIN
SELECT * FROM pegawai WHERE nip = @nip; END;

exec	tampilpegawai
exec	tampilpegawaiNIP  'N01';

drop PROCEDURE insertpegawai
CREATE PROCEDURE insertpegawai
@NIP VARCHAR (4),
@NAMA VARCHAR (50),
@KOTA VARCHAR (25),
@TGLLAHIR DATETIME,
@JK VARCHAR(1),
@KJ VARCHAR (4)
AS
Begin
INSERT INTO PEGAWAI (nip,nama,kota,tgllahir,jk,kj)
VALUES (@NIP,@NAMA,@KOTA,@TGLLAHIR,@JK,@JK)
end

EXEC insertpegawai'N08','SUFAJAR','KLATEN','1981-06-24','L','J02'
exec tampilpegawai

drop PROCEDURE DELETEPEGAWAI
CREATE PROCEDURE DELETEPEGAWAI
@NIP VARCHAR (4)
AS
begin
DELETE FROM pegawai WHERE nip=@NIP
end

drop PROCEDURE UPDATEPEGAWAI
CREATE PROCEDURE UPDATEPEGAWAI
@NIP VARCHAR (4),
@NAMA VARCHAR (50),
@KOTA VARCHAR (25),
@TGLLAHIR DATETIME,
@JK VARCHAR (1),
@KJ VARCHAR (4)
AS
begin
UPDATE pegawai SET nama=@NAMA, kota=@KOTA,
tgllahir=@TGLLAHIR,jk=@JK,kj=@KJ WHERE nip=@NIP
End;
exec UPDATEPEGAWAI 'N10','Arfin ipin','Jogja','2001-01-01','L','J10'
exec UPDATEPEGAWAI 'N10','Muhammad ayub','Jogja','2001-01-01','L','J10'
exec tampilpegawai
drop trigger trgNotAllowToModifyTable
CREATE TRIGGER trgNotAllowToModifyTable
ON DATABASE
FOR Drop_Table, Alter_Table
AS
SET NOCOUNT ON;
BEGIN
PRINT 'Tidak diijinkan untuk drop dan alter table.';
ROLLBACK;
END

ALTER TABLE table1 ADD col6 INT;
GO
DROP TABLE table1;
GO

DISABLE TRIGGER trgNotAllowToModifyTable ON DATABASE;
ENABLE TRIGGER trgNotAllowToModifyTable ON DATABASE;


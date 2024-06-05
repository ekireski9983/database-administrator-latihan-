create database toko_konsol
use master
use toko_konsol
drop table pembelian
create table pembelian
(
ID_Pembeli varchar (55) not null,
ID_barang varchar (55) not null,
Tanggal_pemesanan datetime,
Jumlah_pemesanan int,
nama_pelanggan varchar (55) not null,
constraint pk_pembelian primary key (ID_pembeli)
)
insert into pembelian (ID_Pembeli,ID_barang,Tanggal_pemesanan,Jumlah_pemesanan,nama_pelanggan)
values
('TY71','PS77','10/10/2020','5','Muhammad ayub'),
('GT72','PSP89','10/18/2020','4','Muhammad arya ramadhan'),

('FT73','PSP88','10/22/2021','5','Muhammad luthfi Lyasa'),
('GA51','PSV78','12/08/2023','5','Muhammad hanfi ramadhan');
select * from pembelian
drop table konsol
create table konsol (
ID_Barang varchar(100) not null,
nama_Barang varchar(100) not null,
tanggal_terima datetime,
Stok_Barang int,
constraint pk_konsol primary key (ID_Barang)
)
insert into konsol (ID_Barang,nama_Barang,tanggal_terima,Stok_Barang)
values
('PS77','Playstation 4 slim','10/10/2020','20'),
('PSP89','Playstation 4 Flat','10/18/2020','15'),
('PSP88','Playstation 3 slim','10/22/2021','20'),
('PS51','Nintendo switch slm','12/08/2023','20');
select * from konsol
select * from pembelian

drop table harga
create table harga 
(
nama_barang varchar(44) not null,
harga_barang int,
varian varchar (33) not null,
)
insert into harga (nama_barang,harga_barang,varian)
values
('Playstation 4 slim','400000','1TB'),
('Playstation 4 fat','450000','512gb'),
('Playstation 3 slim','390000','256gb'),
('Playstation vita slim','200000','128gb');
select * from harga
select * from konsol
select * from pembelian
select * from alamat

create table alamat
(
alamat varchar (50) not null,
kecamatan varchar (44) not null,
kelurahan varchar (44) not null,
domisili varchar (55) not null,
)
insert into alamat (alamat,kecamatan,kelurahan,domisili)
values
('jl kramat raya','cideng','gambir','jakarta pusat'),
('Jl kramat raya','cideng','gambir','jakarta pusat'),
('Jl Tanah abang','Cideng','gambir','jakarta pusat'),
('Jl penjaringan','tanjung priok','tanjung priok','Jakarta utara');
--latihan Join
select konsol.ID_Barang,pembelian.ID_Pembeli 
from pembelian
cross join konsol;

select pembelian.nama_pelanggan,pembelian.ID_barang,konsol.nama_Barang
from pembelian
cross join konsol;

select pembelian.ID_barang,pembelian.ID_Pembeli,pembelian.nama_pelanggan,konsol.nama_Barang,alamat.alamat
from pembelian,konsol,alamat

select konsol.ID_Barang,pembelian.ID_Pembeli,pembelian.nama_pelanggan,konsol.nama_Barang
 from pembelian
 inner join konsol
 on konsol.ID_Barang = pembelian.ID_barang

--count
 select count(nama_barang) as Total_kolom from konsol;
--Max
select max(harga_barang) as Jumlah_maksimal from harga;
--sum
select sum(harga_barang) as total_harga from harga 
group by harga_barang;
--average
select avg(harga_barang) as Rata_rata from harga;

use master
use toko_konsol
--latihan 2
select pembelian.ID_Pembeli,pembelian.nama_pelanggan,konsol.nama_Barang,pembelian.Jumlah_pemesanan
from pembelian
cross join konsol;

select konsol.ID_Barang,pembelian.ID_Pembeli,
pembelian.nama_pelanggan,konsol.nama_Barang
from konsol
inner join pembelian
on konsol.ID_Barang = pembelian.ID_barang

select * from konsol order by nama_Barang ASC;
select * from konsol order by nama_Barang desc;

select avg(Jumlah_pemesanan) as 'nilai_rata'
from pembelian;

select count(*) as 'Jumlah_data'
from konsol;

select sum(harga_barang) as 'Total_pembelian'
from harga

select max(Jumlah_pemesanan) as 'max_pembelian'
from pembelian;

select min(Jumlah_pemesanan) as 'max_pembelian'
from pembelian;

select nama_barang, count(nama_barang) as 'jumlah'
from konsol group by nama_barang

select nama_pelanggan,AVG(Jumlah_pemesanan) as 'rata-rata'
from pembelian group by ID_Pembeli
having AVG(Jumlah_pemesanan)>1

select ID_Barang,Tanggal_pemesanan,nama_pelanggan,Jumlah_pemesanan
from pembelian
where Jumlah_pemesanan = (select max(Jumlah_pemesanan)
from pembelian);

select * from pembelian
WHERE Jumlah_pemesanan = (SELECT MIN(Jumlah_pemesanan)
FROM pembelian);

select nama_pelanggan,Jumlah_pemesanan
from pembelian
union select nama_barang,stok_barang
from konsol;

SELECT nama_pelanggan,Jumlah_pemesanan
FROM pembelian 
UNION ALL
SELECT nama_barang,stok_barang
FROM konsol;

SELECT Tanggal_pemesanan,nama_pelanggan,Jumlah_pemesanan 
FROM pembelian WHERE Jumlah_pemesanan='1' 
UNION ALL 
SELECT Tanggal_pemesanan,nama_pelanggan,Jumlah_pemesanan
FROM pembelian WHERE nama_pelanggan LIKE'%ma%'

SELECT IIF (2 = 4,
'Benar',
'Salah');

-- view
CREATE VIEW Laporan1 
AS SELECT pembelian.ID_barang, pembelian.ID_barang, 
konsol.nama_Barang, pembelian.nama_pelanggan, 
pembelian.Tanggal_pemesanan, pembelian.Jumlah_pemesanan
FROM pembelian,konsol
WHERE pembelian.id_barang=konsol.ID_Barang;

--latihan terakhir
select pembelian.ID_Pembeli,pembelian.nama_pelanggan,konsol.ID_Barang,konsol.nama_Barang,pembelian.Tanggal_pemesanan
from pembelian
cross join konsol;

select sum(harga_barang) as total_harga
from harga

select count(*) as total_kolom
from konsol

select sum(harga_barang) as total_stok_barang
from harga

select max(harga_barang) as Harga_tertinggi
from harga 

select pembelian.ID_Pembeli,pembelian.nama_pelanggan,konsol.ID_Barang,konsol.nama_Barang,pembelian.Tanggal_pemesanan
from konsol
inner join pembelian
on konsol.ID_Barang=pembelian.ID_Pembeli

--- Declrare 
DECLARE @t1 INT; DECLARE @t2 INT; DECLARE @t3 INT; DECLARE @t4 INT; 
 SET @t1=1; SET @t2=2; SET @t3=4; SET @t4 = @t1+@t2+@t3;
SELECT @t1, @t2, @t3, @t4; 

-- IIF
SELECT IIF (2 = 4, 'Benar', 'Salah');
select iif(2 = 4, 'perempuan','laki-laki');

-- ISNULL
SELECT ISNULL
((SELECT nama_Barang FROM konsol 
 WHERE ID_Barang like  'PS51'), 
'Nintendo switch slm') AS hasil;

-- NullIF
SELECT NULLIF
((SELECT nama_Barang FROM konsol 
 WHERE ID_Barang like  'PS77'), 
'Playstation 3 slim') AS hasil;
select * from konsol
select * from pembelian

-- case
SELECT ID_barang , Jumlah_pemesanan,
CASE
WHEN Jumlah_pemesanan=1 THEN 'Cuma Satu'
WHEN Jumlah_pemesanan>1 THEN 'Banyak'
ELSE 'Kosong'
END AS jum
FROM pembelian
select * from pembelian

-- Declare 2
declare @t1 int;
declare @t2 int;
declare @t3 int;
declare @t4 int;
Set @t1=9;
Set @t2=4;
Set @t3=7;
SET @t4 = @t1*@t2*@t3;
SET @t4 = @t1+@t2+@t3;
SELECT @t1, @t2, @t3, @t4; 

-- temporary
drop table #templatihan
CREATE TABLE #templatihan 
(id INT PRIMARY KEY, 
nama VARCHAR(80),
alamat VARCHAR(50),
hobby VARCHAR(70)
);
insert into #templatihan(id,nama,alamat,hobby)
values
('1','Ossas','bekasi','Ngoding'),
('2','Ipin','bekasi','Bernafas'),
('3','Upin','Bekasi','Ngoding'),
('4','Andi','Bekasi','Ngoding');
select * from #templatihan

---update tabel temporary
update #templatihan set alamat='Depok'
where id=1

update #templatihan set alamat='Tanggerang'
where id=2

alter table #temptlatihan
drop column hobby

-- materi VII
select * from harga
select * from konsol
select * from pembelian
select * from alamat

--use defined function
--Penjumlahan
--DELIMITER
CREATE FUNCTION tambah (@angka1 INT, @angka2 INT)
RETURNS INT
BEGIN
RETURN @angka1 + @angka2; 
END; 
SELECT dbo.tambah(2,4)AS Penjumlahan;
--DELIMITER
-- perkalian
drop function kali
CREATE FUNCTION kali (@angka1 INT, @angka2 INT)
RETURNS INT
BEGIN
RETURN @angka1 * @angka2; 
END; 
--DELIMITER
select dbo.kali(2,4)as perkalian;
select dbo.kali(10,4)as perkalian;
--pengurangan
drop function pengurangan
CREATE FUNCTION pengurangan (@angka1 INT, @angka2 INT)
RETURNS INT
BEGIN
RETURN @angka1 - @angka2; 
END; 
--DELIMITER
select dbo.pengurangan(2,4)as kurang;
select dbo.pengurangan(10,4)as kurang;

--function kalimat
--DELIMETER
create function kalimat(@kt1 varchar(50), @kt2 varchar(50), @kt3 varchar(50) )
returns varchar(200)
begin
  return concat(@kt1, ' ', @kt2, ' ', @kt3);
end;
select dbo.kalimat('bakso bakso','konsol','bakso konsol') AS kalimat;

--stored procedures
CREATE procedure Latihan
@nilai INT OUTPUT 
AS
BEGIN
 DECLARE @nilai_a INT; 
    SET @nilai_a = 50;
    WHILE @nilai_a <= 200
    BEGIN
	 SET @nilai_a = @nilai_a * 2;
	 end
	  SET @nilai = @nilai_a; 
	  end;

DECLARE @variabel INT; 
EXEC Latihan @nilai= @variabel OUTPUT;
SELECT @variabel; 

--prodecure
drop PROCEDURE cari_nama_barang
CREATE PROCEDURE cari_nama_barang 
AS
BEGIN
SELECT * FROM konsol
END;
exec cari_nama_barang
--tabel pegawai
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
End
exec UPDATEPEGAWAI 'N10','Arfin ipin','Jogja','2001-01-01','L','J10'
exec UPDATEPEGAWAI 'N10','Muhammad ayub','Jogja','2001-01-01','L','J10'
exec tampilpegawai

--prodecure--
drop procedure cr_nm_barang
create procedure cr_nm_barang (@stok int)
as 
begin 
select * from konsol 
where Stok_Barang = @stok;
end;

declare @return_value int 
exec @return_value=cr_nm_barang
@stock=0

----trigger----
---DELIMITER
CREATE TRIGGER Stockbarang 
on pembelian
after insert 
as
begin
set konsol,Stok_Barang = konsol.Stok_Barang + i.Jumlah_pemesanan
from konsol
inner join inserted on konsol.Stok_Barang = inserted.ID_Barang
end;

insert into pembelian
(ID_Pembeli,ID_barang,Tanggal_pemesanan,nama_pelanggan,Jumlah_pemesanan)
values('P08','BRG03','2011-03-11','Wayan',1);
select * from pembelian

create procedure tampil_tb_pembelian
as
begin
select * from pembelian
end;

create procedure tampil_tb_konsol
as
begin
select * from konsol
end;
exec tampil_tb_konsol
exec tampil_tb_pembelian

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
use toko_konsol

create table coba
(
jk1 varchar(10) not null,
jk2 varchar(11)
)
GO
drop table coba

DISABLE TRIGGER trgNotAllowToModifyTable ON DATABASE;
enable TRIGGER trgNotAllowToModifyTable ON DATABASE;
DISABLE TRIGGER DDLTrigger ON DATABASE;

-- Membuat tabel untuk menyimpan log trigger DDL
select * from DDLLog
CREATE TABLE DDLLog (
 LogID INT PRIMARY KEY IDENTITY(1,1),
 EventType NVARCHAR(100),
 ObjectName NVARCHAR(255),
 ObjectType NVARCHAR(50),
 [user] VARCHAR(40), 
 EventDate DATETIME
);
GO
-- Membuat trigger DDL
CREATE TRIGGER DDLTrigger 
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE 
AS
BEGIN
 SET NOCOUNT ON;
 DECLARE @EventData XML
 SET @EventData = EVENTDATA();
 INSERT INTO DDLLog (EventType, ObjectName, ObjectType, [user], EventDate)
 VALUES (
 @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
 @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(255)'),
 @EventData.value('(/EVENT_INSTANCE/ObjectType)[1]', 'NVARCHAR(50)'),
 ORIGINAL_LOGIN(),GETDATE()
 );
END;
GO

CREATE PROCEDURE CreateDatabase @DatabaseName NVARCHAR(50)
AS BEGIN
DECLARE @SqlQuery NVARCHAR(MAX)
SET @SqlQuery = 'CREATE DATABASE ' + QUOTENAME(@DatabaseName) EXEC sp_executesql @SqlQuery
END

drop PROCEDURE CreateDatabase
CREATE PROCEDURE CreateDatabase @DatabaseName NVARCHAR(50)
AS BEGIN
DECLARE @SqlQuery NVARCHAR(MAX)
SET @SqlQuery = 'CREATE DATABASE ' + QUOTENAME(@DatabaseName) EXEC sp_executesql @SqlQuery
END
EXEC CreateDatabase @DatabaseName = 'NamaDatabaseBaru' 

drop PROCEDURE CreateTable
CREATE PROCEDURE CreateTable
@DatabaseName NVARCHAR(50), @TableName NVARCHAR(50)
AS BEGIN
DECLARE @SqlQuery NVARCHAR(MAX)
SET @SqlQuery = '
USE ' + QUOTENAME(@DatabaseName) + '; CREATE TABLE ' + QUOTENAME(@TableName) + ' (
ID INT PRIMARY KEY, Nama NVARCHAR(100),
TanggalLahir DATE,
-- Tambahkan kolom lain sesuai kebutuhan
END
);'
EXEC sp_executesql @SqlQuery
insert into db_coba_lagi(ID,nama,TanggalLahir)
values
('011','Hibban','01-01-2000'),
('012','Farhan','02-02-2000'),
('013','anton','02-02-2001'),
('014','Argo','10-02-2002');

EXEC CreateDatabase @DatabaseName = 'db_coba_lagi' 

EXEC CreateTable
@DatabaseName = 'db_coba_lagi',
@TableName = 'arifin',
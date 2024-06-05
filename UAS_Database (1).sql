-->Prosedur untuk membuat Database
create procedure CreateDatabase
	@DatabaseName NVARCHAR(50)
AS
Begin
	Declare @sqlQuery NVARCHAR(MAX)
	Set @sqlQuery = 'Create Database ' + QUOTENAME(@DatabaseName)
	Exec sp_executesql @sqlQuery
End

-->Untuk Menjalankan Procedure Membuat Database<--
exec CreateDatabase @DatabaseName = 'VCD_DwiSeptiadi'

-->Untuk menggunakan database<--
use VCD_DwiSeptiadi;


-->Prosedur Untuk Membuat Table<--
Create procedure CreateTableMasterVCD
AS
BEGIN
	Declare @sqlQuery NVARCHAR(MAX)
	Set @sqlQuery = 
	'Create Table Master_VCD (
		KdVcd Char(5) Primary key,
		Judul VARCHAR(50),
		Jumlah int
		);'
	Exec sp_executesql @sqlQuery
End;


-->Prosedur Untuk Membuat Table<--
Create procedure CreateTableMasterPeminjaman
AS
BEGIN
	Declare @sqlQuery NVARCHAR(MAX)
	Set @sqlQuery = 
	'Create Table Master_Peminjaman (
		KdPeminjam Char(5) Primary key,
		NmPeminjam VARCHAR(50),
		KTP varchar(15), 
		Alamat varchar(40),
		Telepon char(12)
		);'
	Exec sp_executesql @sqlQuery
End;

-->Prosedur Untuk Membuat Table<--
Create procedure CreateTableTransaksi_Pinjam
AS
BEGIN
	Declare @sqlQuery NVARCHAR(MAX)
	Set @sqlQuery = 
	'Create Table Transaksi_Pinjam (
		KdTransaksi Char(5) Primary key,
		TglPinjam datetime,
		KdPeminjam char(5),
		KdVcd char(5),
		jumlah int,
		BatasPinjam int,
		TglKembali datetime,
		Denda int,
		constraint fk_peminjam foreign key (KdPeminjam) references Master_Peminjaman(KdPeminjam),
		constraint fk_meminjam foreign key (KdVcd) references Master_VCD(KdVcd)
		);'
	Exec sp_executesql @sqlQuery
End;

exec CreateTableMasterPeminjaman
exec CreateTableMasterVCD
exec CreateTableTransaksi_Pinjam


create procedure Vcd
as
begin
Select * from Master_Vcd
end

create procedure Peminjaman
as
begin
Select * from Master_Peminjaman
end

create procedure Transaksi
as
begin
Select * from Transaksi_Pinjam
end


exec Vcd
exec Peminjaman
exec Transaksi


-->Untuk Prosedur Insert VCD <--
CREATE PROCEDURE insert_VCD
@KdVcd CHAR(5), 
@Judul VARCHAR(50), 
@Jumlah int
as
Begin
insert into Master_Vcd (KdVcd, Judul, Jumlah)
values (@KdVcd, @Judul, @Jumlah)
End

-->Input Data Master VCD<--
exec insert_VCD 'VCD01', 'The Mask', 5
exec insert_VCD 'VCD02', 'The Lion King', 7
exec insert_VCD 'VCD03', 'Naruto Sippuden', 7
exec insert_VCD 'VCD04', 'Rambo', 5
exec insert_VCD 'VCD05', 'Superman', 5
exec insert_VCD 'VCD06', 'Punisher', 7
exec insert_VCD 'VCD07', 'Warkop Reborn', 7
exec insert_VCD 'VCD08', 'Battle of Surabaya', 7
exec insert_VCD 'VCD09', 'Mr. Bean', 5


-->Store Procedure Insert Peminjaman<--
CREATE PROCEDURE insert_Peminjaman
@KdPeminjam CHAR(5), 
@NmPeminjam VARCHAR(30), 
@KTP varchar(15),
@Alamat varchar(40),
@Telepon char(12)
as
Begin
insert into Master_Peminjaman (KdPeminjam, NmPeminjam, KTP, Alamat, Telepon)
values (@KdPeminjam, @NmPeminjam, @KTP, @Alamat, @Telepon)
End

-->Input Data Peminjaman<--
exec insert_Peminjaman 'P0001', 'Ikbal', '20012345', 'Jatiwarna I', '484844'
exec insert_Peminjaman 'P0002', 'Darman', '20013245', 'Jatiwarna II', '484844'
exec insert_Peminjaman 'P0003', 'Mae', '20021345', 'Jatiwarna III', '484844'
exec insert_Peminjaman 'P0004', 'Yusuf', '20012345', 'Jatiwarna IV', '484844'

exec Peminjaman


-->Store Procedure Insert Transaksi<--
CREATE PROCEDURE insert_Transaksi
@KdTransaksi CHAR(5),
@TglPinjam Datetime,
@KdPeminjam CHAR(5), 
@KdVcd CHAR(5),  
@Jumlah int, 
@BatasPinjam int,
@TglKembali Datetime,
@Denda int
as
Begin
insert into Transaksi_Pinjam (KdTransaksi, TglPinjam, KdPeminjam, KdVcd ,Jumlah, BatasPinjam, TglKembali, Denda)
values (@KdTransaksi, @TglPinjam, @KdPeminjam, @KdVcd, @Jumlah, @BatasPinjam, @TglKembali, @Denda)
End


-->Input data Transaksi Pinjam
exec insert_Transaksi 'TR001', '2019-01-01', 'P0001', 'VCD01', 1, 6, '2019-01-03', 0
exec insert_Transaksi 'TR002', '2019-01-01', 'P0002', 'VCD03', 1, 6, '2019-01-08', 500
exec insert_Transaksi 'TR003', '2019-01-01', 'P0003', 'VCD02', 1, 6, '2019-01-05', 0
exec insert_Transaksi 'TR004', '2019-01-01', 'P0004', 'VCD02', 1, 6, '2019-01-09', 1000
exec insert_Transaksi 'TR005', '2019-01-01', 'P0002', 'VCD04', 1, 6, '2019-01-04', 0


exec Transaksi


-->Denda<--
select * from Transaksi_Pinjam where Denda >0


-->Tidak Disewa<--
select a.KdVcd, a.Judul
from Master_VCD as a
left join 
	Transaksi_Pinjam as b 
		on a.KdVcd = b.KdVcd
	where b.KdVcd is null


-->Lebih Dari Batas Pinjam<--
SELECT a.KdTransaksi, a.TglPinjam, a.TglKembali, a.KdVcd, b.Judul, a.jumlah, a.Denda, a.KdPeminjam, c.NmPeminjam, c.Alamat
FROM Transaksi_Pinjam as a
INNER JOIN 
	Master_VCD as b ON a.KdVcd=b.KdVcd
INNER JOIN
	Master_Peminjaman as c on a.KdPeminjam = c.KdPeminjam
where (select DATEDIFF(day, a.TglPinjam, a.TglKembali)) > a.BatasPinjam


-->Trigger Pengurangan<--
create trigger pengurangan_mastervcd
on Transaksi_Pinjam
after insert
as 
begin 
set nocount on;

declare @kd as char(5)
declare @jml_awal as int
declare @jml_pinjam as int
declare @jml_akhir as int

select @kd = KdVcd, @jml_pinjam = jumlah from inserted
select @jml_awal = Jumlah from Master_VCD
set @jml_akhir = @jml_awal - @jml_pinjam
update Master_VCD
set jumlah = @jml_akhir
where KdVcd = @kd
end

-->Input data transaksi<--
exec insert_Transaksi 'TR006', '2019-01-01', 'P0001', 'VCD04', 1, 6, '2019-01-04', 0

-->Untuk Melihat Tabel<--
exec Vcd
exec Transaksi


-->Membuat Tabel Penerimaan_VCD<--
create table penerimaan_vcd (
	NoInv char(10) primary key,
	Tgl_terima datetime,
	KdVcd char(5),
	Judul varchar(50),
	Jumlah Int
	);

-->Membuat Procedur Untuk Melihat Tabel Penerimaan VCD<--
create procedure Terima
as
Begin
Select * from penerimaan_vcd
end

-->Untuk menjalankan procedure Terima<--
exec Terima

-->Trigger Penambahan<--
create trigger penambahan_mastervcd
on penerimaan_vcd
after insert
as 
begin 
set nocount on;

declare @kd as char(5)
declare @jml_awal as int
declare @jml_tambah as int
declare @jml_akhir as int

select @kd = KdVcd, @jml_tambah = Jumlah from inserted
select @jml_awal = Jumlah from Master_VCD
set @jml_akhir = @jml_awal + @jml_tambah
update Master_VCD
set jumlah = @jml_akhir
where KdVcd = @kd
end


-->Input Data Penerimaan VCD<--
insert into penerimaan_vcd
values ('inv1234', '2019-01-15', 'VCD01', 'The Mask', 5)


-->Untuk Melihat Record pada Tabel<--
exec Vcd
exec Terima
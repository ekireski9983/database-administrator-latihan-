--Buat Database
create database Ujikom
use Ujikom

--8.buat tabel cabang
create table Cabang
(
	kodecabang char(50) primary key not null,
	namacabang varchar (50),
	alamat varchar (100)
);

--8.buat tabel jenis tabungan
create table jenis_tabungan
(
	kodetabungan char(50) primary key not null,
	jenistabungan varchar(50)
);

--8.buat tabel nasabah
create table nasabah
(
	kodetabungan char(50),
	norekening char (50) primary key not null,
	nama varchar (100),
	alamat varchar (100),
	saldo int
	constraint fk_nasabah_relation_jenis_tabungan foreign key (kodetabungan)
	references jenis_tabungan (kodetabungan)
);

--8.buat tabel header transaksi
create table header_transaksi
(
	notransaksi char (50) primary key not null,
	tgltransaksi date,
	kodecabang char (50)
	constraint fk_header_transaksi_relation_cabang foreign key (kodecabang)
	references cabang (kodecabang)
);

--8.buat tabel detail transaksi
create table detail_transaksi
(
	notransaksi char (50),
	norekening char (50),
	jenistransaksi varchar (10),
	jmltransaksi int
	constraint fk_detail_transaksi_relation_header_transaksi foreign key (notransaksi)
	references header_transaksi (notransaksi),
	constraint fk_detail_transaksi_relation_nasabah foreign key (norekening)
	references nasabah (norekening)
);

--9. Isi Tabel Cabang
insert into Cabang values ('CBNI-0001','BNI Abdul Muis','jl.Abdul muis no.7a, jak-pu, gedng departemen perhubungan')
insert into Cabang values ('CBNI-0002','BNI Cempaka Mas','jl.Letjend Suprapto jakarta pusat,rukan graha cempaka mas blok a no.3a')
insert into Cabang values ('CBNI-0003','BNI Cikini','jl.Cikini Raya kav. 62-64 jakarta pusat 10330')

--9. Isi Tabel jenis tabungan
insert into jenis_tabungan values ('TBNI-001','BNI Taplus')
insert into jenis_tabungan values ('TBNI-002','BNI Taplus Bisnis')
insert into jenis_tabungan values ('TBNI-003','BNI Haji')

--9. Isi Tabel nasabah
insert into nasabah values ('TBNI-001','000000-01','Ali Mukmin','Jakarta Selatan',500000)
insert into nasabah values ('TBNI-002','000000-02','Fika Firdasari','Jakarta Pusat',1000000)
insert into nasabah values ('TBNI-003','000000-03','Rosita','Jakarta Barat',5000000)

--9. Isi Tabel header transaksi
insert into header_transaksi values ('0000000001','10/02/2019','CBNI-0001')
insert into header_transaksi values ('0000000002','10/02/2019','CBNI-0002')
insert into header_transaksi values ('0000000003','10/02/2019','CBNI-0003')

--9. Isi Tabel detail transaksi
insert into detail_transaksi values ('0000000001','000000-01','S',500000)
insert into detail_transaksi values ('0000000002','000000-02','S',1000000)
insert into detail_transaksi values ('0000000003','000000-03','T',5000000)

--10.Tampilan data Script
select * from cabang
select * from jenis_tabungan
select * from nasabah
select * from header_transaksi
select * from detail_transaksi

--11. Tampilkan dua Tabel nasabah dengan jenis tabungan
select * from nasabah inner join jenis_tabungan
on jenis_tabungan.kodetabungan=nasabah.kodetabungan;

--soal 12 view 4 tabel Cabang,nasabah,header transaksi dan detail transaksi
create view view_transaksi as
select Cabang.kodecabang,Cabang.namacabang,Cabang.alamat,
		nasabah.norekening,nasabah.kodetabungan,nasabah.nama,nasabah.saldo,
		header_transaksi.notransaksi,header_transaksi.tgltransaksi,
		detail_transaksi.jenistransaksi,detail_transaksi.jmltransaksi
from header_transaksi inner join Cabang
on header_transaksi.kodecabang=Cabang.kodecabang
inner join detail_transaksi
on detail_transaksi.notransaksi=header_transaksi.notransaksi
inner join nasabah
on nasabah.norekening=detail_transaksi.norekening;

select * from view_transaksi

--soal 13 tampilkan kriteria saldo kurang dari 500000
select * from view_transaksi where saldo <500000

--soal 14 tampilkan kriteria saldo lebih dari 500000
select * from view_transaksi where saldo >500000

--15.Tampilkan data dari view_transaksi kriteria saldo >500.000 dan nasabah berawal huruf i
select * from view_transaksi where saldo >500000 and nama like 'f%'

--16.Pengelompokkan data scrript select dan group by berdasarkan view_transaksi dari nomorr transaksi
select sum(saldo) as 'Total Saldo' from view_transaksi group by (notransaksi)

--17.Hapus tabel Header_transaksi dan Detail_transaksi kriteria notransaksi = 0000000001
Delete from detail_transaksi where notransaksi = '0000000001';
Delete from header_transaksi where notransaksi = '0000000001';

select * from view_transaksi


--soal 18 TRIGGER
CREATE TRIGGER transaksi
on detail_transaksi
after insert
as
declare @notransaksi char(50)
declare @norekening char(50)
declare @jenistransaksi varchar(10)
declare @jmltransaksi int

select @notransaksi=notransaksi,@norekening=norekening,
		@jenistransaksi=jenistransaksi,
		@jmltransaksi=jmltransaksi from detail_transaksi

	if @jenistransaksi = 'S'
		update nasabah set saldo=saldo + @jmltransaksi where norekening=@norekening
		else update nasabah set saldo=saldo - @jmltransaksi where norekening=@norekening
		go
;
select * from nasabah
insert into detail_transaksi values ('0000000002','000000-02','S',500000)


--soal 19 CREATE PROCEDURE
create procedure pr_insert_data
@notransaksi char(10),@tgl_transaksi DATE,@idkampus char(10)
as begin
insert into t_tabunganheader values(@notransaksi,@tgl_transaksi,@idkampus)
end

exec pr_insert_data '005','10/02/2020','CB-002';

DROP PROCEDURE pr_insert_data

--soal 16 Create Procedure
create procedure pr_insert_data_detail
@notransaksi char(10),@idanggota char(50),@jenistransaksi varchar(50),@jmltransaksi int
as begin
insert into t_tabungandetail values(@notransaksi,@idanggota,@jenistransaksi,@jmltransaksi)
end

select * from t_tabungandetail;

--soal 17 Tambah Create Procedure
exec pr_insert_data '005','10/02/2020','CB-002';
exec pr_insert_data_detail '003', '000-03', 'T',300000;
select * from t_tabungandetail;
select * from t_tabunganheader;

select * from 

--soal 18 commit dan rollback
begin transaction trInsertSimpan
insert into t_simpanpinjam values ('TB-009','Haji')
select * from t_simpanpinjam
commit transaction trInsertSimpan

begin transaction trInsertSimpan
insert into t_simpanpinjam values ('TB-006','Haji')
select * from t_simpanpinjam
rollback transaction trInsertSimpan
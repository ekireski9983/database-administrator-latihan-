use master

drop database Bank_BNI

--No 7 Membuat database-- 
create database Bank_BNI

use Bank_BNI

--Membuat Table--
create table Cabang_bni
(
kode_cabang_bni varchar(50)not null,
cabang_bni varchar(50)not null,
alamat text,
constraint pk_Cabang_bni primary key (kode_cabang_bni)
)

create table Jenis_tabungan
(
kode_tabungan varchar(50)not null,
jenis_tabungan varchar(50)not null,
constraint pk_Jenis_tabungan primary key (kode_tabungan)
)

create table Nasabah
(
kode_tabungan varchar(50) not null,
no_rekening varchar(50)not null,
nama_nasabah varchar(50)not null,
alamat text,
saldo int,
constraint pk_Nasabah primary key (no_rekening)
)

create table Transaksi_header
(
no_transaksi varchar(50)not null,
tgl_transaksi datetime,
kode_cabang_bni varchar(50)not null,
constraint pk_Transaksi_header primary key(no_transaksi)
)

create table Transaksi_detail
(
no_transaksi varchar(50)not null,
no_rekening varchar(50)not null,
jenis_transaksi varchar(50)not null,
jml_transaksi int
)

--fk--
alter table Nasabah 
add constraint fk_Nasabah_relation_Jenis_tabungan
foreign key (kode_tabungan)references Jenis_tabungan(kode_tabungan)

alter table Transaksi_header
add constraint fk_Transaksi_header_relation_Cabang_bni
foreign key(kode_cabang_bni) references Cabang_bni(kode_cabang_bni)

alter table Transaksi_detail
add constraint fk_Transaksi_detail_relation_Transaksi_header
foreign key(no_transaksi)references Transaksi_header(no_transaksi)

alter table Transaksi_detail 
add constraint fk_Transaksi_detail_relation_Nasabah
foreign key(no_rekening) references Nasabah(no_rekening)

--Masukan data--
insert into Cabang_bni
(kode_cabang_bni,cabang_bni,alamat)
values('CBNI-0001','BNI Abdul Muis','Jl Abdul Muis No 7,Jakpus,Gedung departertemen perhubungan'),
('CBNI-0002','BNI Cempaka Mas','Jl Letjend Suprapto Jakpus,rukun graha cempaka mas blok a no 3a'),
('CBNI-0003','BNI Cikini','Jl Cikini Raya Kav 62-64 Jakpus 10330');

insert into Jenis_tabungan
(kode_tabungan,jenis_tabungan)
values('TBNI-001','BNI Taplus'),
('TBNI-002','BNI Taplus Bisnis'),
('TBNI-003','BNI Haji');

insert into Nasabah
(kode_tabungan,no_rekening,nama_nasabah,alamat,saldo)
values('TBNI-001','000000-01','Ali Mukmin','Jaksel','50000'),
('TBNI-002','000000-02','Fika Firdasi','Jakpus','1000000'),
('TBNI-003','000000-03','Rosita','Jakbar','5000000');

insert into Transaksi_header
(no_transaksi,tgl_transaksi,kode_cabang_bni)
values('0000000001','10/02/2019','CBNI-0001'),
('0000000002','10/02/2019','CBNI-0002'),
('0000000003','10/02/2019','CBNI-0003');

insert into Transaksi_detail
(no_transaksi,no_rekening,jenis_transaksi,jml_transaksi)
values('0000000001','000000-01','S','50000'),
('0000000002','000000-02','S','1000000'),
('0000000003','000000-03','S','5000000');

--Tampilkan isi--
select * from Cabang_bni
select * from Jenis_tabungan
select * from Nasabah
select * from Transaksi_header
select * from Transaksi_detail

--11 inner join--
select * from Nasabah
inner join Jenis_tabungan on Nasabah.kode_tabungan=Jenis_tabungan.kode_tabungan;

-- Mencari besar kecil--
select * from Transaksi where Saldo>= 5000000

--View 12--
create view Transaksi as select 
Cabang_bni.kode_cabang_bni,Cabang_bni.cabang_bni,Cabang_bni.alamat,
Jenis_tabungan.kode_tabungan,Jenis_tabungan.jenis_tabungan,
Nasabah.no_rekening,Nasabah.nama_nasabah,Nasabah.saldo,
Transaksi_header.no_transaksi,Transaksi_header.tgl_transaksi,
Transaksi_detail.jenis_transaksi,Transaksi_detail.jml_transaksi
from Transaksi_header 
inner join Cabang_bni on Transaksi_header.kode_cabang_bni=Cabang_bni.kode_cabang_bni
inner join Transaksi_detail on Transaksi_header.no_transaksi=Transaksi_detail.no_transaksi
inner join Nasabah on Transaksi_detail.no_rekening=Nasabah.no_rekening
inner join Jenis_tabungan on Nasabah.kode_tabungan=Jenis_tabungan.kode_tabungan;

--group by--
select sum (Saldo) as 'total saldo' from Transaksi group by no_transaksi;

--trigger--
create trigger Transaksi_
on Transaksi_detail after insert as
declare @no_transaksi varchar(50)
declare @no_rekening varchar(50)
declare @jenis_transaksi varchar(50)
declare @jml_transaksi int
select @no_transaksi=no_transaksi,@no_rekening=no_rekening,@jenis_transaksi=jenis_transaksi,@jml_transaksi=jml_transaksi from Transaksi_detail
if @jenis_transaksi = 'S' 
update Nasabah set saldo=saldo+@jml_transaksi where no_rekening=@no_rekening
else
update Nasabah set saldo=saldo-@jml_transaksi where no_rekening=@no_rekening
go

--19 Procedure--
create procedure pr_insert_header
@no_transaksi varchar(50),@tgl_transaksi datetime,@kode_cabang varchar(50)
as
begin
insert into Transaksi_header
values (@no_transaksi,@tgl_transaksi,@kode_cabang)
end;

create procedure pr_insert_detail
@no_transaksi varchar(50),@no_rekening varchar(50),@jenis_transaksi varchar(50),@jml_transaksi int
as
begin
insert into Transaksi_detail
values (@no_transaksi,@no_rekening,@jenis_transaksi,@jml_transaksi)
end;

--21tampilkan procedure--
exec pr_insert_header '0000000005','10/02/2019','CBNI-0001';
exec pr_insert_header '0000000006','10/02/2019','CBNI-0002';
exec pr_insert_detail '0000000005','000000-01','S','5000000';
exec pr_insert_detail '0000000006','000000-02','S','1000000';

--commit dan rollback 22--
begin transaction 
insert into Jenis_tabungan
values ('TBNI-004','Haji')
select * from Jenis_tabungan
commit transaction 

begin transaction 
insert into Jenis_tabungan
values ('TBNI-005','Haji')
select * from Jenis_tabungan
rollback transaction 


--24login--
create login Ali_JDA with password = '12345JDA'
create user Ali_JDA for login Ali_JDA;

create login Ani_JDA with password = '123456JDA'
create user Ani_JDA for login Ani_JDA;

--25--
exec sp_MSforeachtable "deny select on ? Ali_JDA;"
grant select on dbo.Nasabah to  Ali_JDA 



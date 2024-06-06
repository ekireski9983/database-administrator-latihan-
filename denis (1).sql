use master

--Membuat database--
create database Ujian

use Ujian

drop table Anggota
--Membuat Table--
create table Kampus
(
id_kampus varchar(50)not null,
nama_kampus varchar(50)not null,
alamat text,
telepon varchar(50)not null,
constraint pk_Kampus primary key (id_kampus)
)

create table Simpan_Pinjam 
(
id_simpan_pinjam varchar(50)not null,
jenis_simpan_pinjam varchar(50)not null,
constraint pk_Simpan_Pinjam primary key (id_simpan_pinjam)
)

create table Anggota
(
id_simpan_pinjam varchar(50)not null,
id_anggota varchar(50)not null,
nama_anggota varchar(50)not null,
alamat text,
saldo int,
constraint pk_Anggota primary key (id_anggota)
)

create table Tabungan_header
(
no_transaksi varchar(50)not null,
tgl_transaksi varchar(50)not null,
id_kampus varchar(50)not null,
constraint pk_Tabungan_header primary key (no_transaksi)
)
alter table Tabungan_header
alter column tgl_transaksi datetime

create table tabungan_detail 
(
no_transaksi varchar(50)not null,
id_anggota varchar(50)not null,
jenis_transaksi varchar(50)not null,
jml_transaksi int,
)

--fk--
alter table Anggota 
add constraint fk_Anggota_relation_Simpan_Pinjam
foreign key (id_simpan_pinjam) references Simpan_Pinjam(id_simpan_pinjam)

alter table Tabungan_detail 
add constraint fk_Tabungan_detail_relation_Tabungan_header
foreign key(no_transaksi)references Tabungan_header(no_transaksi)

alter table Tabungan_detail
add constraint fk_Tabungan_detail_relation_Anggota
foreign key (id_anggota) references Anggota (id_anggota)

alter table Tabungan_header
add constraint fk_Tabungan_header_relation_Kampus
foreign key (id_kampus) references Kampus (id_kampus)

--Memasukan data--
insert into Kampus
(id_kampus,nama_kampus,alamat,telepon)
values ('CB-001','Kramat','Jl Abdul Mandar No 20','021-3101662'),
('CB-002','Pondok Gede','Jl Pondok Gedey Raya','021-908765'),
('CB-003','Jakut','Jl Cicing','021-078293020');

insert into Simpan_Pinjam
(id_simpan_pinjam,jenis_simpan_pinjam)
values('TB-001','Taplus'),
('TB-002','Griya'),
('TB-003','Umroh');

insert into Anggota
(id_simpan_pinjam,id_anggota,nama_anggota,alamat,saldo)
values('TB-001','000-01','Aman','Jakpus','5000000'),
('TB-002','000-02','Amin','Jaksel','1000000'),
('TB-003','000-03','Imin','Jakut','3000000');

insert into Tabungan_header
(no_transaksi,tgl_transaksi,id_kampus)
values('0001','10/02/2020','CB-001'),
('0002','10/02/2020','CB-002'),
('0003','10/02/2020','CB-003');

insert into tabungan_detail
(no_transaksi,id_anggota,jenis_transaksi,jml_transaksi)
values('0001','000-01','S','5000000'),
('0002','000-02','S','800000'),
('0003','000-03','T','3000000');

select * from Kampus
select * from Anggota
select * from Tabungan_header
select * from tabungan_detail

-- Membuat inner join--
select * from Anggota
inner join Simpan_Pinjam on Anggota.id_simpan_pinjam=Simpan_Pinjam.id_simpan_pinjam;

--Membuat view
create view Tabungan as select 
Kampus.id_kampus,Kampus.nama_kampus,Kampus.alamat,Kampus.telepon,
Simpan_Pinjam.id_simpan_pinjam,Simpan_Pinjam.jenis_simpan_pinjam,
Anggota.id_anggota,Anggota.nama_anggota,Anggota.saldo,
Tabungan_header.no_transaksi,Tabungan_header.tgl_transaksi,
tabungan_detail.jenis_transaksi,tabungan_detail.jml_transaksi
from Tabungan_header
inner join Kampus on Tabungan_header.id_kampus=Kampus.id_kampus
inner join tabungan_detail on Tabungan_header.no_transaksi=tabungan_detail.no_transaksi
inner join Anggota on tabungan_detail.id_anggota=Anggota.id_anggota
inner join Simpan_Pinjam on Anggota.id_simpan_pinjam=Simpan_Pinjam.id_simpan_pinjam;

--menampilkan data besar dan kecil --
select * from Tabungan where saldo >= 500000

--group by--
select sum (saldo) as 'Total saldo' from Tabungan group by no_transaksi

--trigger--
create trigger Transaksi 
on Tabungan_detail after insert as
declare @no_transaksi varchar(50)
declare @id_anggota varchar(50)
declare @jenis_transaksi varchar(50)
declare @jml_transaksi int
select @no_transaksi=no_transaksi,@id_anggota=id_anggota,@jenis_transaksi=jenis_transaksi,@jml_transaksi=jml_transaksi from tabungan_detail
if @jenis_transaksi = 'S'
update Anggota set saldo = saldo +@jml_transaksi where id_anggota = @id_anggota
else
update Anggota set saldo = saldo - @jml_transaksi where id_anggota = @id_anggota
go

--procedure--
drop procedure pr_insert_header 
create procedure pr_insert_header 
@no_transaksi varchar(50),@tgl_transaksi datetime,@id_kampus varchar(50)
as
begin 
insert into Tabungan_header
values(@no_transaksi,@tgl_transaksi,@id_kampus)
end

create procedure pr_insert_detail
@no_transaksi varchar(50),@id_anggota varchar(50),@jenis_transaksi varchar(50),@jml_transaksi int
as 
begin 
insert into tabungan_detail
values(@no_transaksi,@id_anggota,@jenis_transaksi,@jml_transaksi)
end

--tampilkan--
exec pr_insert_header '0004','10/02/2020','CB-001';

--COMMIT DAN ROLLBACK--
begin transaction insertsimpan
insert into Simpan_Pinjam
values ('TB-004','Haji')
select * from Simpan_Pinjam
rollback transaction insertsimpan

begin transaction insertsimpan
insert into Simpan_Pinjam
values('TB-0005','Haji')
select * from Simpan_Pinjam
commit transaction insertsimpan

--login--
create login Denis with password = '12345'
create user userDenis for login Denis;

--21--
exec sp_MSforeachtable "deny select on? to userDenis;"
grant select on dbo.Anggota to userDenis
 

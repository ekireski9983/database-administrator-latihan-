create database Ujikom 
drop database Ujikom 
use master 
use Ujikom 
create table T_kampus
(
idkampus char (10) primary key,
namakampus varchar (40) not null,
alamat varchar (100) not null,
telepon varchar (29) not null,
)
select * from T_kampus
drop table T_anggota
create table T_anggota
(
IdSimpanPinjam char (10) foreign key REFERENCES T_SimpanPinjam (IdSimpanPinjam),
IdAnggota varchar (20) primary key,
Nama varchar (30) not null,
Alamat Varchar (100) not null,
Saldo int,
)
select * from T_anggota
create table T_SimpanPinjam
(
IdSimpanPinjam char (10) Primary key,
jenisTabungan varchar (30) not null,
)
select * from T_SimpanPinjam
create table T_TabunganHeader
(
NoTransaksi char (20) primary key,
Tgl_transaksi datetime,
idkampus char (10) foreign key references T_kampus (idkampus),
)
select * From T_TabunganHeader
drop table T_TabunganDetail
create table T_TabunganDetail
(
NoTransaksi char (20) foreign key references T_TabunganHeader (NoTransaksi),
IdAnggota varchar (20) foreign key references T_anggota (IdAnggota),
JenisTransaksi Varchar (30),
JmlTransaksi int,
)
select * from T_TabunganDetail
-->masukan tabel kampus<--
insert into T_kampus(idkampus,namakampus,alamat,telepon)
values
('CB-001','Kramat','Jl Abdul Mandar No 20','021-3101662'),
('CB-002','Pondok gede','Jl Pondok gede','021-908765'),
('CB-003','Jakut','Jl. CIcincing','021-789654');
select * from T_kampus

-->masukan tabel simpan pinjam<--
insert into T_SimpanPinjam(IdSimpanPinjam,jenisTabungan)
values
('TB-001','Taplus'),
('TB-002','Griya'),
('TB-003','Umroh');
select * from T_SimpanPinjam

-->masukan tabel anggota<--
insert into T_anggota (IdSimpanPinjam,IdAnggota,Nama,Alamat,Saldo)
values
('TB-001','000-001','Aman','Jakarta pusat','50000'),
('TB-002','000-002','Amin','Jakarta selatan','1000000'),
('TB-003','000-003','Iman','Jakarta pusat','300000');
select * from T_anggota

-->masukan tabel tabungan header<--
insert into T_TabunganHeader(NoTransaksi,Tgl_transaksi,idkampus)
values
('0001','10/02/2020','CB-001'),
('0002','10/02/2020','CB-002'),
('0003','10/02/2020','CB-003');
select * from T_TabunganHeader

insert into T_TabunganDetail(NoTransaksi,IdAnggota,JenisTransaksi,JmlTransaksi)
values
('0001','000-001','S','500000'),
('0002','000-002','S','800000'),
('0003','000-003','S','300000');
select * from T_TabunganDetail
-->soal 7<--
select * from T_anggota
select * from T_kampus
select * from T_TabunganDetail
select * from T_TabunganHeader
select * from T_SimpanPinjam
-->Soal 8<--
select * from T_anggota inner join T_SimpanPinjam 
on T_SimpanPinjam.IdSimpanPinjam=T_Anggota.IdSimpanPinjam;
-->soal 9<--
create view view_tabungan
as select T_kampus.idkampus,T_kampus.namakampus,T_kampus.telepon,
T_SimpanPinjam.IdSimpanPinjam,T_SimpanPinjam.jenisTabungan,T_anggota.IdAnggota,T_anggota.Nama,
T_anggota.Saldo,T_TabunganHeader.NoTransaksi,T_TabunganHeader.Tgl_transaksi,
T_TabunganDetail.JenisTransaksi,T_TabunganDetail.JmlTransaksi

from T_TabunganHeader inner join T_kampus
on T_TabunganHeader.idkampus=T_kampus.idkampus
inner join T_TabunganDetail 
on T_TabunganHeader.NoTransaksi=T_TabunganDetail.NoTransaksi
inner join T_anggota
on T_TabunganDetail.IdAnggota=T_anggota.IdAnggota
inner join T_SimpanPinjam
on T_SimpanPinjam.IdSimpanPinjam=T_anggota.IdSimpanPinjam
select * from view_tabungan
-->soal 10<--
select * from view_tabungan where Saldo>50000;
-->soal 11<--
select * from view_tabungan where Saldo>50000 and Nama like'i%';
-->soal 12<--
select sum(saldo) as 'Total saldo' from view_tabungan group by NoTransaksi;
-->soal 13<--
delete * from T_TabunganHeader ='S' then Saldo
-->soal 14<--
create trigger transaksi 
on T_TabunganDetail
after insert,update
as
declare @notransaksi char(10)
Declare @IdAnggota char(10)
Declare @JenisTransaksi varchar(20)
Declare @JmlTransaksi int
select @notransaksi=notransaksi,@IdAnggota=IdAnggota,
@JenisTransaksi=JenisTransaksi,
@JmlTransaksi=JmlTransaksi from T_TabunganDetail

if @JenisTransaksi='S'
update T_anggota set saldo = @JmlTransaksi where IdAnggota=@IdAnggota
else 
update T_anggota set saldo = @JmlTransaksi where IdAnggota=@IdAnggota
go

select * from T_anggota
insert into T_TabunganDetail 
values
('0003','000-003','S','300000');
-->soal 15<--
drop procedure Insert_header_tabungan 
create procedure Insert_header_tabungan 
@notransaksi char(10),@tgl_transaksi DATE,@idkampus char(10)
as
begin
insert into T_TabunganHeader 
values(@notransaksi,@tgl_transaksi,@idkampus)
end

select * from T_TabunganHeader;
exec Insert_header_tabungan '0005','10-10-2022','CB-002';
-->soal 16<--
drop procedure insert_detail_Tabungan
create procedure insert_detail_Tabungan
@Notransaksi char(10),@id_anggota Varchar(10),@jenis_transaksi char(20),@Jumlah_Transaksi int
as
begin
insert into T_TabunganDetail
values (@Notransaksi,@id_anggota,@jenis_transaksi,@Jumlah_Transaksi)
end

select * from T_TabunganDetail
exec insert_detail_Tabungan '0007','000-01','S','400000';
-->soal 17<--
exec Insert_header_tabungan '0005','10-10-2022','CB-002';
select * from T_SimpanPinjam
-->soal 18<--
begin transaction insert_simpan_pinjam
insert into T_SimpanPinjam
values ('CB-006','Haji')
select * from T_SimpanPinjam
rollback transaction insert_simpan_pinjam

begin transaction insert_simpan_pinjam
insert into T_SimpanPinjam
values ('CB-006','Haji')
select * from T_SimpanPinjam
commit transaction insert_simpan_pinjam

-->soal 20<--
create login Aman with password='12345'
create user userAman for login Aman;

create login Amin with password='12345'
create user userAmin for login Amin;

-->soal 21<--
exec sp_MSforeachtable "deny select on ? to userAman;"
grant select on dbo.T_Anggota to userAman

exec sp_MSforeachtable "deny select on ? to userAman;"
grant select on dbo.T_kampus to userAmin

create database penjualan_Rezky
use master
use penjualan_Rezky
drop database penjualan_Rezky
CREATE TABLE barang (
	kd_brg VARCHAR (10) PRIMARY KEY,
	nm_brg VARCHAR (50),
	harga INT
);
CREATE TABLE pelanggan (
	kd_plg VARCHAR (10) PRIMARY KEY,
	nm_plg VARCHAR (50),
	alamat VARCHAR (150),
	no_hp VARCHAR (15)
);
CREATE TABLE transaksi (
	no_trans VARCHAR (10) PRIMARY KEY,
	tgl_trans DATE,
	kd_plg VARCHAR (10) FOREIGN KEY REFERENCES pelanggan (kd_plg)
);
CREATE TABLE detail (
	no_trans VARCHAR (10) FOREIGN KEY REFERENCES transaksi (no_trans),
	kd_brg VARCHAR (10) FOREIGN KEY REFERENCES barang (kd_brg),
	jumbel INT
);
insert into pelanggan
(kd_plg, nm_plg, alamat, no_hp)
values ('ABD','Abdur Rahman','Bekasi', '0891212212222'),
('ABF','Abdul Fatah','Kramat', '0817212212222'),
('ADF','Aria Dana Fauzan','Duren Sawit', '0854621345678'),
('FRW','Fauzan Marwa','Ciledug', '0812212212222'),
('KMG','Kamil Maulana Ginata','Pondok Gede', '083523232323');
select * from pelanggan;

insert into barang
(kd_brg, nm_brg, harga)
values ('CUJ15','Cuer Joyko Besar CU – 1','5500'),
('GTNJ5','Gunng Junior Warna J5','4000'),
('NTP01','Nota 1 Ply HVS','35000'),
('STPJ10','Stapler Joyko HD-10 M','6000'),
('TPK01','Tempat Pensil Kotak','15000');
select * from barang;

insert into transaksi
(no_trans, tgl_trans, kd_plg)
values ('TR001','2023-07-08','ABD'),
('TR002','2023-07-13','FRW');
select * from transaksi
select * from barang
select * from pelanggan

select * from barang
where harga >=6000;

ALTER TABLE transaksi
Add constraint fk_transaksi_relation_detail
Foreign key (no_trans)
References transaksi (no_trans)

ALTER TABLE detail
Add constraint fk_transaksi_relation_detail
Foreign key (kd_brg)
References transaksi (kd_brg)

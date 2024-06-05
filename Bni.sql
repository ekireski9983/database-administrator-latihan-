--menggunakan db master--
USE master

--membuat database BNI--
CREATE DATABASE BNI

--menggunakan database BNI--
USE BNI

--membuat table Cabang_BNI--
CREATE TABLE Cabang_BNI
(
Kode_Cabang VARCHAR(50) PRIMARY KEY,
Cabang_BNI VARCHAR(100),
Alamat TEXT
)

--membuat table Jenis_Tabungan--
CREATE TABLE Jenis_Tabungan
(
Kode_Tabungan VARCHAR(50) PRIMARY KEY,
Jenis_Tabungan VARCHAR(100)
)

--membuat table Nasabah--
CREATE TABLE Nasabah
(
Kode_Tabungan VARCHAR(50),
No_Rekening VARCHAR(20) PRIMARY KEY,
Nama VARCHAR(250),
Alamat TEXT,
Saldo INT,
FOREIGN KEY (Kode_Tabungan) references Jenis_Tabungan (Kode_Tabungan)
)

--membuat table Header_Transaksi--
CREATE TABLE Header_Transaksi
(
No_Transaksi VARCHAR(20) PRIMARY KEY,
Tgl_Transaksi DATETIME,
Kode_Cabang VARCHAR(50),
FOREIGN KEY (Kode_Cabang) references Cabang_BNI (Kode_Cabang)
)

--membuat table Detail_Transaksi--
CREATE TABLE Detail_Transaksi
(
No_Transaksi VARCHAR(20),
No_Rekening VARCHAR(20),
Jenis_Transaksi VARCHAR(10),
Jml_Transaksi INT
FOREIGN KEY (No_Transaksi) references Header_Transaksi (No_Transaksi),
FOREIGN KEY (No_Rekening) references Nasabah (No_Rekening)
)

--menambah data pada table Cabang_BNI--
INSERT INTO Cabang_BNI
(Kode_Cabang, Cabang_BNI, Alamat) VALUES
('CBNI-0001', 'BNI Abdul Muis', 'Jl. Abdul Muis No. 7A, Jakpus'),
('CBNI-0002', 'BNI Cempaka Mas', 'Ruko Graha Cempaka Mas Blok A'),
('CBNI-0003', 'BNI Cikini', 'Jl. Cikini Raya Kav. 62-64, Jakpus')

--menambah data pada table Jenis_Tabungan--
INSERT INTO Jenis_Tabungan
(Kode_Tabungan, Jenis_Tabungan) VALUES
('TBNI-001', 'BNI Taplus'),
('TBNI-002', 'BNI Taplus Bisnis'),
('TBNI-003', 'BNI Haji')

--menambah data pada table Nasabah--
INSERT INTO Nasabah
(Kode_Tabungan, No_Rekening, Nama, Alamat, Saldo) VALUES
('TBNI-001', '000000-01', 'Ali Mukmin', 'Jakarta Selatan', 500000),
('TBNI-002', '000000-02', 'Fika Firdasari', 'Jakarta Pusat', 1000000),
('TBNI-003', '000000-03', 'Rosita', 'Jakarta Barat', 5000000)

--menambah data pada table Header_Transaksi--
INSERT INTO Header_Transaksi
(No_Transaksi, Tgl_Transaksi, Kode_Cabang) VALUES
('0000000001', '02/10/2019', 'CBNI-0001'),
('0000000002', '02/10/2019', 'CBNI-0002'),
('0000000003', '02/10/2019', 'CBNI-0003')

--menambah data pada table Detail_Transaksi--
INSERT INTO Detail_Transaksi
(No_Transaksi, No_Rekening, Jenis_Transaksi, Jml_Transaksi) VALUES
('0000000001', '000000-01', 'S', 500000),
('0000000002', '000000-02', 'S', 1000000),
('0000000003', '000000-03', 'S', 5000000)

--menampilkan data pada table--
SELECT * FROM Cabang_BNI;
SELECT * FROM Jenis_Tabungan;
SELECT * FROM Nasabah;
SELECT * FROM Header_Transaksi;
SELECT * FROM Detail_Transaksi;

--menampilkan 2 table (Nasabah & Jenis_Tabungan) menggunakan INNER JOIN--
SELECT * FROM Nasabah INNER JOIN Jenis_Tabungan ON Nasabah.Kode_Tabungan = Jenis_Tabungan.Kode_Tabungan

--membuat view dari 4 tabel (Nasabah, Cabang, Header_Transaksi, dan Detail_Transaksi) menggunakan INNER JOIN--
CREATE VIEW View_Transaksi
AS SELECT
Nasabah.No_Rekening, Nasabah.Nama, Nasabah.Alamat, Nasabah.Saldo,
Cabang_BNI.Kode_Cabang, Cabang_BNI.Cabang_BNI,
Header_Transaksi.No_Transaksi, Header_Transaksi.Tgl_Transaksi,
Detail_Transaksi.Jenis_Transaksi, Detail_Transaksi.Jml_Transaksi
FROM Detail_Transaksi
INNER JOIN Header_Transaksi ON Detail_Transaksi.No_Transaksi = Header_Transaksi.No_Transaksi
INNER JOIN Nasabah ON Detail_Transaksi.No_Rekening = Nasabah.No_Rekening
INNER JOIN Cabang_BNI ON Header_Transaksi.Kode_Cabang = Cabang_BNI.Kode_Cabang;

--menampilkan data dari View_Transaksi--
SELECT * FROM View_Transaksi;

--menampilkan data dari View_Transaksi dengan kriteria Jml_Transaksi <= 500.000--
SELECT * FROM View_Transaksi WHERE Jml_Transaksi <= 500

--menampilkan data dari View_Transaksi dengan kriteria Jml_Transaksi >= 500.000--
SELECT * FROM View_Transaksi WHERE Jml_Transaksi >= 500

--menampilkan data dari View_Transaksi dengan kriteria Jml_Transaksi >= 500.000 berawal huruf F--
SELECT * FROM View_Transaksi WHERE Jml_Transaksi >= 500 AND Nama LIKE 'F%'

--menampilkan data dari View_Transaksi berdasarkan No_Transaksi menggunakan GROUP BY--
SELECT SUM (Saldo) as 'Total Saldo' FROM View_Transaksi GROUP BY No_Transaksi

--menghapus data pada table Detail_Transaksi dengan No_Transaksi = '0000000001'--
DELETE FROM Detail_Transaksi WHERE No_Transaksi = '0000000001'

--menghapus data pada table Header_Transaksi dengan No_Transaksi = '0000000001'--
DELETE FROM Header_Transaksi WHERE No_Transaksi = '0000000001'

--membuat TRIGGER pada table Detail_Transaksi untuk melakukan UPDATE pada table Nasabah--
CREATE TRIGGER Transaksi
ON Detail_Transaksi AFTER INSERT
AS BEGIN
UPDATE Nasabah SET Saldo = 

CASE
	WHEN Detail_Transaksi.Jenis_Transaksi = 'S' THEN Saldo + Detail_Transaksi.Jml_Transaksi
	WHEN Detail_Transaksi.Jenis_Transaksi = 'S' THEN Saldo - Detail_Transaksi.Jml_Transaksi
	ELSE Saldo
END

FROM Nasabah INNER JOIN inserted Detail_Transaksi on Nasabah.No_Rekening = Detail_Transaksi.No_Rekening
END;

--membuat store procedure untuk menambah data pada table Header_Transaksi--
CREATE PROCEDURE Insert_Header
@no VARCHAR(20), @tgl DATETIME, @Kode_Cabang VARCHAR(50)
AS BEGIN
INSERT INTO Header_Transaksi VALUES
(@no, @tgl, @Kode_Cabang)
END;

--membuat store procedure untuk menambah data pada table Detail_Transaksi--
CREATE PROCEDURE Insert_Detail
@no_tr VARCHAR(20), @no_rek VARCHAR(20), @jenis VARCHAR(10), @jml INT
AS BEGIN
INSERT INTO Detail_Transaksi VALUES
(@no_tr, @no_rek, @jenis, @jml)
END;

--saldo awal nasabah--
SELECT * FROM Nasabah;

--menjalankan store procedure--
EXEC Insert_Header '0000000004', '02/14/2019', 'CBNI-0003';
EXEC Insert_Detail '0000000004', '000000-03', 'S', 5000000;

--saldo terbaru nasabah--
SELECT * FROM Nasabah;
SELECT * FROM Header_Transaksi;
SELECT * FROM Detail_Transaksi;

--membuat COMMIT--
BEGIN TRANSACTION
INSERT INTO Cabang_BNI VALUES ('CBNI-0004', 'BNI Cakung', 'Jl. Bintara, Jaktim')
SELECT * FROM Cabang_BNI
COMMIT TRANSACTION

--membuat ROLLBACK--
BEGIN TRANSACTION
INSERT INTO Cabang_BNI VALUES ('CBNI-0005', 'BNI Gambir', 'Jl. Gambir Raya, Jakpus')
SELECT * FROM Cabang_BNI
ROLLBACK TRANSACTION

SELECT * FROM Cabang_BNI
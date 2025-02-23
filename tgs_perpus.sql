 -------------------------------
 -- AMALIA RAHMADANI TUGAS DB
 -- SOAL 1
CREATE DATABASE db_perpustakaan;
use db_perpustakaan;
---------------------------------
-- SOAL 2
	create table bukuu(
id_buku int primary key auto_increment,
judul_buku varchar(100),
penulis varchar(100),
kategori varchar(100),
stok int);

create table siswaa(
id_siswa int primary key auto_increment,
nama varchar(100),
kelas varchar(100)
);

create table peminjamann(
id_peminjaman int primary key auto_increment,
id_siswa int,
id_buku int,
tanggal_pinjam date,
tanggal_kembali date,
status varchar (100)
);
--------------------------------------
-- SOAL 3
insert into bukuu (judul_buku,penulis,kategori,stok)values
("Algoritma dan Pemograman","Andi Wijaya","Teknologi",5),
("Dasar dasar Database","Budi Santoso","Teknologi",7),
("Matematika Diskrit","Rina Sari","Matekmatika",4),
("Sejarah Dunia","John Smith","Sejarah",3),
("Pemograman WEB Dengan PHP","Eko Prasetyo","Teknologi",8);
 -- select * from bukuu
 
 insert into siswaa (nama,kelas) values
("Andi Saputra","X-RPL"),
("Budi Wijaya","X-TKJ"),
("Citraa Lestari","XI-RPL"),
("Dewi Kurniawan","XI-TKJ"),
("Eko Prasetyo","XII-RPL");
 -- select *from siswaa
 insert into peminjamann (id_siswa,id_buku,tanggal_pinjam,tanggal_kembali,status) values
(11,2,'2025-02-01','2025-02-08',"Dipinjam"),
(2,5,'2025-01-28','2025-02-04',"Dikembalikan"),
(3,8,'2025-02-02','2025-02-09',"Dipinjam"),
(4,10,'2025-01-30','2025-02-06',"Dikembalikan"),
(51,3,'2025-01-25','2025-02-01',"Dikembalikan");
-- select * from peminjamann
--------------------------------------------------
-- SOAL 4
DELIMITER $$
CREATE PROCEDURE insert_bukuu(
pJudul_buku varchar(100), pPenulis varchar(100), pKategori varchar(100), pStok int)
BEGIN
INSERT INTO bukuu (judul_buku, penulis, kategori, stok) VALUES (pJudul_buku, pPenulis,pKategori, pStok);
END $$
DELIMITER ;

CALL insert_bukuu("Sistem Operasi","Dian Kurniawan","Teknologi",6);
CALL insert_bukuu("Jaringan Komputer","Ahmad Fauzi","Teknologi",5);
CALL insert_bukuu("Cerita Rakyat Nusantara","Lestari Dewi","Sastra",9);
CALL insert_bukuu("Bahasa Inggris untuk Pemula","Jane Doe","Bahasa",10);
CALL insert_bukuu("Biologi Dasar","Budi Rahman","Sains",7);
CALL insert_bukuu("Kimia Organik","Siti Aminah","Sains",5);
CALL insert_bukuu("Teknik Elektro","Ridwan Hakim","Teknik",6);
CALL insert_bukuu("Fisika Modern","Albert Einstein","Sains",4);
CALL insert_bukuu("Manajemen Waktu","Steven Covey","Pengembangan",8);
CALL insert_bukuu("Strategi Belajar Efektif","Tony Buzan","Pendidikan",6);

-- procedure insert table siswa
DELIMITER $$
create procedure insert_siswaa(
pNama varchar(100),
pKelas varchar(100))
BEGIN
INSERT INTO siswaa (nama,kelas) values (pNama,pKelas);
END $$
DELIMITER ;

CALL insert_peminjamana(15,7,'2025-02-01','2025-02-08',"Dipinjam");
CALL insert_peminjamann(7,1,'2025-01-29','2025-02-05',"Dikembalikan");
CALL insert_peminjamann(8,9,'2025-02-03','2025-02-10','Dipinjam');
CALL insert_peminjamann(13,4,'2025-01-27','2025-02-03','Dikembalikan');
CALL insert_peminjamann(10,11,'2025-02-01','2025-02-08',"Dipinjam");
-- select * from peminjamann;

---------------------------------------------------------------
-- SOAL 5
-- UPDATE KELAS 
DELIMITER $$
create procedure update_KelasSiswa(
IN new_id int,
IN new_Kelas varchar(100))
BEGIN
update siswa set kelas = new_Kelas where id_siswa=new_id;END $$
DELIMITER ;
CALL update_KelasSiswa(2,"rpl");
 select * from siswa;

-- UPDATE STOK BUKU
DELIMITER $$
create procedure update_StokBuku(
IN new_Id_Buku int,
IN new_Stok int)
BEGIN
update bukuu set stok = new_Stok where id_buku=new_Id_Buku; END $$
DELIMITER ;
CALL update_StokBuku(1,20);
-- select * from bukuu; 

-- UPDATE ID_BUKU PEMINJAMAN
DELIMITER $$
create procedure update__Peminjaman(
IN new_Id_Peminjaman int,
IN new_Status varchar(100))
BEGIN
update peminjaman set status = new_Status where id_peminjaman=new_Id_Peminjaman;END $$
DELIMITER ;
CALL update_Status_Peminjaman(10,"Dikembalikan");
-- select * from peminjamann;

-- DELETE TABLE BUKU
DELIMITER $$
create procedure delete_Buku(In new_Id_Buku int)
Begin
DELETE FROM bukuu where id_buku = new_Id_Buku;END $$
DELIMITER ;
CALL delete_Buku(15);
select * from bukuu;

-- DELETE TABLE SISWA
--DELIMITER $$
create procedure delete_Siswa (In new_Nama int)
Begin
DELETE FROM siswa where nama = new_Nama; END $$
DELIMITER ;
CALL delete_Nama(10,"Intan Permadi");
-- select * from siswa;

-- DELETE TABLE PINJAMAN
--DELIMITER $$
create procedure delete_Id_buku (in new_Id_buku int)
Begin 
delete FROM peminjaman where id_buku  = new_Id_buku; END $$
DELIMITER ;
CALL delete_Id_buku(10);
-- select * from peminjaman;
------------------------------------------------------
-- SOAL 6
-- TABEL BUKU
DELIMITER $$
create procedure lihat_buku()
BEGIN
select * from bukuu; END $$
DELIMITER ;
CALL lihat_buku()

--TAMPIL MYENYELURUH
DELIMITER $$
CREATE PROCEDURE tampil_seluruhh()
BEGIN
	SELECT * FROM bukuu;
    SELECT * FROM siswaa;
    SELECT * FROM peminjamann;
END $$
DELIMITER ;
--------------------------------

-- SOAL 7
DELIMITER $$

CREATE TRIGGER kurangi_stok
AFTER INSERT ON peminjaman
FOR EACH ROW
BEGIN
    UPDATE buku 
    SET stok = stok - 1
    WHERE id_buku = NEW.id_buku;END $$
DELIMITER ;
-- Memasukkan data peminjaman dengan perubahan parameter
CALL insert_peminjaman(2, 3, "2025-03-10", "2025-03-20", "Dipinjam");
-- Melihat daftar buku menggunakan prosedur
CALL lihat_buku();
----------------------------------------
-- SOAL 8
DELIMITER $$
CREATE TRIGGER tambah_stok 
AFTER UPDATE ON peminjaman
FOR EACH ROW
BEGIN
    IF NEW.status = 'Dikembalikan' AND OLD.status <> 'Dikembalikan' THEN
        UPDATE peminjaman SET stok = stok + 1 WHERE id_buku = NEW.id_buku;
    END IF;
END $$
DELIMITER ;
----------------------------------------------

-- SOAL 9
DELIMITER $$
  create procedure kembali_buku(
  IN id_pinjam INT
)
BEGIN
UPDATE buku
set status = "Dikembalikan",
tanggal_kembali = current_date WHERE id_buku = id_pinjam;END $$
DELIMITER ;
CALL kembali_buku(20);
---------------------------------------

-- SOAL 10
DELIMITER $$

CREATE PROCEDURE daftar_siswa_peminjam()
BEGIN
    SELECT DISTINCT s.id_siswa, s.nama, s.kelas
    FROM siswa 
    JOIN peminjaman p ON s.id_siswa = p.id_siswa;
END $$
DELIMITER ;
-------------------------------

-- SOAL 11
DELIMITER $$

CREATE PROCEDURE semua_siswa_peminjam()
BEGIN
    SELECT s.id_siswa, s.nama, s.kelas, 
           IFNULL(COUNT(p.id_peminjaman), 0) AS jumlah_peminjaman
    FROM siswa s
    LEFT JOIN peminjaman p ON s.id_siswa = p.id_siswa
    GROUP BY s.id_siswa, s.nama, s.kelas;
END $$
----------------------------------------------

-- SOAL 12
DELIMITER $$

CREATE PROCEDURE semua_buku_dipinjam()
BEGIN
    SELECT b.id_buku, b.judul_buku, b.penulis, b.kategori, b.stok, 
           IFNULL(COUNT(p.id_peminjaman), 0) AS jumlah_dipinjam
    FROM buku b
    LEFT JOIN peminjaman p ON b.id_buku = p.id_buku
    GROUP BY b.id_buku, b.judul_buku, b.penulis, b.kategori, b.stok;
END $$

DELIMITER ;













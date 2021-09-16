/*======================= CONSTRAINTS - KISITLAMALAR ======================================
    NOT NULL - Bir Sütunun  NULL içermemesini garanti eder.
    UNIQUE - Bir sütundaki tüm deðerlerin BENZERSÝZ olmasýný garanti eder.
    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin
                  BENZERSÝZ olmasýný garanti eder.(NOT NULL ve UNIQUE birleþimi gibi)
    FOREIGN KEY - Baþka bir tablodaki Primary Key’i referans göstermek için kullanýlýr.
                  Böylelikle, tablolar arasýnda iliþki kurulmuþ olur.
    CHECK - Bir sutundaki tüm verilerin belirlenen özel bir þartý saðlamasýný garanti eder.
    soldan tablo silerken tablonun kapalý olmasý lazým
    --unique constraint tekrara izin vermez ancak istediðiniz kadar null girebilirsiniz
    */
    
   --ORNEK1- NOT NULL
   -- ogrenciler tablosu olusturalim ve id field ýný bos birakilamaz yapalim
  CREATE TABLE ogrenciler (
  id char(4) not null,
  isim varchar(50),
  not_ort number(4,2), --98,55
  kayit_tarihi date
  );
  INSERT INTO ogrenciler VALUES('1234','hasan',75.25,'14-01-2020');
  INSERT INTO ogrenciler VALUES('1234','ayse',null,null);
  INSERT INTO ogrenciler (id,isim) VALUES('3456','fatma');
  INSERT INTO ogrenciler VALUES(null,'osman',45.25,'5-01-2020');--ORA-01400: cannot insert NULL into ("HR"."OGRENCILER"."ID")
  SELECT * FROM ogrenciler;
  --ORNEK2 UNIQUE
  --tedarikciler olusturalim id unique olsun

create table tedarikciler
  (
  id char(4) UNIQUE,
  isim varchar(50),
  adres varchar(100),
  tarih date
);

  INSERT INTO tedarikciler VALUES ('1234','ayse','mehmet mah izmir','10-11-2020' );
INSERT INTO tedarikciler VALUES ('1234','fatma','veli mah istanbul','5-11-2020' );--ORA-00001: unique constraint (HR.SYS_C007481) violated
INSERT INTO tedarikciler VALUES (null,'cem','süvari mah denizli','5-11-1997' );
INSERT INTO tedarikciler VALUES (null,'can','zeki mah mus','5-11-1998' );
drop table tedarikciler;
  --unique constraint tekrara izin vermez ancak istediðiniz kadar null girebilirsiniz
  select * from tedarikciler;


--ornek3 primary key
  
  create table personel(
  id char(5) PRIMARY KEY,
  isim varchar(50) UNIQUE,
  maas NUMBER(5) NOT NULL,
  ise_baslama date
   );
  
    INSERT INTO personel VALUES('10001', 'Ahmet Aslan',7000, '13-04-2018');
    INSERT INTO personel VALUES( '10001', 'Mehmet Yýlmaz' ,12000, '14-04-18');--hata alýr
    INSERT INTO personel VALUES('10003', '', 5000, '14-04-18');
    INSERT INTO personel VALUES('10004', 'Veli Han', 5000, '14-04-18');
    INSERT INTO personel VALUES('10005', 'Ahmet Aslan', 5000, '14-04-18'); --hata alýr
    INSERT INTO personel VALUES(NULL, 'Canan Yas', NULL, '12-04-19');-- null olmaz
    
    
    select * from personel;
    
    -------   -- ogrenciler3 tablosu olusturalim ve ogrenci_id 'yi PRIMARY KEY yapalim
    CREATE TABLE ogrenciler3
(
ogrenci_id char(4) PRIMARY KEY,
Isim_soyisim varchar2(50),
not_ort number(5,2), --100,00
kayit_tarihi date -- 14-01-2021
);
SELECT *
FROM ogrenciler3;
INSERT INTO ogrenciler3 VALUES ('1234', 'hasan yaman',75.70,'14-01-2020');
INSERT INTO ogrenciler3 VALUES (null, 'veli yaman',85.70,'14-01-2020'); -- id null olamaz
INSERT INTO ogrenciler3 VALUES ('1234', 'Ali Can',55.70,'14-06-2020'); -- id benzersiz olmalý, daha önceverilen id kullanýlamaz
INSERT INTO ogrenciler3 (isim_soyisim) VALUES ( 'Veli Cem'); -- id vermeden baþka þeyler vermeye geçemezsin, default null atar, buda primary ye uymaz
INSERT INTO ogrenciler3 (ogrenci_id) VALUES ( '5687');

create table calisanlar(
id char(5),
isim varchar(50) UNIQUE,
maas number(5) NOT NULL,
CONSTRAINT id_primary PRIMARY KEY(id)
);

    INSERT INTO calisanlar VALUES('10001', 'Ahmet Aslan',7000);
    INSERT INTO calisanlar VALUES( '10002', 'Mehmet Yýlmaz' ,12000);
    INSERT INTO calisanlar VALUES('10003', 'CAN', 5000);

SELECT * FROM calisanlar



create table adresler(
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(15),
CONSTRAINT id_foreign FOREIGN KEY(adres_id)REFERENCES calisanlar(id)

);

drop table adresler;
    INSERT INTO adresler VALUES('10001','Mutlu Sok', '40.Cad.','IST');
    INSERT INTO adresler VALUES('10001','Can Sok', '50.Cad.','Ankara');
    INSERT INTO adresler VALUES('10002','Aða Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','Aða Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','Aða Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('10004','Gel Sok', '60.Cad.','Van');

SELECT * FROM calisanlar;     
SELECT * FROM adresler;

DROP TABLE calisanlar;

DROP TABLE adresler;


--ogrenciler5 tablosunu oluþturun ve id, isim hanelerinin birleþimini primary key yapýn
  create table ogrenciler5(
  id char(4),
  isim varchar(20),
  not_ort number(5,2),
  kayit_tarihi date,
  CONSTRAINT ogrenciler5_primary PRIMARY KEY (id,isim)
   );


INSERT INTO ogrenciler5 VALUES (null,'Veli Cem',90.6,,'15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ID")
INSERT INTO ogrenciler5 VALUES (1234,null,90.6,'15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ISIM")
INSERT INTO ogrenciler5 VALUES (1234,'Ali Can',90.6,'15-05-2019'); -- PK= 1234Ali Can
INSERT INTO ogrenciler5 VALUES (1234,'Veli Cem',90.6,'15-05-2019'); -- PK=1234Veli Cem
INSERT INTO ogrenciler5 VALUES (1234,'Oli Can',90.6,'15-05-2019');

SELECT * FROM ogrenciler5;

--“tedarikciler4” isimli bir Tablo olusturun. Icinde “tedarikci_id”, “tedarikci_isim”, “iletisim_isim” field’lari olsun.
--“tedarikci_id” ve “tedarikci_isim” fieldlarini birlestirerek Primary Key olusturun.
--“urunler2” isminde baska bir tablo olusturun.Icinde “tedarikci_id” ve “urun_id” fieldlari olsun.
--“tedarikci_id” ve “urun_id” fieldlarini birlestirerek Foreign Key olusturun

create table tedarikciler4(
tedarikci_id char(4),
tedarikci_ismi varchar(20),
iletisim_ismi varchar(20),
CONSTRAINT tedarikciler4_pk PRIMARY KEY(tedarikci_id,tedarikci_ismi)
);

create table urunler2(
tedarikci_id char(4),
urun_id varchar(5),
CONSTRAINT urunler2_fk FOREIGN KEY (tedarikci_id,urun_id) REFERENCES tedarikciler4
);

CREATE TABLE sehirler2 (	
    alan_kodu CHAR(3 ),
	isim VARCHAR2(50),
	nufus NUMBER(8,0) CHECK (nufus>1000)
    );
    INSERT INTO sehirler2 VALUES ('312','Ankara',5750000);
    INSERT INTO sehirler2 VALUES ('232','izmir',375); -- ORA-02290: check constraint (HR.SYS_C007028) violated
    INSERT INTO sehirler2 VALUES ('232','izmir',3750000);
    INSERT INTO sehirler2 VALUES ('436','Maras',null);

SELECT * FROM sehirler2;









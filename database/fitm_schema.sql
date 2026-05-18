-- ============================================
-- FitM Veritabanı Şeması
-- phpMyAdmin → SQL sekmesi → yapıştır → Çalıştır
-- Kullanıcılar için: npm run seed komutunu çalıştır
-- ============================================

CREATE DATABASE IF NOT EXISTS fitm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE fitm;

-- ─── KULLANICILAR ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS kullanicilar (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ad_soyad        VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    sifre_hash      VARCHAR(255) NOT NULL,
    rol             ENUM('kullanici', 'antrenor', 'admin') DEFAULT 'kullanici',
    kisaltma        VARCHAR(4),
    seri_gun        INT DEFAULT 0,
    olusturuldu     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ─── ANTRENÖRLER ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS antrenorler (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    kullanici_id    INT NOT NULL UNIQUE,
    uzmanlik        VARCHAR(150),
    biyografi       TEXT,
    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(id) ON DELETE CASCADE
);

-- ─── SEANSLAR ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS seanslar (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    kullanici_id    INT NOT NULL,
    antrenor_id     INT NOT NULL,
    seans_tarihi    DATE NOT NULL,
    seans_saati     TIME NOT NULL,
    seans_turu      VARCHAR(100) NOT NULL,
    not_alani       TEXT,
    durum           ENUM('planlandı', 'tamamlandı', 'iptal') DEFAULT 'planlandı',
    olusturuldu     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(id) ON DELETE CASCADE,
    FOREIGN KEY (antrenor_id) REFERENCES antrenorler(id) ON DELETE CASCADE
);

-- ─── NOTLAR ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS notlar (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    gonderen_id     INT NOT NULL,
    alici_id        INT NOT NULL,
    icerik          TEXT NOT NULL,
    okundu          TINYINT(1) DEFAULT 0,
    olusturuldu     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (gonderen_id) REFERENCES kullanicilar(id) ON DELETE CASCADE,
    FOREIGN KEY (alici_id) REFERENCES kullanicilar(id) ON DELETE CASCADE
);

-- ─── EGZERSİZLER ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS egzersizler (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ad              VARCHAR(150) NOT NULL,
    kas_grubu       VARCHAR(100),
    aciklama        TEXT,
    ekleyen_id      INT,
    FOREIGN KEY (ekleyen_id) REFERENCES kullanicilar(id) ON DELETE SET NULL
);

-- ─── VÜCUT ÖLÇÜLERİ ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS vucut_olculeri (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    kullanici_id    INT NOT NULL,
    agirlik_kg      DECIMAL(5,2),
    yag_orani       DECIMAL(4,2),
    kas_kitlesi_kg  DECIMAL(5,2),
    bmi             DECIMAL(4,2),
    olcum_tarihi    DATE NOT NULL,
    olusturuldu     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kullanici_id) REFERENCES kullanicilar(id) ON DELETE CASCADE
);

-- ─── EGZERSİZ KÜTÜPHANESİ ÖRNEKLERİ ───────────────────────
INSERT IGNORE INTO egzersizler (ad, kas_grubu) VALUES
('Bench Press',    'Göğüs'),
('Omuz Press',     'Omuz'),
('Pull-up',        'Sırt'),
('Squat',          'Bacak'),
('Deadlift',       'Sırt & Bacak'),
('Biceps Curl',    'Biceps'),
('Triceps Dips',   'Triceps'),
('Koşu Bandı',     'Kardiyo'),
('Plank',          'Core'),
('Lunge',          'Bacak');

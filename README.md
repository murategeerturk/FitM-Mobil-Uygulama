# FitM — Kurulum

## Backend (her bilgisayarda bir kez)
1. XAMPP aç → MySQL başlat
2. phpMyAdmin → fitm_schema.sql içeriğini çalıştır
3. `cd backend` → `npm install` → `cp .env.example .env` → `npm run seed` → `npm run dev`

## Mobile
1. `cd mobile` → `npm install`
2. `services/api.ts` dosyasında `KENDI_IP_ADRESIM` değerini kendi IP'nle değiştir
   - Windows: `ipconfig` → IPv4 Address
3. `npx expo start --tunnel`
4. Telefonda Expo Go ile QR tara

## Giriş Bilgileri
- Email: ahmet@fitm.com / Şifre: Ahmet1234
- Email: erdem@fitm.com / Şifre: Erdem1234 (antrenör)

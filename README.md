# Note App (Clean Architecture + GetX)

## Overview
این پروژه یک اپلیکیشن مدیریت یادداشت ساده است که از معماری **Clean Architecture** استفاده می‌کند و **GetX** را برای مدیریت حالت و مسیریابی به کار می‌برد. ذخیره‌سازی محلی با استفاده از **GetStorage** انجام شده تا نیاز به تنظیم پایگاه‌داده بومی (مثل Hive یا SQLite) کاهش یابد.

## Features
- CRUD کامل برای یادداشت‌ها (Create/Read/Update/Delete)
- دسته‌بندی یادداشت‌ها
- وضعیت یادداشت (draft, completed)
- فیلتر بر اساس دسته و وضعیت
- پیاده‌سازی Clean Architecture (presentation, domain, data)
- تست‌های پایه (stubs) برای شروع

## Structure (خلاصه)
```
lib/
  core/
  data/
  domain/
  presentation/
  main.dart
test/
README.md
pubspec.yaml
```

## How to run
1. Flutter SDK را نصب کنید.
2. پروژه را در دستگاه محلی clone کنید یا فایل‌های این فولدر را در یک پروژه جدید قرار دهید.
3. وابستگی‌ها را نصب کنید:
```bash
flutter pub get
```
4. اپلیکیشن را اجرا کنید:
```bash
flutter run
```

> توجه: GetStorage در اولین اجرا نیاز دارد که `await GetStorage.init()` در `main()` فراخوانی شود. این در `main.dart` آماده شده است.

## Notes on architecture
- `domain/` شامل entities و repository interfaces و usecases است.
- `data/` شامل پیاده‌سازی repository (GetStorage-based) و mapper ها است.
- `presentation/` شامل GetX Controllers, Pages و Bindings است.

.

---
.

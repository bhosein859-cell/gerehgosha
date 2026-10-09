#!/usr/bin/env bash
# ساخت نسخه‌ی ویندوز گره‌گشا — اجرای خودکار در گیت‌هاب
# (بدون نیاز به دستور unzip؛ با ابزار خود ویندوز)
set -e

# ۱. باز کردن زیپ کد منبع با ابزار خود ویندوز
powershell -NoProfile -Command \
  "Expand-Archive -Path 'gerehgosha-source.zip' -DestinationPath '.' -Force"

# ۲. ساخت اسکلت ویندوز
flutter create --platforms=windows --org ir.bakhtiari --project-name gereh_gosha .

# ۳. وابستگی‌ها + آیکون (اگر آیکون نخواست ساخته شود، متوقف نشو)
flutter pub get
(dart run flutter_launcher_icons) || true

# ۴. ساخت نسخه‌ی انتشار
flutter build windows --release

# ۵. بسته‌بندی خروجی (زیپ قابل‌حمل)
mkdir -p dist
powershell -NoProfile -Command \
  "Compress-Archive -Path 'build\windows\x64\runner\Release\*' -DestinationPath 'dist\GerehGosha-1.0.0-Windows.zip' -Force"

echo "=================================="
echo " نسخه ویندوز گره‌گشا آماده شد ✅"
echo "=================================="

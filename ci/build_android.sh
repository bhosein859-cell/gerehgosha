#!/usr/bin/env bash
# ساخت فایل نصبی اندروید گره‌گشا — اجرای خودکار در گیت‌هاب
set -e

flutter create --platforms=android --org ir.bakhtiari --project-name gereh_gosha .

# نام فارسی اپ + مجوز میکروفون
M=android/app/src/main/AndroidManifest.xml
sed -i 's/android:label="gereh_gosha"/android:label="گره‌گشا"/' "$M"
grep -q RECORD_AUDIO "$M" || \
  sed -i 's|<application|<uses-permission android:name="android.permission.RECORD_AUDIO"/>\n    <application|' "$M"

flutter pub get
dart run flutter_launcher_icons
flutter build apk --release

mkdir -p dist
cp build/app/outputs/flutter-apk/app-release.apk dist/GerehGosha-1.0.0.apk
echo "✓ فایل نصبی اندروید آماده شد"

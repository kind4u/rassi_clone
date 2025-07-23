#!/bin/bash
cd /Users/parksihyoung/Documents/rassi_clone
echo "=== Flutter 설치 확인 ==="
flutter --version

echo -e "\n=== 사용 가능한 디바이스 목록 ==="
flutter devices

echo -e "\n=== Flutter Doctor 체크 ==="
flutter doctor

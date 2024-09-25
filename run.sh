#!/bin/bash

# Tạo file note # Tạo ra file readme.md
echo "chmod +x run.sh&./run.sh" > readme.md

# Tạo file requirements.txt và thêm các gói cần thiết
echo "flask" > requirements.txt
echo "requests" >> requirements.txt
echo "numpy" >> requirements.txt
echo "pandas" >> requirements.txt
echo "pytest" >> requirements.txt
echo "pytest-cov" >> requirements.txt
echo "albumentations" >> requirements.txt
echo "matplotlib" >> requirements.txt
echo "opencv-python" >> requirements.txt
echo "flask_session" >> requirements.txt
# echo "ultralytics" >> requirements.txt





# Tạo môi trường ảo
python3 -m venv env

# Kích hoạt môi trường ảo
source env/bin/activate

# Cài đặt các gói từ file requirements.txt
pip install -r requirements.txt

# Tạo gitignore
echo "env" >> .gitignore

# Tạo file .env
echo "" >> .env

# Tạo file run_report.sh
echo "pytest --cov=project" >> run_report.sh
echo "pytest --cov=src --cov-report=html" >> run_report.sh




# Tạo ra file package.json
echo '{ "name": "mtips5s_albumentation", "version": "1.0.0", "description": "chmod +x run.sh&./run.sh", "main": "index.js", "scripts": { "test": "echo \"Error: no test specified\" && exit 1" }, "author": "", "license": "ISC" }' >> package.json

# Tạo file app.py 
echo "" >> app.py

# Tạo folder 
mkdir templates
mkdir static
mkdir modules
mkdir routes


git init

git clone https://github.com/khuongsatou/mtips5s_cicd.git

mv mtips5s_cicd/* mtips5s_cicd/.* .
mv ComfyUI/* ComfyUI/.* .
rm -rf mtips5s_cicd
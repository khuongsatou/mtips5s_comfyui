FROM --platform=linux/amd64 python:3.9

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

# RUN apt-get update\
# && apt-get -y install tesseract-ocr && apt-get install ffmpeg libsm6 libxext6  -y\
# && apt-get install poppler-utils -y


# RUN export PATH=/user/local/bin:$PATH 
# RUN export TESSDATA_PREFIX=/usr/share/tesseract-ocr/5/tessdata/

COPY . .

CMD ["python", "app.py"]

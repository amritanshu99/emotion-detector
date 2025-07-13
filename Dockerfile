# ✅ Use compatible Python
FROM python:3.10

# ✅ Set working directory
WORKDIR /app

# ✅ Copy app files
COPY . .

# ✅ Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# ✅ Expose port
EXPOSE 10000

# ✅ Run the app using Gunicorn with threads
CMD ["gunicorn", "emotion_api:app", "--bind", "0.0.0.0:10000", "--workers", "1", "--threads", "4", "--timeout", "120"]

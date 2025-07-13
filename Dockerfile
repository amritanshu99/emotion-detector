# ✅ Use TensorFlow-compatible Python version
FROM python:3.10

# ✅ Set working directory
WORKDIR /app

# ✅ Copy project files
COPY . .

# ✅ Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# ✅ Expose the app port
EXPOSE 10000

# ✅ Start app with a threaded Gunicorn server (good for TensorFlow)
CMD ["gunicorn", "emotion_api:app", "--bind", "0.0.0.0:10000", "--worker-class=threaded", "--timeout", "120"]

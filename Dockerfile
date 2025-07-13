# ✅ Use a compatible Python version for TensorFlow
FROM python:3.10

# ✅ Set working directory
WORKDIR /app

# ✅ Copy all files to container
COPY . .

# ✅ Upgrade pip and install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# ✅ Expose default web port for Render
EXPOSE 10000

# ✅ Run the Flask app with Gunicorn (adjust as needed)
CMD ["gunicorn", "emotion_api:app", "--bind", "0.0.0.0:10000"]

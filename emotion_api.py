from flask import Flask, request, jsonify
import numpy as np
import pickle
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences

# ✅ Create the Flask app
app = Flask(__name__)

# ✅ Load trained model
model = load_model("emotion_model.h5")

# ✅ Load tokenizer
with open("tokenizer.pkl", "rb") as f:
    tokenizer = pickle.load(f)

# ✅ Load label names (e.g., ['sadness', 'joy', ...])
with open("label_names.pkl", "rb") as f:
    label_names = pickle.load(f)

# ✅ Define maximum sequence length used during training
max_len = 50

# ✅ Define the prediction route
@app.route("/predict", methods=["POST"])
def predict():
    # 📥 Get JSON data
    data = request.get_json()
    if not data or "text" not in data:
        return jsonify({"error": "Missing 'text' field"}), 400

    text = data["text"]

    # 🧠 Preprocess: Tokenize + pad the input
    sequence = tokenizer.texts_to_sequences([text])
    padded = pad_sequences(sequence, maxlen=max_len)

    # 🔮 Make prediction
    pred = model.predict(padded)[0]
    emotion = label_names[np.argmax(pred)]
    confidence = float(np.max(pred))

    # ✅ Return result as JSON
    return jsonify({
        "text": text,
        "emotion": emotion,
        "confidence": round(confidence, 2)
    })

# ✅ Run the app
# For Gunicorn: No need to run manually
# For local testing: this block will work
if __name__ == "__main__":
    print("✅ Running Flask dev server...")
    app.run(host="0.0.0.0", port=5000)

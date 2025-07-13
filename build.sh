#!/bin/bash
echo "Using Python version from runtime.txt"
python --version
pip install --upgrade pip
pip install -r requirements.txt

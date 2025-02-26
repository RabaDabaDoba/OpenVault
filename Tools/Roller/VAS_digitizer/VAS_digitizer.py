"""
VAS Scale Digitization Script
--------------------------------
Description:
This script processes an image of a Visual Analog Scale (VAS) to detect the position of a marked "X" 
and convert it into a numerical value (0–10 scale). The script is designed to work with a **horizontal** 
VAS scale but currently does not correctly detect the "X" when the scale is **vertical**.

Known Issues:
- If the VAS scale is **rotated vertically**, the script does not find the "X" correctly.
- The red line (detected VAS scale) is sometimes misplaced or misaligned.
- Detection of the "X" is inconsistent, especially if other marks or noise exist in the image.
- Needs improvements to handle different image resolutions and contrast variations.

Future Improvements:
- Implement **automatic rotation detection** to handle both horizontal and vertical VAS scales.
- Improve **image preprocessing** (adaptive thresholding, noise reduction).
- Use **contour analysis** or **machine learning** for better "X" detection.
- Add a **confidence score** to validate the detected position.

Usage:
Ensure OpenCV (`cv2`) and NumPy (`numpy`) are installed:
    pip install opencv-python numpy

Run the script with an image file:
    python VAS_digitizer.py path/to/image.jpg

Author: Robin Dahlkvist
Date: 2025-02-26
"""

import cv2
import numpy as np
import matplotlib.pyplot as plt

def process_vas_image(image_path):
    # Load image in grayscale
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

    # Apply Gaussian blur to reduce noise
    blurred = cv2.GaussianBlur(image, (5, 5), 0)

    # Detect edges using Canny edge detection
    edges = cv2.Canny(blurred, 50, 150)

    # Find contours
    contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Sort contours by area and assume the largest one is the scale line
    contours = sorted(contours, key=cv2.contourArea, reverse=True)

    # Get bounding box of the scale
    x, y, w, h = cv2.boundingRect(contours[0])
    
    # Extract the region of interest (ROI) for further processing
    roi = image[y:y+h, x:x+w]

    # Convert image to binary (Thresholding)
    _, thresh = cv2.threshold(roi, 128, 255, cv2.THRESH_BINARY_INV)

    # Find marks (assuming they are darker than the background)
    marks_contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    if not marks_contours:
        print("No marks detected!")
        return None

    # Assume the leftmost mark is the user's selection
    mark_x = min([cv2.boundingRect(cnt)[0] for cnt in marks_contours])

    # Normalize position to a 0-100 scale
    vas_score = (mark_x / w) * 100

    # Display result
    plt.figure(figsize=(8, 4))
    plt.imshow(image, cmap='gray')
    plt.axvline(x + mark_x, color='r', linestyle='--', label=f"VAS Score: {vas_score:.1f}")
    plt.legend()
    plt.show()

    return round(vas_score, 1)

# Example usage
image_path = "vas_scale.jpg"  # Change to your actual image path
vas_score = process_vas_image(image_path)
print(f"VAS Score: {vas_score}")

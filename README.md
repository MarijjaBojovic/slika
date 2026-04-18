# 🖼️ Digital Image Processing: Computer Vision & Image Enhancement

This repository contains two major projects developed in **MATLAB**, covering fundamental and advanced techniques in **Digital Image Processing (DIP)**. The projects range from high-level computer vision tasks like object recognition to low-level image restoration using custom-built filtering algorithms.

---

## 📂 Project 1: Shape Analysis & Object Recognition
This project focuses on **image segmentation** and **feature extraction** to identify and compare objects (specifically letters) based on their geometric properties.

### Key Features:
* **Preprocessing:** Noise suppression using Gaussian filtering to prepare the image for segmentation.
* **Segmentation:** Global thresholding to isolate characters from the background.
* **Connected Component Labeling:** Identifying and indexing individual regions using `bwlabel`.
* **Feature Extraction:** Utilizing `regionprops` to calculate the **Perimeter** and **Centroid** of each letter.
* **Similarity Algorithm:** A custom logic that compares the perimeters of all detected shapes to find the two most geometrically similar objects in the image.

---

## 📂 Project 2: Image Restoration & Custom High-Boost Filtering
A deep technical dive into image enhancement where core filtering functions were **implemented from scratch** to demonstrate a low-level understanding of kernel operations.

### Custom Implementations:
Unlike standard toolbox functions, this project uses manually written logic for:
* `my_imfilter`: Manual convolution/correlation logic with symmetric padding support.
* `my_median_filter`: A non-linear filter designed to remove salt-and-pepper noise.
* `my_gaussian_filter`: Smoothing and blurring using a custom-generated Gaussian kernel.
* `my_laplacian`: An edge-detection operator used for sharpening.

### High-Boost Sharpening:
The project implements the **High-Boost Filtering** technique: 
$$B = A \cdot I - \text{Laplacian}(I)$$
It includes a comparative analysis of different boost factors ($A$) and evaluates how combining Median and Gaussian pre-filtering prevents noise amplification during the sharpening process.

---

## 🛠 Tech Stack
* **Language:** MATLAB
* **Core Concepts:** Spatial Filtering, Frequency Domain Analysis, Morphological Operations, Segmentation, Feature Extraction.

---

## 📊 Results
The final output demonstrates the ability to restore highly noisy images and extract meaningful data from visual inputs, transforming raw pixels into actionable geometric information.

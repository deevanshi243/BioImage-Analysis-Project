# Install BiocManager if you don't have it
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Install EBImage and other useful packages
BiocManager::install("EBImage")
install.packages("tiff") # Good for reading TIFF files
install.packages("dplyr") # For data manipulation later

# Load the libraries for our session
library(EBImage)
library(tiff)
library(dplyr)

# --- Step 1: Load Image ---

# Set the path to your image file
# IMPORTANT: Replace "path/to/your/stitched_image.tif" with your actual file path
image_path <- "C:/Users/deevanshi.walia/Desktop/Ooc/Seeding1_10Mio_Div1_Composite_RGB.tif"

# Read the image using the readImage function from EBImage
# This can handle TIFF, PNG, JPEG etc.
img <- readImage(image_path)

# --- Inspect the Image ---

# Print the image object to see its properties
print(img) 
display(img, method = "browser")
# This will tell you:
# - dimensions (width, height, channels)
# - color mode (Grayscale or Color)
# - storage mode (e.g., "double" for floating point numbers)

# If you have a multi-channel image (e.g., R, G, B channels)
# and your cells are in, say, the green channel (channel 2),
# you need to select just that channel for analysis.
# The dimensions are typically [width, height, channel]
# If img is color, it will have 3 channels. Let's assume cells are in green (2nd channel)
# If your image is already grayscale, you can skip this.
if (colorMode(img) == "Color") {
  # This extracts the green channel. Adjust if your cells are in red (1) or blue (3).
  img_gray <- channel(img, "green") 
} else {
  # If it's already grayscale, just use it as is
  img_gray <- img
}

# Display the single-channel image
display(img_gray, method = "browser")
print(img_gray) 

##########MIP
# Create the Maximum Intensity Projection
# This collapses the 3 frames into a single 2D image
img_gray_MIP <- zproject(img, method = "max")

# --- Now, verify the result ---
print(img_gray_MIP)
# The output should now show a 2D grayscale image:
# Image 
#   colorMode    : Grayscale 
#   ...
#   dim          : 2387 1193   <-- Confirms it is now 2D

# Display the MIP to see the result. It should look sharp and clear.
display(img_gray_MIP, method = "browser", title = "Maximum Intensity Projection")

# You can now proceed with the rest of the pipeline using this new 'img_gray'
# --- 2. Pre-processing ---
# img_blurred <- gblur(img_gray, sigma = 1.5)
# ... etc.

################MIP without ZProject but using apply()
# -------------------------------------------------------------
# AML CELL SEGMENTATION PIPELINE - REVISED & WORKING
# -------------------------------------------------------------

# Step 0: Load libraries
library(EBImage)
library(dplyr)

# --- 1. Load Image and Create Maximum Intensity Projection (WORKAROUND) ---

# We manually perform the Maximum Intensity Projection.
# This tells R to go through the image data array (imageData(img)),
# keep the first two dimensions (width and height), and apply the 'max' function
# across the third dimension (the z-stack).
img_gray <- Image(apply(imageData(img), c(1, 2), max))

# --- Now, verify the result ---
print(img_gray)
display(img_gray, method = "browser", title = "Maximum Intensity Projection (Manual)")

#################################PROCEED TO PRE PROCESSING!!!!! :D



################
# --- NEW Step 1a: Inspect Each Channel/Frame ---

# Display the first frame
display(img, frame = 1, method = "browser", title = "Frame 1")

# Display the second frame
display(img, frame = 2, method = "browser", title = "Frame 2")

# Display the third frame
display(img, frame = 3, method = "browser", title = "Frame 3")

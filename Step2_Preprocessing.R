# --- Step 2: Pre-processing ---

# 1. Noise Reduction: Gaussian Blur
# We apply a gentle blur to smooth out random pixel noise.
# The 'sigma' value controls the amount of blur. Start with a small value.
img_blurred <- gblur(img_gray, sigma = 1.5)

# 2. Background Subtraction
# The gel matrix creates a low-frequency, uneven background. We can remove this.
# A "rolling ball" algorithm (morphological opening) is excellent for this.
# It's like rolling a ball under the intensity surface of the image.
# The 'kern.size' should be larger than the cells you want to detect.
# Let's estimate a cell is about 20 pixels wide, so we use a kernel larger than that.
kern <- makeBrush(size = 41, shape = 'disc') # A disc-shaped kernel
img_background <- opening(img_blurred, kern) # Calculate the background
img_processed <- img_blurred - img_background # Subtract the background

# Let's see the difference!
# Display the original, the calculated background, and the processed image
display(img_gray, title = "Original Grayscale")
display(img_background, title = "Calculated Background")
display(img_processed, title = "Background Subtracted")



# We need EBImage for this task.
# Assuming the user has a working version or we can use the manual workaround.
# For simplicity and robustness, I'll rely on base R and EBImage for plotting.

library(EBImage)

# Load the image the user uploaded, which is the result of pre-processing.
img_processed <- readImage("input_file_0.png")

# R's hist() function is perfect for this. We'll plot the distribution of pixel values.
# The 'imageData' extracts the numerical matrix from the image object.
hist(imageData(img_processed), 
     main = "Histogram of Processed Image",
     xlab = "Pixel Intensity (0=black, 1=white)",
     breaks = 100) # Use more breaks for a detailed view


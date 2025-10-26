# --- Step 3: Enhancement ---

# 1. Normalize the image
# This scales the pixel intensity values to be between 0 and 1.
# It's good practice for many downstream functions.
img_norm <- normalize(img_processed)

# 2. Histogram Equalization (as you requested)
# This redistributes pixel intensities to stretch the contrast.
# It can be very effective but sometimes amplifies leftover noise.
# Let's create an equalized version to see if it helps.
img_equalized <- equalize(img_norm)

# Compare the normalized vs. the equalized image.
# For segmentation, the normalized image (img_norm) is often cleaner.
# We will proceed with img_norm, but you can try img_equalized if it looks better.
display(img_norm, title = "Normalized")
display(img_equalized, title = "Equalized (for comparison)")

# Let's choose the image we will use for segmentation
img_for_seg <- img_norm


# --- Step 4: Segmentation ---

# **Method: Marker-Controlled Watershed Segmentation**
# This is a 3-step process:
# 1. Create a binary mask of the cells (foreground).
# 2. Identify unique "seeds" or "markers" for each cell.
# 3. Use the watershed algorithm to "grow" from these seeds to fill each cell.

# Step 4a: Create a Binary Mask using Thresholding
# We use an automatic thresholding method (Otsu's method) to separate
# bright cells from the dark background.
threshold <- otsu(img_for_seg)
mask <- img_for_seg > threshold

display(mask, title = "Binary Cell Mask")

# Step 4b: Identify Cell "Seeds"
# We need one marker inside each cell. We can find these by calculating the
# "distance map" of the mask and finding the local peaks.
dist_map <- distmap(mask)
# The watershed function needs seeds marking the centers of the cells.
# We will use the peaks in the distance map as our seeds.
# The 'tolerance' helps find peaks, 'ext' sets the minimum size of a peak area.
seeds <- watershed(dist_map, tolerance = 1, ext = 1) 

display(colorLabels(seeds), title = "Cell Seeds")

# Step 4c: Run the Watershed Algorithm
# This algorithm uses the seeds and floods the image landscape until basins meet.
# This separates touching objects.
# We use the intensity of the ORIGINAL pre-processed image to define the boundaries.
cell_labels <- watershed(dist_map, tolerance = 2, ext = 1)

# The result 'cell_labels' is an image where background is 0 and each
# detected cell is a unique integer (1, 2, 3, ...).
display(colorLabels(cell_labels), title = "Watershed Segmentation Result")



#######################222222
# --- Step 4: Segmentation (using your 'img_processed' object) ---
# Your img_processed is perfect. Let's find a threshold.
# Otsu's method will automatically find the valley between your background and signal peaks.
threshold <- otsu(img_processed)
mask <- img_processed > threshold

# Let's see the result of this crucial step
display(mask, title = "Binary Cell Mask")

# --- Step 5 & 6: Watershed and Analysis ---
# Looking at your image, the cells are small and distinct.
# We might not even need watershed if they are not touching, but it's a robust method.
dist_map <- distmap(mask)
seeds <- watershed(dist_map, tolerance = 1, ext = 1) 
cell_labels <- watershed(img_processed, seeds = seeds)

# --- CRITICAL: Filtering by Size ---
# Your image has big blobs and small cells. We MUST filter these.
# Let's remove tiny noise and the huge blobs.
# You will need to EXPERIMENT with these values.
min_cell_area <- 20   # pixels
max_cell_area <- 500  # pixels

final_cells <- bwlabel(mask) %>%
  watershed(tolerance=1, ext=1) %>%
  filterObjects(minSize = min_cell_area, maxSize = max_cell_area)


# Count and analyze the final, filtered cells
num_cells <- max(final_cells)
cat("Found", num_cells, "cells after filtering.\n")

# --- Final Visualization ---
# Let's use a bright color like "cyan" to see the overlay on the dark image
overlay_image <- paintObjects(final_cells, img_gray, col = "cyan")
display(overlay_image, title = "Final Segmentation Result")
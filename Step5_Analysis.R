# --- Step 5: Analysis ---

# 1. Filter out very small objects
# Sometimes segmentation creates tiny noise objects. We can remove them by area.
# The 'computeFeatures' functions calculate properties for each labeled object.
shape_features <- computeFeatures.shape(cell_labels)

# Let's say we want to remove any object smaller than 50 pixels in area
min_area <- 50
# Get the IDs of the objects to keep
objects_to_keep <- as.numeric(rownames(shape_features)[shape_features[,'s.area'] > min_area])

# The 'rmObjects' function removes objects from a labeled image based on their ID.
# First, find all objects, then determine which to remove.
all_objects <- as.numeric(rownames(shape_features))
objects_to_remove <- setdiff(all_objects, objects_to_keep)

# Create the final, cleaned-up segmentation mask
final_cells <- rmObjects(cell_labels, objects_to_remove)

display(colorLabels(final_cells), title = "Final Cleaned Segmentation")

# 2. Count the cells
num_cells <- max(final_cells)
cat("Found", num_cells, "cells after filtering.\n")

# 3. Compute detailed features for the final cells
# We can get shape features (area, perimeter, etc.)
final_shape_features <- computeFeatures.shape(final_cells)

# We can also get intensity features (mean intensity, max, etc.)
# We measure these on the original processed image (img_for_seg) using the final_cells mask.
final_intensity_features <- computeFeatures.moment(final_cells, img_for_seg)

# Combine them into a single data frame for easy analysis
# Add an 'id' column for joining
final_shape_features_df <- as.data.frame(final_shape_features) %>% mutate(id = as.numeric(rownames(.)))
final_intensity_features_df <- as.data.frame(final_intensity_features) %>% mutate(id = as.numeric(rownames(.)))

# Join them into a final results table
results_df <- full_join(final_shape_features_df, final_intensity_features_df, by = "id")

# View the first few rows of your results
head(results_df)

# Save the results to a CSV file
write.csv(results_df, "cell_analysis_results.csv", row.names = FALSE)


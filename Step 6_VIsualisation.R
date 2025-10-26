# --- Step 6: Visualization ---

# Create an overlay image showing the outlines of the detected cells
# We'll draw yellow outlines on the original grayscale image
overlay_image <- paintObjects(final_cells, img_for_seg, col = "red")

display(overlay_image, title = "Segmentation Overlay", method = "browser")

# Save the final overlay image
# It's good practice to save in a lossless format like PNG or TIFF
writeImage(overlay_image, "segmentation_overlay.png")

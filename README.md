# BioImage-Analysis-Project

Need:
Large number of cells makes manual counting impractical and prone to bias.
Image contains multiple channels (fluorescence and brightfield).
Significant background haze and extremely bright artifacts.

# Aim: A pipeline in R to accurately count and characterize cells.
-> Raw Image 
-> Isolate & Crop 
-> Pre-process 
-> Segment 
-> Filter & Analyse 
-> Quantitative Data

In the results: 
s. for Shape: These are geometric measurements based purely on the object's outline (its binary mask). They do not consider pixel intensity at all.
m. for Moment: These are measurements based on the distribution of pixel intensities within the object. They tell you about the object's center of mass, orientation, and elongation based on where the bright pixels are.



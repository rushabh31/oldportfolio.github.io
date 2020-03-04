path <- file.path("/home/rupatel/working_dir/projects/website/img/hexstickers")
list.files(path)
library(magick)
library(purrr)

sticker_files <- list.files(path)
stickers <- file.path(path, sticker_files) %>% 
  map(function(path){
    switch(tools::file_ext(path),
           svg = image_read_svg(path),
           pdf = image_read_pdf(path),
           image_read(path))
  }) %>%
  map(image_transparent, "white") %>%
  map(image_trim) %>%
  set_names(sticker_files)


# Desired sticker resolution in pixels
sticker_width <- 121

# Scale all stickers to the desired pixel width
stickers <- stickers %>%
  map(image_scale, sticker_width)

# Identify low resolution stickers
stickers %>%
  map_lgl(~ with(image_info(.x),
                 width < (sticker_width-1)/2 && format != "svg")
  )

# Identify incorrect shapes / proportions (tolerance of +-2 height)
stickers %>%
  map_lgl(~ with(image_info(.x),
                 height < (median(height)-2) | height > (median(height) + 2))
  )
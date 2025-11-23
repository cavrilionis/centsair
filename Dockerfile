# Use the rocker/shiny image as a base
FROM rocker/shiny:latest

# Install R package dependencies (list all packages your app uses)
RUN R -e "install.packages(c('shiny', 'shinythemes', 'shinyjs', 'dplyr'), repos = 'https://cran.rstudio.com/')"

# Copy the app files (ui.R, server.R, plus any data/resources) 
# into the container's default app directory
COPY . /srv/shiny-server/

# Set Shiny options to run on host 0.0.0.0 and port 3838 (Shiny's default)
# This is crucial for deployment platforms like Render.com
RUN echo "options(shiny.port = 3838, shiny.host = '0.0.0.0')" > /usr/local/lib/R/etc/Rprofile.site

# Expose the default Shiny port
EXPOSE 3838
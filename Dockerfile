# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

MAINTAINER Wei Dong "dongw26@mail2.sysu.edu.cn"

# Install system dependency libraries
RUN apt-get update && apt-get install -y \
            libxml2-dev \
            libudunits2-dev \
            libssh2-1-dev \
            libcurl4-openssl-dev \
            libsasl2-dev \
            libv8-dev

# Install needed R packages
RUN R -e "install.packages(c('shinydashboard', 'ggplot2', 'DT', 'UpSetR'), dependencies = TRUE, repo='https://mirrors.tuna.tsinghua.edu.cn/CRAN/')"

# Copy the app to the image
COPY app /srv/shiny-server/app

# Make all app files readable (solves issue when dev in Windows, but building in Ubuntu)
RUN chmod -R 755 /srv/shiny-server/

# Expose port on Docker container
EXPOSE 3838

# Run shiny app
# CMD ["/usr/bin/shiny-server.sh"]
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app', host='0.0.0.0', port=3838)"]

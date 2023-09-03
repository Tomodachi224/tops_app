FROM r-base

# Install Ubuntu packages
RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev \
    libssl-dev

# Download and install ShinyServer (latest version)
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb


# Install R packages that are required
RUN R -e "install.packages(c('data.table', 'dplyr', 'DT', 'feather', 'forcats', 'ggplot2', 'ggthemes', 'glue', 'leaflet', 'lubridate', 'magrittr', 'markdown', 'plotly', 'plyr', 'qmap', 'radarchart', 'rclipboard', 'readr', 'readxl', 'rlang', 'Rmisc', 'scales', 'shiny', 'shinyalert', 'shinyBS', 'shinycssloaders', 'shinyjs', 'shinythemes', 'shinyWidgets', 'sodium', 'sqldf', 'stringi', 'stringr', 'timevis', 'V8', 'wordcloud2', 'XLConnect', 'XLConnectJars'), repos='http://cran.rstudio.com/')"


# Copy configuration files into the Docker image
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY ./ /srv/shiny-server/

# Make the ShinyApp available at port 80
EXPOSE 80

# Copy further configuration files into the Docker image
COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
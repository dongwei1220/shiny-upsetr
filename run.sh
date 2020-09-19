#/bin/bash

# build the image
docker build -t upsetr .

# run the container
docker run --rm -p 3838:3838 upsetr

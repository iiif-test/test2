#!/bin/bash

convertImages() {
    local version="$1"
    for filename in "$UPLOAD_DIR/$version"/*;
    do
        if [ -f "$filename" ]; then
            echo "Found image $filename"
            basename=$(basename "$filename")
            basename="${basename%.*}"
            if [ ! -d "$IIIF_IMAGE_DIR/$basename" ]; then
                java -jar iiif-tiler.jar -identifier "https://$USER.github.io/$PROJECT/images" -version "$version" -output images/ $filename
            else
                echo "Image already exists: $IIIF_IMAGE_DIR/$basename"
            fi
        fi
    done
}


if [ ! -e "iiif-tiler.jar" ]; then
    echo "Downloading iiif-tiler"
    curl -LO "https://github.com/glenrobson/iiif-tiler/releases/latest/download/iiif-tiler.jar"
else
    echo "Found local iiif-tiler"    
fi    

IIIF_IMAGE_DIR="images"

UPLOAD_DIR="images/uploads"

convertImages 2
convertImages 3
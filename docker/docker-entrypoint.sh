#!/bin/bash
set -ex

case "$C" in
    "init")
        download()
        ;;
    "upload")
        upload()
        ;;
    "t-upper")
        uppper()
        ;;
    "t-lower")
        lower()
        ;;
    *)
        echo "Error: unknown action"
        ;;
esac


download () {
    echo "Downloading ${INPUT_FILE_URI}"
    if [[ $INPUT_FILE_URI == s3* ]]; then
        echo "Using awscli"
        aws s3 cp ${INPUT_FILE_URI} /data/input
    fi
    if [[ $INPUT_FILE_URI == gs* ]]; then
        echo "Using gsutil"
        gsutil cp ${INPUT_FILE_URI} /data/input
    fi
}

upload () {
    echo "Uploading results"
    if [[ $INPUT_FILE_URI == s3* ]]; then
        echo "Using awscli"
        aws s3 cp /data/output ${INPUT_FILE_URI}-output
    fi
    if [[ $INPUT_FILE_URI == gs* ]]; then
        echo "Using gsutil"
        gsutil cp /data/output ${INPUT_FILE_URI}-output
    fi
}

upper () {
    cat /data/input | tr [:lower:] [:upper:] > /data/output
}

lower () {
    cat /data/input | tr [:upper:] [:lower:] > /data/output
}

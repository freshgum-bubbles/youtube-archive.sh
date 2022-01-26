#!/bin/bash

COMMAND="youtube-dl"

# If yt-dlp exists, automatically upgrade to it.
# It includes several improvements (such as fixing the 70 Kbps download cap) that make it a
# lot better to use compared to the traditional youtube-dl.
if command -v "yt-dlp" &> /dev/null
then
        COMMAND="yt-dlp"
fi

download () {
        local directory="/home/freshgum/YouTube Archives/$1"
        mkdir -p "$directory"
        pushd "$directory"
        
        # Finally, download the channel from YouTube.
        $COMMAND --playlist-reverse \
        -o '%(playlist_index)s - %(title)s.%(ext)s' \
        --write-annotations \
        --download-archive .archive \
        --add-metadata \
        --write-info-json \
        --write-thumbnail -f bestvideo[ext=vp9]+bestaudio[ext=opus]/bestvideo+bestaudio \
        --merge-output-format mkv \
        --all-subs \
        --embed-subs \
        -i \
        --embed-thumbnail \
        --http-chunk-size 10M \
        "https://youtube.com/$2"
        popd
}

download "Jim Can't Swim" c/JCSCriminalPsychology
download "PhotonicInduction" user/Photonvids

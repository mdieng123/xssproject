#!/bin/bash

# Prompt user for URL
echo "Enter the URL of the website to test: "
read url

# Use curl to fetch the website and store the response in a variable
response=$(curl -s $url)

# Define an array of common XSS attack strings
xss_attacks=(
    "<script>"
    "alert("
    "onmouseover="
    "<svg onload="
    "<img src="
    "<a href="
    "<frame src="
    "<iframe src="
)

# Initialize a flag to track whether an XSS vulnerability was detected
xss_detected=false

# Loop through the XSS attack strings and check if any of them are present in the website's response
for attack in "${xss_attacks[@]}"; do
    if [[ $response == *"$attack"* ]]; then
        xss_detected=true
        break
    fi
done

# If an XSS vulnerability was detected, display a warning message
if $xss_detected; then
    echo "WARNING: XSS vulnerability detected!"
else
    echo "No XSS vulnerabilities detected."
fi

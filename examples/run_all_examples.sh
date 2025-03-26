#!/bin/bash

for file in *.rb; do
    if [[ "$file" != "client.rb" ]]; then
        ruby "$file" > "${file%.rb}.txt" 2>&1
    fi
done
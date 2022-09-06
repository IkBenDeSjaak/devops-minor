#!/bin/bash

echo "What's the weather?"
read weather

case $weather in
    sunny | warm ) echo "Nice! It's $weather!"
    ;;
    cloudy | cool ) echo "Not bad, it's $weather."
    ;;
    rainy | cold ) echo "Bad! It's $weather!"
    ;;
    * ) echo "I don't know!"
    ;;
esac

exit 0
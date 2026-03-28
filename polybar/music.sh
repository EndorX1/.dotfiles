#!/bin/bash

title=$(playerctl metadata title)
artist=$(playerctl metadata artist)

notitle="Play Something"
noartist="No Artist"

[ "$title" != "$notitle" ] && [ "$title" != "$notitle" ] && echo $title | sed 's/\(.\{25\}\).*/\1.../'

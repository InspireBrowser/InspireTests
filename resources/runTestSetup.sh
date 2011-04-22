#!/bin/bash

./downloadResources.sh

vlc -I dummy --vlm-conf TestSetup.vlm --rtsp-host 0.0.0.0:5554

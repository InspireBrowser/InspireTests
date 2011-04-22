#!/bin/bash

# Batch file to download the video files for the tests

BASE="http://www.inspirebrowser.org/tests/resources/"
LOCATION="../webroot/resources/"

for i in big_buck_bunny_480p_h264.mov elephantsdream-480-h264-st-aac.mov; do
	FILE_PATH="${LOCATION}${i}"
	echo -n "Check for ${FILE_PATH}..."
	if [ ! -e $FILE_PATH ]; then
		echo " not found. Downloading!"
		echo ""
		which wgeta >> /dev/null 2>&1
		if [ $? == 0 ]; then
			command="wget -O ${FILE_PATH} ${BASE}${i}"
		else
			which curl >> /dev/null 2>&1
			if [ $? == 0 ]; then
				command="curl -L ${BASE}${i} -o ${FILE_PATH}"
			else
				echo ""
				echo "**************************** ERROR ***************************************"
				echo "*   Cannot find wget or curl to download the resources                   *"
				echo "**************************************************************************"
				echo ""
				exit 1;
			fi
		fi

		$command
		if [ $? != 0 ]; then
			echo ""
			echo "**************************** ERROR ***************************************"
			echo "*   Error downloading %FILE%.                                    *"
			echo "**************************************************************************"
			echo ""
			exit 1;
		else
			echo ""
			echo "${i} Downloaded"
		fi
	else
		echo " found!"
	fi
done

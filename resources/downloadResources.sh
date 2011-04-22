#!/bin/bash

# Batch file to download the video files for the tests

BASE="http://www.inspirebrowser.org/tests/resources/"

for i in big_buck_bunny_480p_h264.mov elephantsdream-480-h264-st-aac.mov; do
	echo -n "Check for ${i}..."
	if [ ! -e $i ]; then
		echo " not found. Downloading!"
		echo ""
		which wget >> /dev/null 2>&1
		if [ $? == 0 ]; then
			command="wget ${BASE}${i}"
		else
			which curl >> /dev/null 2>&1
			if [ $? == 0 ]; then
				command="curl -OL ${BASE}${i}"
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

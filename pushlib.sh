#!/bin/sh

#variables
lib=/system/lib
lib64=/system/lib64
home=`pwd`
stock=$home/stock/system
port=$home/port/system
back=$home/back/system
zip=$home/files/zip

# Push_lib_utility
clear
echo
echo "--------------------"
echo "| Push Lib Utility |"
echo "--------------------"
echo
echo "Enter file name"
echo
read file
clear
while true
do
    clear
    echo
    echo "--------------------"
    echo "| Push Lib Utility |"
    echo "--------------------"
    echo
    echo "1. Push lib"
    echo "2. Revert Changes"
    echo "3. Folders"
    echo "4. Quit"
    echo
    read c
    if [ $c = 1 ] ; then
        clear
	echo
	echo "Pushing $file"
	adb remount
	adb pull $lib/$file $back/lib
	adb pull $lib64/$file $back/lib64
	adb push $stock/lib/$file $lib
	adb push $stock/lib64/$file $lib64
	echo "Pushed succesfully"
	echo
	echo "Do you wan't to reboot [0/1]"
	echo
	read d
	if [ $d = 1 ] ; then
	    echo
	    echo "Rebooting"
	    echo
	    adb reboot
	    echo "Rebooted"
	    echo
	    sleep .2
	fi
    elif [ $c = 2 ] ; then
	while true
	do
	    clear
	    echo
	    echo "------------------"
	    echo "| Revert Changes |"
	    echo "------------------"
	    echo
	    echo "1. Push from Port"
	    echo "2. Push from Backup"
	    echo "3. Make a zip"
	    echo "4. Go back"
	    echo
	    read d
	    if [ $d = 1 ] ; then
	        clear
	        echo
	        echo "Pushing from port folder"
	        echo
		adb remount
		adb push $port/lib/$file $lib
		adb push $port/lib64/$file $lib64
	        echo "Done"
	        echo
		clear
		echo
		echo "Do you wan't to reboot [0/1]"
		echo
		read f
		if [ $f = 1 ] ; then
		    clear
		    echo
		    echo "Rebooting"
		    echo
		    adb reboot
		    echo "Done"
		    echo
		    sleep .2
		fi
	    elif [ $d = 2 ] ; then
                clear
                echo
                echo "Pushing from backup folder"
                echo
		adb remount
		adb push $back/lib/$file $lib
		adb push $back/lib64/$file $lib64
                echo "Done"
                echo
                clear
                echo
                echo "Do you wan't to reboot [0/1]"
                echo
                read f
                if [ $f = 1 ] ; then
                    clear
                    echo
                    echo "Rebooting"
                    echo
		    adb reboot
                    echo "Done"
                    echo
		    sleep .2
                fi
	    elif [ $d = 3 ] ; then
		while true
		do
		    clear
		    echo
		    echo "-----------------"
		    echo "| Zip to revert |"
		    echo "-----------------"
		    echo
		    echo "1. zip from port"
		    echo "2. Zip from Backup"
		    echo "3. Go back"
		    echo
		    read g
		    if [ $g = 1 ] ; then
			clear
			echo
			echo "Coping files"
			echo
			rm $zip/*
			cp $port/lib/$file $zip
			cp $port/lib64/$file $zip
			cp $home/files/META-INF $zip
			echo
			echo "zipping files"
			echo
			zip -rm Revert.zip $zip/*
			echo "done"
			echo
		    elif [ $g = 2 ] ; then
                        clear
                        echo
                        echo "Coping files"
                        echo
			rm $zip/*
			cp $back/lib/$file $zip
			cp $back/lib64/$file $zip
			cp $home/files/META-INF $zip
			echo
			echo "zipping files"
			echo
			mkdir -p
			zip -rm Revert.zip $zip/*
                        echo "done"
                        echo
		    elif [ $g = 3 ] ; then
			break
		    else
			echo
			"choose something"
		    fi
		done
	    elif [ $d = 4 ] ; then
		break
	    else
		echo
		echo "choose something"
	    fi
	done
   elif [ $c = 3 ] ; then
	while true
	do
	    clear
	    echo
	    echo "-----------"
	    echo "| Folders |"
	    echo "-----------"
	    echo
	    echo "1. Check folders"
	    echo "2. Clean folders"
	    echo "3. Go back"
	    echo
	    read d
	    if [ $d = 1 ] ; then
		while true
		do
		    clear
		    echo
		    echo "1. Stock"
		    echo "2. Port"
		    echo "3. Backup"
		    echo "4. Go back"
		    echo
		    read f
		    if [ $f = 1 ] ; then
			clear
			echo
			echo "These are the contents of this stock folder"
			echo
			ls $stock/*
			echo
			echo "Should we go back [0/1]"
			echo
			read g
			if [ $g = 1 ] ; then
			    break
			fi
                    elif [ $f = 2 ] ; then
                        clear
                        echo
                        echo "These are the contents of this port folder"
                        echo
			ls $port/*
			echo
                        echo "Should we go back [0/1]"
                        echo
                        read g
                        if [ $g = 1 ] ; then
                            break
                        fi
                    elif [ $f = 3 ] ; then
                        clear
                        echo
                        echo "These are the contents of this backup folder"
                        echo
			ls $back/*
			echo
                        echo "Should we go back [0/1]"
                        echo
                        read g
                        if [ $g = 1 ] ; then
                            break
                        fi
                    elif [ $f = 4 ] ; then
                        break
		    else
			echo
			echo "choose something"
		    fi
		done
	    elif [ $d = 2 ] ; then
		while true
		do
		    clear
		    echo
		    echo "1. Stock"
		    echo "2. Port"
		    echo "3. Backup"
		    echo "4. Clear all"
		    echo "5. Go back"
		    echo
		    read f
		    if [ $f = 1 ] ; then
			clear
			echo
			echo "Cleaning all the contents of this stock folder"
			echo
			rm $stock/lib/*
			rm $stock/lib64/*
			echo "done"
			echo
			echo "Should we go back [0/1]"
			echo
			read g
			if [ $g = 1 ] ; then
			    break
			fi
                    elif [ $f = 2 ] ; then
                        clear
                        echo
                        echo "Cleaning all the contents of this port folder"
                        echo
			rm $port/lib/*
			rm $port/lib64/*
                        echo "Should we go back [0/1]"
                        echo
			echo "done"
			echo
                        read g
                        if [ $g = 1 ] ; then
                            break
                        fi
                    elif [ $f = 3 ] ; then
                        clear
                        echo
                        echo "Cleaning all the contents of this backup folder"
                        echo
			rm $back/lib/*
			rm $back/lib64/*
			echo "done"
			echo
                        echo "Should we go back [0/1]"
                        echo
                        read g
                        if [ $g = 1 ] ; then
                            break
                        fi
                    elif [ $f = 4 ] ; then
                        clear
                        echo
                        echo "Cleaning all the contents all folders"
                        echo
			rm $stock/lib/*
			rm $stock/lib64/*
			rm $port/lib/*
			rm $port/lib64/*
			rm $back/lib/*
			rm $back/lib64/*
			echo "done"
			echo
                        echo "Should we go back [0/1]"
                        echo
                        read g
                        if [ $g = 1 ] ; then
                            break
                        fi
                    elif [ $f = 5 ] ; then
                        break
		    else
			echo
			echo "choose something"
		    fi
		done
	    elif [ $d = 3 ] ; then
		break
	    else
		echo
		echo "choose something"
	    fi
	done
    elif [ $c = 4 ] ; then
	break
    else
	echo
	echo "choose something"
    fi
done


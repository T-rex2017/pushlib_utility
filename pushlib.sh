#!/bin/sh

#variables
lib=/system/lib
lib64=/system/lib64
home=`pwd`
stock=$home/stock/system
port=$home/port/system
back=$home/back/system
zip=$home/files/zip

#logging
dat=`date +'%d/%m/%Y %I:%M %P'`
echo "-------------Welcome to PushLib_utility---------" > lib.log
echo "---------------$dat--------------" >> lib.log
echo "starting logs" >> lib.log
echo "-------------" >> lib.log

# Push_lib_utility
while true
do
    clear
    echo
    echo "--------------------"
    echo "| Push Lib Utility |"
    echo "--------------------"
    echo
    echo "Enter file name"
    echo
    read file
    echo "~~~~~input file : $file~~~~~~" >> lib.log
    clear
    while true
    do
        clear
        echo
        echo "--------------------"
        echo "| Push Lib Utility |"
        echo "--------------------"
	echo "~~~PushLib home~~~" >> lib.log
        echo
        echo "1. Push lib"
        echo "2. Revert Changes"
        echo "3. Folders"
        echo "4. Push another file"
	echo "5. Quit"
        echo
        read c
        if [ $c = 1 ] ; then
            clear
	    echo "~~~choosed option : file pushing~~~" >> lib.log
	    echo
	    echo "Pushing files"
	    adb remount
	    adb pull $lib/$file $back/lib
	    adb pull $lib64/$file $back/lib64
	    echo "Pulling files from device" >> lib.log
	    adb push $stock/lib/$file $lib
	    adb push $stock/lib64/$file $lib64
	    echo "Pushing files to device" >> lib.log
	    echo "Pushed succesfully"
	    echo
	    echo "Do you wan't to reboot [0/1]"
	    echo
	    read d
	    if [ $d = 1 ] ; then
	        echo
	        echo "Rebooting"
	        echo
		echo "Rebooting device after pushing files" >> lib.log
	        adb reboot
	        echo "Rebooted"
	        echo
	        sleep .2
	    fi
        elif [ $c = 2 ] ; then
	    while true
	    do
	        clear
		echo "~~~choosed option : revert changes~~~" >> lib.log
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
		    echo "~~~choosed option : reverting from port folder~~~" >> lib.log
	            echo
		    adb remount
		    adb push $port/lib/$file $lib
		    adb push $port/lib64/$file $lib64
		    echo "Reverting push using files from port folder" >> lib.log
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
			echo "Rebooting after reverting files from port" >> lib.log
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
		    echo "~~~choosed option : revert from backup folder~~~" >> lib.log
                    echo
		    adb remount
		    adb push $back/lib/$file $lib
		    adb push $back/lib64/$file $lib64
		    echo "Reverting push using files from backup" >> lib.log
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
			echo "rebooting after revert push from backup folder" >> lib.log
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
			echo "~~~choosed option : make revert zip~~~" >> lib.log
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
			    echo "~~~choosed option : make revert zip from port folder~~~" >> lib.log
			    echo
			    echo "Coping files"
			    echo
			    rm $zip/*
			    echo "Cleaning zip folder" >> lib.log
			    cp $port/lib/$file $zip
			    cp $port/lib64/$file $zip
			    cp $home/files/META-INF $zip
			    echo "Coping files from port" >> lib.log
			    echo
			    echo "zipping files"
			    echo
			    zip -rm Revert.zip $zip/*
			    echo "Making zip by using files from port folder" >> lib.log
			    echo "done"
			    echo
		        elif [ $g = 2 ] ; then
                            clear
			    echo "~~~choosed option : maing revert zip from backup folder~~~" >> lib.log
                            echo
                            echo "Coping files"
                            echo
			    rm $zip/*
			    echo "Cleaning zip folder" >> lib.log
			    cp $back/lib/$file $zip
			    cp $back/lib64/$file $zip
			    cp $home/files/META-INF $zip
			    echo "Copinf files from backup" >> lib.log
			    echo
			    echo "zipping files"
			    echo
			    mkdir -p
			    zip -rm Revert.zip $zip/*
			    echo "Zipping files from backup" >> lib.log
                            echo "done"
                            echo
		        elif [ $g = 3 ] ; then
			    break
		        else
			    echo "choose something"
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
		echo "~~~choosed option : check PushLib folders~~~" >> lib.log
	        echo
		echo "------------------"
		echo "| PushLib foders |"
		echo "------------------"
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
		    echo "These are the contents of this stock folder"
		    echo "Viewing contents in stock folder" >> lib.log
		    echo
		    ls $stock/*
		    echo
		    echo "Do you wan't clean this folder ? [0/1]"
		    echo
		    read g
		    if [ $g = 1 ] ; then
			rm -rf $stock/lib/*
			rm -rf $stock/lib64/*
		        break
		    fi
                elif [ $f = 2 ] ; then
                    clear
                    echo
                    echo "These are the contents of this port folder"
		    echo "Viewing contents in port folder" >> lib.log
                    echo
		    ls $port/*
		    echo
                    echo "Do you wan't to clean this folder ? [0/1]"
                    echo
                    read g
                    if [ $g = 1 ] ; then
                        rm -rf $port/lib/*
			rm -rf $port/lib64/*
			break
                    fi
                elif [ $f = 3 ] ; then
                    clear
                    echo
                    echo "These are the contents of this backup folder"
		    echo "Viewing contents in backup folder" >> lib.log
                    echo
		    ls $back/*
		    echo
                    echo "Do you wan't to clean this folder [0/1]"
                    echo
                    read g
                    if [ $g = 1 ] ; then
			rm -rf $back/lib/*
			rm -rf $back/lib64/*
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
		    echo "Cleaning all folders" >> lib.log
		    echo "done"
                elif [ $f = 5 ] ; then
                    break
	        else
		    echo
		    echo "choose something"
	        fi
	    done
        elif [ $c = 4 ] ; then
	    break
	elif [ $c = 5 ] ; then
	    echo "~~~choosed option : quit Pushlib~~~" >> lib.log
	    echo "-----------end of log---------------" >> lib.log
	    clear
	    exit 1
        else
	    echo
	    echo "choose something"
        fi
    done
done


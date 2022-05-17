#!/bin/bash
cat pever.txt
read -p "Enter your name : " uname

# display message
showMsg() {
    clear
    cat pever.txt # logo
    echo "=========================================================================================="
    tail -20 mes.txt
    echo "=========================================================================================="
}

# take actions when new messages recieved
listen () {
    while [ true ]
    do
        touch -d"-0.5sec" .tmp
        [ "mes.txt" -nt .tmp ] && showMsg && echo -n "Enter your message : " && sleep 1
        
    done
}

# read message from the user
rmsg () {
    # echo "HID : "
    # read hid
    listen &
    read -p "Enter your message : " msg # take input in the same line (no line break)
    echo "$uname : $msg" >> mes.txt
    while [ true ]
    do
        read msg
        echo "$uname : $msg" >> mes.txt
        # echo "$msg" | ssh $hid -T "cat > /home/sachin/mes.txt"
    done
}

# create message file if not exists
FILE=./mes.txt
if test -f "$FILE"; then
    showMsg
    rmsg
else
    touch mes.txt
    showMsg
    rmsg
fi
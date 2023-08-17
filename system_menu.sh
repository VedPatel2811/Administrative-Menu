#!/bin/bash
# Ved Patel

echo Hello $USER #Welcome user with their user name 
echo Today is $(date) # date 
./banner.sh -c# Welcome to the System # Banner 
echo 
echo Note that these are administrative functions that will ask for an administrator password.
echo
while true; do
    ./banner.sh System Menu
    echo
    echo Enter your choice:  #printing the options
    echo 
    echo "(P)rint out a list of regular users"
    echo "(L)ist out all of the user groups"
    echo "(A)dd a new user to the system"
    echo "(C)reate a welcome file to a user's home directory"
    echo "(S)et an account expiration date for a user account"
    echo "(D)elete a user from the system"
    echo "(Q)uit the menu"
    echo
    read -rp "" choice
    echo
    case "$choice" in # Switch cases for the option
        p | P) 
            ./banner.sh Actual Users of the System
            echo
            while IFS=":" read -r username password uid gid full_name home shell # this will read the information which is seperated by : and save in the given names 
            do  
                if [[ "$uid" -ge 1000 && "$uid" -lt 65534 && -n $full_name ]] 
                then 
                    echo "$username : $full_name"
                elif [[ "$uid" -ge 1000 && "uid" -lt 65534 ]] 
                then 
                    echo "$username :"
                fi
            done < /etc/passwd | sed 's/,,,//' # this will remove the commas after the full name 
            ;;
        l | L)
            ./banner.sh User Groups of the System
            echo  
            echo A '*' includes that the group is not a personal group 
            echo
            while IFS=":" read -r groupname x gid x # this will read information of group 
            do
                if [[ "$gid" -ge 1000 && "$gid" -lt 65534 ]]
                then
                    match=false
                    while IFS=":" read -r username password uid gid full_name home shell 
                    do
                        if [[ "$groupname" == "$username" ]] # if a group name is same as user name then this loop will work 
                        then
                            match=true
                            break
                        fi
                    done < /etc/passwd 

                    if $match #if match is true then the group name will print as it is or if not match it will print with * 
                    then
                        echo "$groupname group" 
                    else
                        echo -e "\033[34m*\033[0m $groupname group"
                    fi
                fi
            done < <(getent group) 
            ;;  
        a | A) 
            ./banner.sh Adding a new User
            read -p "Please Enter the user name: " username 
            sudo adduser "$username" && echo "Added $username $(date)" >> useradmin.log # this line will add user and if the user will added then a line will print with a log file 
            ;;
        c | C) 
            ./banner.sh Creating a Welcome file 
            echo Welcome to the system "$USER! Hope you are doing well and enjoy using this program."> welcome.txt #creating a user welcome file 
            username="$HOME"
            cp welcome.txt "$username/" # coping the file to the user home directory 
            if [ $? -eq 0 ]
            then 
                echo "Welcome message sent to $USER on $(date)"
                echo "Welcome message sent to $USER on $(date)" >> useradmin.log 
                echo "User file created successfully"
            else 
                echo "Error because of User not found or copy operstion failed."
            fi
            ;;
        s | S)
            ./banner.sh Setting an Expiry date for a user 
            while true 
            do 
                read -p "Enter the username for which you want to change the expiry date: " username 
                read -p "Enter the expiry date (YYYY-MM-DD): " exp_date

                if date -d "$exp_date" >/dev/null 2>&1 # to cheque the formate of the date is valid format or not 
                then
                    if sudo usermod -e "$exp_date" "$username" 
                    then
                        echo "Expiry date for $username is updated successfully to $exp_date on $(date)"
                        echo "Expiry date for $username is updated successfully to $exp_date on $(date)" >> useradmin.log
                        break
                    fi 
                else  
                    echo "Error because of invalid date format. Please enter date in YYYY-MM-DD."
                fi
            done
            ;;
        d | D)
            ./banner.sh Deleting a user 
            read -p "Enter the username you want to delete: " username
            if id "$username" &>/dev/null # to cheque the user name that user input is valid or not 
            then
                read -p "Are you sure you want to delete this user? (Y/N): " confirm
                if [[ $confirm=="Y" && "y" ]] #To conform the delete
                then 
                    sudo userdel $username
                    echo deleted $username $(date) 
                    echo deleted $username $(date) >> useradmin.log
                    echo "Orphaned /home/$username"
                    echo "Orphaned /home/$username" >> useradmin.log
                else 
                    echo "User is not going to delete"
                fi
            else
                echo "Username $username not found"
            fi
            ;;
        q | Q)
            echo goodbye 
            exit 0
            ;;
    esac
    echo
    read -rp "Press enter to continue"
done
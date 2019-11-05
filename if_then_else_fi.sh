for i in 1 2 3 4 5 6
do
    ### just skip printing $i; if it is 3 or 6  ###
    if [ $i -eq 3 -o $i -eq 6 ]
    then
        continue  ### resumes iteration of an enclosing for loop ###
    else
        echo "$i"
        #print $i
    fi
done

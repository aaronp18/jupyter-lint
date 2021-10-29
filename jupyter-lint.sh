#/bin/bash


if [ $# -ge 1 ]
then
    # Options
    SIMPLIFY=0
    
    for option in "$@"
    do
        case $option in
            -h) # display Help
                echo "HELP"
            ;;
            -s) # Simplify
                SIMPLIFY=1
            ;;
            
        esac
    done
    
    
    
    if [ ! -f $1 ]
    then
        echo $1 does not exist
    else
        #Get parent directory
        PARENT=$(echo $1 | sed -E -e "s/[^\\\/]+$//")
        
        echo Removing MD from $1...
        node removeMD $1
        
        echo Converting $1...
        jupyter nbconvert --to=script --output-dir=tmp/converted-notebooks/$PARENT tmp/without-md/$1
        
        FILE=$(echo $1 | sed -E -e "s/\.[^.]*$//")
        
        echo Running pylint...
        echo
        
        if [[ $SIMPLIFY == 1 ]]
        then
            pylint tmp/converted-notebooks/$FILE.py > tmp/log
            cat tmp/log | grep tmp/converted-notebooks/
            echo
            cat tmp/log | grep rated
        else
            pylint tmp/converted-notebooks/$FILE.py
        fi
        
        
        
        
    fi
    
    
else
    echo "Usage:"
    echo "./runPylint.sh <jupyter file>"
    echo ""
    echo "Options: "
    # echo "-r replace: Basically replaces  "
    echo "-s Simplify - Removes all of the other aspects of the pylint output, so that you can see just the score and issues."
fi

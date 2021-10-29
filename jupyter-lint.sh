#/bin/bash

if [ $# -ge 1 ]
then
    # Options
    SIMPLIFY=0
    
    for option in "$@"
    do
        case $option in
            -h) # Display Help
                echo "HELP"
            ;;
            -i) # Install
                echo "Installing depenencies"
            ;;
            -s) # Simplify mode
                SIMPLIFY=1
            ;;
            
        esac
    done
    
    
    #Checks the file actually exists
    if [ ! -f $1 ]
    then
        echo $1 does not exist
    else
        # Obtains the name of the file
        NAMEWITHEXTENSION=$(basename $1)
        # Obtains the name of the file without the extenstion
        FILE="${NAMEWITHEXTENSION%.*}"
        
        # Removes the markdown cells from the notebook
        echo Removing Markdown from $1...
        node removeMD $1
        
        # Converts the notebook to a script so pylint can use it.
        echo Converting $1...
        jupyter nbconvert --to=script --output-dir=tmp/converted-notebooks/ tmp/without-md/$NAMEWITHEXTENSION
        
        
        
        # If simple mode is on, then cut out uneccessary information
        if [[ $SIMPLIFY == 1 ]]
        then
            echo Running pylint in simple mode...
            echo
            
            # Outputs to tempory file and then displays necessary lines
            pylint tmp/converted-notebooks/$FILE.py > tmp/log
            
            # Issues
            cat tmp/log | grep tmp/converted-notebooks/
            echo
            
            # Rating
            cat tmp/log | grep rated
        else
            # Runs pylint as normal
            echo Running pylint...
            echo
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



INSTALL () {
    echo Installing depenencies...
    echo I havent actually added installing of dependices yet, you just kinda need `node`. The version shouldnt matter. Ill change this to python when I get the chance
    
}

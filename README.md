# Jupyter-Lint
# Overview

This script is something I quickly threw together in order to run pylint on Jupyter notebooks without having to manually copy and paste. 

It works by first removing markdown from the notebook, as this results in long comments which pylint doesnt like. 

Then it converts it to a python script, and then runs pylint on it.

## Installation
1) First download the scripts.
2) Then extract to wherever you want it.
3) Run `sudo ./jupyter-lint.sh -i` to install all necessary dependencies. (I haven't implemented this yet, but all you need is some version of `node` installed to remove the md. I will change this to python when I get the chance.)
4) If you have a pylintrc file, make sure to move it into the same directory as the script.
5) Once this is done, you are ready to use it!

## Usage
Luckily it is very easy to use

`./jupyter-lint.sh <filename>` is all you need to use to run the script.

`./jupyter-lint.sh <filename> -s` - Runs the script in `simple` mode which basically only outputs what is wrong and the rating, without all of the other tables pylint spits out.

### Options
- `-s` - Runs the script in `simple` mode which basically only outputs what is wrong and the rating, without all of the other tables pylint spits out.
- `-v` - Displays the version
- `-h` - Displays the help screen


PAPERS_LOCATION=~/papers
PAPER=$(ls $PAPERS_LOCATION | rofi -dmenu)
# $? checks the return code of the last program
(($? == 0 )) && zathura $PAPERS_LOCATION/$PAPER

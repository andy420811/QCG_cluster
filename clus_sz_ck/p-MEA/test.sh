restartf="lastrun.txt"
n=1
while read -r line;
do
    if [ $n -eq 1 ] ;then
        ipre=$line
    fi
    if [ $n -eq 2 ] ;then
        jpre=$line
    fi
    n=$(($n+1))
done < $restartf
echo $ipre 

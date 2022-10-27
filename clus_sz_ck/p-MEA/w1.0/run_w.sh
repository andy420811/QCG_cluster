# load the previous unsent jobs stop point

restartf="lastrun.txt"
if [ -f "$restartf" ]; then

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
	done < "$restartf"
else
	ipre=0
	jpre=0
fi


for i in 1 2 3 4 5
do
	if [ $i -lt $ipre ]; then
		continue
	fi

	mkdir -p run"$i"
	cd run"$i"
	for j in 25 30 35 40 45 60 70 80 90 100
	do	
		if 	[[ $j -lt $jpre ]]; then		
			if [ $i -eq $ipre ]; then
				continue
			fi
		fi

		mkdir -p s"$j"p_w1.0
		cd s"$j"p_w1.0
		
		## restart
		if [ ! -f "crest.out" ]
		then
		rsync -a ../../Protonated\ 2-aminoethanol\ \(P-MEA\).xyz input.xyz 
		rsync -a ../../water.xyz ../../sub.sh .
		fi


		##cd s"$j"_w1.0
		sed -i "s/crest input.xyz --qcg water.xyz --chrg 1 --uhf 0 --nsolv 60  --T 25 --gsolv --nclus 20 --gbsa water > crest.out/crest input.xyz --qcg water.xyz --chrg 1 --uhf 0 --nsolv "$j" --T 25 --gsolv --nclus 20 --gbsa water --wscal 1.0 > crest.out/" sub.sh
		echo $i $j

		##sed -i "s/--nsolv 60/--nsolv "$j" --wscal 1.0 /" sub.sh		

		if ! qsub -N s"$j"p_run"$i"_w1.0 sub.sh 
		then
			cd ../..
			printf ""$i"\n"$j"\n" > lastrun.txt	
			exit 1
		fi
		##cat sub.sh
		##qsub -N s"$j"_w1.0 sub.sh
		

		cd ..
	done
	cd ..
done
printf ""$i"\n"$j"\n" > lastrun.txt

exit 0

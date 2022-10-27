grep -r "G_solv (incl.RRHO)+dV(T)" . > G_solv.txt

python3 E.py G_solv.txt

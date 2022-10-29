from ase.io import write,read
from ase.io.trajectory import Trajectory
import numpy as np

path='/home/andy420811/Work/TEST/XTB/clus_sz_ck/p-MEA'
path = '.'
size = [25,30,35,45,60,70,80,90,100]
#size=[25]
for i in range(5):
    for j in size:
        try:
           mol = read(path+'/run'+str(i+1)+'/s'+str(j)+'p_w1.0/ensemble/final_ensemble.xyz',':')[0]
        except:
           print(i,j,'shit')
           continue


        print('size: '+str(j),'run: '+str(i+1),mol.get_distance(3,8))

from sys import argv
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import font_manager

#font_manager.findSystemFonts(fontpaths=None, fontext="ttf")
font_manager.findSystemFonts(fontpaths=None)
plt.rcParams['axes.linewidth'] = 2
plt.rcParams['font.size'] = 12
plt.rcParams['font.family'] = 'sans-serif'
plt.rcParams['font.sans-serif'] = 'Arial'


t = None
Ene = []
Ene2 = []
n1 = []
n2 = []
data = []
data2 = []
with open( "G_solv.txt" , "r" ) as f:
    lines = f.readlines()
for line in lines[1:]:
    t = line.split("/")[1]
    if len(t) > 4:
        n1.append(float(t[1:].split("_")[0]))
        Ene.append(float(line.split()[-3]))
        data.append((float(t[1:].split("_")[0]) , float(line.split()[-3])))
    else:
        n2.append(float(t[1:].split("_")[0]))
        Ene2.append(float(line.split()[-3]))
        data2.append((float(t[1:].split("_")[0]) , float(line.split()[-3])))

data = sorted(data, key=lambda tup: tup[0], reverse=True)
data2 = sorted(data2, key=lambda tup: tup[0], reverse=True)

fig,ax=plt.subplots()

ax.plot(*zip(*data2),lw=1.5,label='wscal = default')
ax.plot(*zip(*data),lw=1.5,label='wscal = 1.0')

ax.set_xlabel('number of solvent molecules',fontsize=20)
ax.set_ylabel('G_solv',fontsize=20)
ax.legend(loc='best',frameon=False)
fig.tight_layout()
plt.show()
# -*- coding: utf-8 -*-

path = 'C:/Users/hiroa/kabu/txt/'
target = path + file_name

import warnings
warnings.filterwarnings('ignore')
warnings.filterwarnings('ignore', category=DeprecationWarning) 
import pandas as pd
import numpy as np
#%matplotlib inline
import matplotlib.pyplot as plt
from fbprophet import Prophet

# 画像ファイルに文字列を挿入
# https://www.tech-tech.xyz/archives/drawtext.html
print('########################################################################################')
print(file_name)

df = pd.read_csv(target, engine = 'python', names=('ds', 'start', 'high', 'low', 'y', 'trading_value','adjust_end'))
df = df[['ds', 'y']]
#df.tail()


df['y'] = np.log(df['y'])
#df.tail()

m = Prophet()
m.fit(df);

future = m.make_future_dataframe(periods=150)
#future.tail()
forecast = m.predict(future)
m.plot(forecast);
#plt.title(file_name, '_future_forecast')
plt.savefig('C:/Users/hiroa/kabu/txt/png/' + file_name + '_future_forecast.png', dpi=1000)

m.plot_components(forecast);
plt.savefig('C:/Users/hiroa/kabu/txt/png/' + file_name + '_components.png', dpi=1000)

#%matplotlib inline
import pandas
import matplotlib.pyplot as plt
#dataset = pandas.read_csv(target, usecols=[1], engine='python', skipfooter=3)
dataset = pandas.read_csv(target, usecols=[6], engine='python', skipfooter=3)
plt.plot(dataset)
plt.savefig('C:/Users/hiroa/kabu/txt/png/' + file_name + '_plot.png', dpi=1000)

dataset.hist(bins=100, range=(500, 6500), alpha=1.0)
plt.savefig('C:/Users/hiroa/kabu/txt/png/' + file_name + '_histogram.png', dpi=1000)

print(dataset.describe())
dataset.describe().to_csv('C:/Users/hiroa/kabu/txt/png/' + file_name + '_describe.csv', index=True)

#dataset.y.diff().plot()
#plt.savefig('C:/Users/hiroa/kabu/txt/png/' + file_name + '_diff.png', dpi=1000)

#dataset.y.diff().round(3).hist(bins=20, range=(-500, 500), alpha=1.0)
#plt.savefig('C:/Users/hiroa/kabu/txt/png/' + file_name + '_diff_histogram.png', dpi=1000)

########################################################################################
# changefinder

import matplotlib.pyplot as plt
import changefinder
import numpy as np
#data=np.concatenate([np.random.normal(0.7, 0.05, 300),
#np.random.normal(1.5, 0.05, 300),
#np.random.normal(0.6, 0.05, 300),
#np.random.normal(1.3, 0.05, 300)])

data = df['y']
# 赤が元データ、青が変化スコア

#cf = changefinder.ChangeFinder(r=0.01, order=1, smooth=7)
cf = changefinder.ChangeFinder(r=0.02, order=1, smooth=7)
#cf = changefinder.ChangeFinder(r=0.001, order=1, smooth=7)

ret = []
for i in data:
    score = cf.update(i)
    ret.append(score)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.plot(ret)
ax2 = ax.twinx()
ax2.plot(data,'r')
#plt.show()
plt.savefig('C:/Users/hiroa/kabu/txt/png/' + file_name + '_changefinder.png', dpi=1000)


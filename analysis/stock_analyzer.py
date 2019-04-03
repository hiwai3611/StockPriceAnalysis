# -*- coding: utf-8 -*-

path = 'C:/Users/hiroa/kabu/txt/'
#file_name = '1301.txt'
target = path + file_name

import warnings
warnings.filterwarnings('ignore')
warnings.filterwarnings('ignore', category=DeprecationWarning) 
import pandas as pd
import numpy as np
#%matplotlib inline
import matplotlib.pyplot as plt

df = pd.read_csv(target, engine = 'python')
df_close = df.iloc[:,4] 

#直近の値
df_last = df_close.tail(1).mean()
#5日間の平均
df_avg5 = df_close.tail(5).mean()
#20日間の平均
df_avg20 = df_close.tail(20).mean()
#60日間の平均
df_avg60 = df_close.tail(60).mean()
#全期間の平均
mean = df_close.mean()
# 不偏標準偏差
std = df_close.std()

kairi_rate = (df_last - mean)/mean

print('===============================================================================================================================')
print(file_name, '直近の株価：', df_last, '、平均からの乖離率：', kairi_rate)
print('過去5日の平均:', df_avg5,'、', '過去20日の平均:', df_avg20,'、',  '過去60日の平均:', df_avg60,'、',  '全期間の平均:', mean)

if (df_last > mean + 2*std ):
    print(file_name, '(1). 直近の株価は、mean + 2*std　以上')
if (df_last > mean + std and df_last < mean + 2*std):
    print(file_name, '(1). 直近の株価は、mean + std　以上')
elif (df_last > mean ):
    print(file_name, '(1). 直近の株価は、平均値以上')
elif (df_last < mean - 2*std):
    print(file_name, '(1). 直近の株価は、mean - 2*std 以下')
elif (df_last < mean - std):
    print(file_name, '(1). 直近の株価は、mean - std 以下')
elif (df_last < mean ):
    print(file_name, '(1). 直近の株価は、平均値以下')

if (df_avg5 > mean + 2*std ):
    print(file_name, '(2). 直近の株価は、mean + 2*std　以上')
if (df_avg5 > mean + std and df_avg5  < mean + 2*std):
    print(file_name, '(2). 5日平均は、mean + std　以上')
elif (df_avg5 > mean ):
    print(file_name, '(2). 5日平均は、平均値以上')
elif (df_avg5 < mean - 2*std):
    print(file_name, '(2). 直近の株価は、mean - 2*std 以下')
elif (df_avg5 < mean - std):
    print(file_name, '(2). 5日平均は、mean - std 以下')
elif (df_avg5 < mean ):
    print(file_name, '(2). 5日平均は、平均値以下')

if (df_avg20 > mean + 2*std ):
    print(file_name, '(3). 直近の株価は、mean + 2*std　以上')
if (df_avg20 > mean + std and df_avg20  < mean + 2*std):
    print(file_name, '(3). 20日平均は、mean + std　以上')
elif (df_avg20 > mean ):
    print(file_name, '(3). 20日平均は、平均値以上')
elif (df_avg20 < mean - 2*std):
    print(file_name, '(3). 直近の株価は、mean - 2*std 以下')
elif (df_avg20 < mean - std):
    print(file_name, '(3). 20日平均は、mean - std 以下')
elif (df_avg20 < mean ):
    print(file_name, '(3). 20日平均は、平均値以下')

if (df_avg60 > mean + 2*std ):
    print(file_name, '(4). 直近の株価は、mean + 2*std　以上')
if (df_avg60 > mean + std and df_avg60  < mean + 2*std):
    print(file_name, '(4). 60日平均は、mean + std　以上')
elif df_avg60 > mean :
    print(file_name, '(4). 60日平均は、平均値以上')
elif (df_avg60 < mean - 2*std):
    print(file_name, '(4). 直近の株価は、mean - 2*std 以下')
elif df_avg60 < mean - std :
    print(file_name, '(4). 60日平均は、mean - std 以下')
elif df_avg60 < mean :
    print(file_name, '(4). 60日平均は、平均値以下')

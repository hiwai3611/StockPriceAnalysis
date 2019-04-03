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
df_avg5 = round(df_avg5, 1)

#20日間の平均
df_avg20 = df_close.tail(20).mean()
df_avg20 = round(df_avg20, 1)

#60日間の平均
df_avg60 = df_close.tail(60).mean()
df_avg60 = round(df_avg60, 1)

#90日間の平均
df_avg90 = df_close.tail(90).mean()
df_avg90 = round(df_avg90, 1)

#全期間の平均
mean_all = df_close.mean()
mean_all = round(df_close.mean(), 1)

# 不偏標準偏差
#std = df_close.std()

kairi_rate = ((df_last - mean)/mean)
kairi_rate = round(kairi_rate, 1)

kairi_rate5 = ((df_last - df_avg5)/df_avg5)
kairi_rate5 = round(kairi_rate5, 1)

kairi_rate20 = ((df_last - df_avg20)/df_avg20)
kairi_rate20 = round(kairi_rate20, 1)

print('===============================================================================================================================')
print(file_name, ',直近の株価,', df_last , ',平均からの乖離率,' , kairi_rate , ',20日平均からの乖離率,' , kairi_rate20 , ',5日平均からの乖離率,' , kairi_rate5)
print(file_name, ',過去5日の平均,' , df_avg5 ,',過去20日の平均,' , df_avg20 , ',過去60日の平均,' , df_avg60 , ',過去90日の平均,' , df_avg90, ',全期間の平均, ', mean_all)


if (((df_last - df_avg90) / df_avg90) >= 3.0) :
	print(file_name, '株価は3ヶ月平均の3倍の差')

if (((df_last - df_avg90) / df_avg90) < 3.0 and ((df_last - df_avg90) / df_avg90) >= 2.0) :
	print(file_name, '株価は3ヶ月平均の2倍の差')

elif (((df_last - df_avg90) / df_avg90) < 2.0 and ((df_last - df_avg90) / df_avg90) >= 1.0) :
	print(file_name, '株価は3ヶ月平均の100%増')

elif (((df_last - df_avg90) / df_avg90) < 1.0 and ((df_last - df_avg90) / df_avg90) >= 0.75) :
	print(file_name, '株価は3ヶ月平均より、75%以上高い')

elif (((df_last - df_avg90) / df_avg90) < 0.75 and ((df_last - df_avg90) / df_avg90) >= 0.5) :
	print(file_name, '株価は3ヶ月平均より、50%以上高い')
	
elif (((df_last - df_avg90) / df_avg90) < 0.5 and ((df_last - df_avg90) / df_avg90) >= 0.3) :
	print(file_name, '株価は3ヶ月平均より、30%以上高い')	
	
elif (((df_last - df_avg90) / df_avg90) < 0.3 and ((df_last - df_avg90) / df_avg90) >= 0.1) :
	print(file_name, '株価は3ヶ月平均より、10%以上高い')
		
elif (((df_last - df_avg90) / df_avg90) <= -0.1 and ((df_last - df_avg90) / df_avg90) > -0.3) :
	print(file_name, '株価は3ヶ月平均より、10%以上安い')
	
elif (((df_last - df_avg90) / df_avg90) <= -0.3 and ((df_last - df_avg90) / df_avg90) > -0.5) :
	print(file_name, '株価は3ヶ月平均より、30%以上安い')
	
elif (((df_last - df_avg90) / df_avg90) <= -0.5 and ((df_last - df_avg90) / df_avg90) > -0.75) :
	print(file_name, '株価は3ヶ月平均より、50%以上安い')

elif (((df_last - df_avg90) / df_avg90) <= -0.75) :
	print(file_name, '株価は3ヶ月平均より、75%以上安い')
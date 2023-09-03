import os
import pandas as pd

path = './cache_data/'
files = os.listdir(path)


for index, file in enumerate(files):
	df = pd.read_csv(path + file)
	if {'country', 'indicator'}.issubset(df.columns): 
	  # print(file)
	  # print(df['country'].iloc[0])
	  # print(df['indicator'].iloc[0])
	  if str(df['country'].iloc[0])+'_'+str(df['indicator'].iloc[0])+'_' not in file:
	    # print(str(df['country'].iloc[0])+'_'+str(df['indicator'].iloc[0])+'_'+file)
	    os.rename(os.path.join(path, file), os.path.join(path,str(df['country'].iloc[0])+'_'+str(df['indicator'].iloc[0])+'_'+file))

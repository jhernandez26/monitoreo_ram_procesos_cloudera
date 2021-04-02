#!/home/jhernandez/Documentos/RAM/venv/bin/python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sys

def dataframeuser_grafica(df,user,file):
    name_csv = file+"_all.csv"
    name_img = file+"_"+user+".png"
    df = df[df.Usuario == user]
    df = df.sort_values('RAM',ascending=False)
    df = df.head(5)
    xvalue = df['Fecha']
    yvalue = df['RAM']
    plt.plot(xvalue,yvalue, label=user)
    plt.legend(loc="center right")
    plt.savefig(name_img)
    #plt.show()
    df.to_csv(name_csv,index=False,mode='a',header=False)

def main():
    #df = pd.read_csv('all.csv')
    file = sys.argv[1]
    file_name = file.split('.')
    df = pd.read_csv(file)
    df['RAM'] = (df.Memoria_Por * 125)/100
    df=df[df.RAM !=0]
    user = df.drop_duplicates(subset=['Usuario'])
    user = user['Usuario']
    #print(user)
    #df = df.groupby(['Fecha','Usuario','RAM'])['RAM'].sum().rename(columns={'Fecha':'Date','Usuario':'User'}).reset_index()
    df = df.groupby(['Fecha','Usuario'])['RAM'].sum().reset_index()
    for i in  user:
        dataframeuser_grafica(df,i,file_name[0])

    
    #df2 = df.reset_index(drop=True)
    #df = df.groupby(['Fecha','Usuario','RAM']).agg({'RAM':'sum'})
    #dfimpala = df[df.Usuario == 'impala']
    #dfimpala = dfimpala.sort_values('RAM',ascending=False)
    #dfimpala = dfimpala.head(5)
    #xvalue = dfimpala['Fecha']
    #yvalue = dfimpala['RAM']
    
    #plt.plot(xvalue,yvalue)
    #plot = plt.plot(xvalue,yvalue)
    #plt.savefig('grafica.png')
    #plt.show()

    #plot = dfimpala.plot()
    #fig = plot.get_figure()
    #fig.savefig("output.png")
    #df.plot()
    #df.to_csv('test.csv',index=False)
    #print(dfimpala)
if __name__ == "__main__":
    main()
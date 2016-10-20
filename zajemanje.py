# -*- coding: utf-8 -*-
"""
Created on Sun Oct 16 20:45:07 2016

@author: Urban Rupnik
"""

import requests
from bs4 import BeautifulSoup
from openpyxl import Workbook,load_workbook
import os


filename = 'test.xlsx'
ws=[None]*12
ws[0]=''

mesec=['Januar','Februar','Marec','April', 
'Maj', 'Junij', 'Julij', 'Avgust', 
'September', 'Oktober', 'November', 'December']

if (os.path.isfile(filename)):
	wb=load_workbook(filename)
	for i in range(0,12):
		ws[i]=wb.get_sheet_by_name(mesec[i])
else:
	wb=Workbook()
	ws[0]=wb.active
	ws[0].title='Januar'
	for i in range(1,12):
		ws[i]=wb.create_sheet(mesec[i])
wb.save(filename)

url = "http://meteo.arso.gov.si/uploads/probase/www/observ/surface/text/sl/observationAms_ZADLOG_history.html"
file_out = "zadlog_vreme.csv"

text = requests.get(url).text
soup = BeautifulSoup(text, 'html.parser')


i=11
while i>=0:
	last_old_month = ws[i]['A2'].value
	if(last_old_month != None):
		break
	else:
		i-=1
		
j=2
while True:
	last_old_value=ws[i]['B'+str(j)].value
	if (last_old_value != None):
		j+=1
	else:
		j-=1 
		last_old_value=ws[i]['B'+str(j)].value
		break


data=[]
table = soup.table


for index1, tr in enumerate(table.find_all("tr")[1:]):  # skip first row
    tds = tr.find_all("td")
    time = tds[0].text #  take the one without "Nedelja, "
    idx = time.find(",")  # find index and get day, date and time separately
    day = time[:idx]
    #print(day)
    date = time[idx+2:idx+12]
    #print(date)
    time1 = time[idx+13:idx+18]
    #print(time1)
    temperature_precise = tds[10].text
    temparature = tds[11].text
    humidity_precise = tds[12].text
    humidity = tds[13].text
    rainfall = tds[24].text
    rainfall_12h = tds[26].text
    if(date+ ' ' + time1 == last_old_value):
		break

    data.append((date+ ' ' + time1, day, temperature_precise, temparature, humidity_precise, rainfall, rainfall_12h))

data.reverse();





for index, sample in enumerate(data):
	for idx, x in enumerate(sample):
		if(idx == 0):
			dotidx1=x.find('.')
			dotidx2=x.find('.', dotidx1+1)
			month = int(x[dotidx1+1:dotidx2])-1
			ws[month]['B'+str(index+j+1)]=x
			ws[month].column_dimensions["B"].width = 15
		elif(idx == 1):
			ws[month]['A'+str(index+j+1)]=x
		elif(idx==2):
			ws[month]['C'+str(index+j+1)]=float(x)
		elif(idx==3):
			ws[month]['D'+str(index+j+1)]=float(x)
		elif(idx==4):
			ws[month]['E'+str(index+j+1)]=float(x)
		elif(idx==5):
			ws[month]['F'+str(index+j+1)]=float(x)
		elif(idx==6):
			ws[month]['G'+str(index+j+1)]=float(x)
#		elif(idx==7):
#			ws[month]['H'+str(index+2)]=x
#print(data)
#for x in data:
#	print(x)


wb.save(filename)

with open(file_out, "w") as fp:
    for d in data:
        fp.write(", ".join(d) + "\n")
import json
import urllib2
import psycopg2
from datetime import datetime
import time
import sys

arq= open("log_data_sent.txt", 'a')

def log(tag, message):
	now = time.time()
	data = str(datetime.fromtimestamp(now) )
	arq.write(data +" "+tag + ": " + message +"\n" )
	

def getlocaldata():
	tag = "getlocaldata"
	con = psycopg2.connect(host='localhost', user='postgres', password='root',dbname='postgres')
	c = con.cursor()
	log( tag,  'conexao com banco local realizada' )
	c.execute('select idsensor_fk, valor,timestamp,idamostra from amostra ORDER BY timestamp' )
	dados=c.fetchall()
	con.close()
	log( tag,  'Loaded data from local database' )
	return dados

def date_handler(obj):
	return obj.isoformat() if hasattr(obj, 'isoformat') else obj

def verificarerro():
	print "not implemented"

def senddata(jsonData):
	tag = "senddata"
	req = urllib2.Request('http://www.mdecarvalho.com/RSSF/scripts/setAmostra.php')
	req.add_header('Content-Type', 'application/json')
	log(tag, "Sending samples to the server.")
	try:
		response = urllib2.urlopen(req, json.dumps(jsonData, default=date_handler))
	except urllib2.HTTPError, e:
		print e.code
		log(tag, "Could not connect to server")
		exit()
	except urllib2.URLError, e:
		print e.args
		log(tag, "Could not connect to server")
		exit()
	string = response.read()
	if( string == ""):
		exit()
	else:
		con = psycopg2.connect(host='localhost', user='postgres', password='root',dbname='postgres')
		c = con.cursor()
		if( len(json.loads( string )['errors']) > 0 ):
			sql = "DELETE FROM amostra WHERE idamostra NOT IN "+ str(json.loads( string )['errors']).replace("[", "(").replace("]", ")")
			log(tag, "Some data could not be sent: idamostra = "+str(json.loads( string )['errors'])+".")
			log(tag, "Deleting data sent to the server from local database.")
		else:
			sql = "DELETE FROM amostra"
			log(tag, "All data has been sent to server. ")
			log(tag, "Deleting local data.")
		c.execute(sql)
		con.commit()
		log(tag, "Data has been deleted.")
		con.close()
			

if __name__ == '__main__':
	dados = getlocaldata()
	senddata(dados)
	arq.close()
	


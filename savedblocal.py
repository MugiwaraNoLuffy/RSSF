from datetime import datetime
import socket
import psycopg2
# Import and init an XBee device
import serial
from xbee import ZigBee
from binascii import b2a_hex
import sys
arq= open("log_porta_ttyAMA0.txt", 'w+')

def banco(serial,lum,temp,umi):
	print 'iniciando a conexao'
	con = psycopg2.connect(host='localhost', user='postgres', password='root',dbname='postgres')
	c = con.cursor()
	print 'conexao realizada'
	c.execute('select sensor.idsensor, sensor.idtipo_fk from sensor inner join no on (no.idno = sensor.idno_fk) where no.serial = \''+serial+'\' ORDER BY sensor.idtipo_fk' )
	dados=c.fetchall()
	for item in dados:
		if (item[1] == 1):
			c.execute('insert into amostra (idsensor_fk,valor) values (\''+str(item[0])+'\',\''+str(lum)+'\')')
		elif(item[1] == 2):
			c.execute('insert into amostra (idsensor_fk,valor) values (\''+str(item[0])+'\',\''+str(temp)+'\')')
		else:
			c.execute('insert into amostra (idsensor_fk,valor) values (\''+str(item[0])+'\',\''+str(umi)+'\')')
	con.commit()
	con.close()

 
def plaintext(texto):
	linha="\nSN: "+b2a_hex(texto['source_addr_long'])+"\nCampos do frame(lumi/temp/humi): "+str(texto['samples'][0]['adc-1'])+"/"+str(texto['samples'][0]['adc-2'])+"/"+str(texto['samples'][0]['adc-3'])
	arq.write(linha)

if __name__ == '__main__':
	ser = serial.Serial('/dev/ttyAMA0', 9600)

	# Use an XBee 802.15.4 device
	# To use with an XBee ZigBee device, replace with:
	xbee = ZigBee(ser)
	#xbee = XBee(ser)
	while(1):
		try:
			print "lendo frame"
			texto = xbee.wait_read_frame()
			print "frame: ",texto
			plaintext(texto)
			print "conectando com o banco de dados"
			banco(str(b2a_hex(texto['source_addr_long'])),str(texto['samples'][0]['adc-1']),str(texto['samples'][0]['adc-2']),str(texto['samples'][0]['adc-3']))
			print "Done"
		except KeyboardInterrupt:
			arq.close()
			ser.close()

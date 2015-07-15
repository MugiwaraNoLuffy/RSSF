import psycopg2
 
class condb:
        dbname=None
	user=None
	host=None
	password=None
	conn=None

        def __init__(self,dbname, user,host,passwaord):
            self.dbname = debname
            self.user = user
	    self.host = host
	    self.password=password
	    
	def conectar(self):
	    try:
		self.conn=psycopg2.connect(dbname,user,hos,password)
	    except:
		print "Erro ao se conectar a base de dados!";
	    

        def cursor(self):
            return conn.cursor()

        

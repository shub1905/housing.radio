import psycopg2
import json
import fnmatch
import os,eyed3

file_desc = open('config.json')
config = json.load(file_desc)
file_desc.close()

DB_NAME = config['psql']['DB_NAME']
DB_USER = config['psql']['DB_USER']
DB_HOST = config['psql']['DB_HOST']
DB_PORT = config['psql']['DB_PORT']
DB_PASS = config['psql']['DB_PASS']
file_type = str(config['file_type'])

def establish_conn():
	con_str = "dbname='%s' user='%s' host='%s' port=%d password='%s'" %(DB_NAME, DB_USER, DB_HOST, DB_PORT, DB_PASS)
	db_con = psycopg2.connect(con_str)
	return db_con

def insert_in_db(db_con):
	#db handle
	cursor = db_con.cursor()

	#file listing
	for root, dirnames, filenames in os.walk('Music'):
		for filename in fnmatch.filter(filenames, file_type):
			music_file = os.path.join(root, filename)
			try:
				file = eyed3.core.load(music_file)
				album = file.tag.album
				artist = file.tag.artist
				title = file.tag.title
				cursor.execute("""insert into songs (name, album, artist, path) values (%s, %s, %s, %s);""",(title,album,artist,music_file))
				db_con.commit()
			except Exception as e:
				print e
	cursor.close()
	db_con.close()

def main():
	db_con = establish_conn()
	insert_in_db(db_con)

if __name__ == "__main__":
	main()
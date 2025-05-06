import psycopg2
import requests

conn = psycopg2.connect(
	host = "pg.pg4e.com",
	port = "5432",
        database = "pg4e_c04386bfb5",
        user = "pg4e_c04386bfb5",
        password = "pg4e_p_461e2d1f4b1bebc",
        connect_timeout = 3
)

cur = conn.cursor()

sql = '''
CREATE TABLE IF NOT EXISTS pokeapi (
	id serial,
	body JSONB
);
'''
cur.execute(sql)

conn.commit()

for i in range(1,101):
	url = f'https://pokeapi.co/api/v2/pokemon/{i}'
	response = requests.get(url)
	text = response.text
	print("---", i, "---", url, "---", response.status_code)
	sql = "INSERT INTO pokeapi (body) VALUES (%s)"
	cur.execute(sql, (text, ))

conn.commit() 


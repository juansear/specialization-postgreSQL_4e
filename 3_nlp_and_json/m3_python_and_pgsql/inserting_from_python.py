cimport psycopg2
import hidden

# Load the secrets
secrets = hidden.secrets()

# Connect to the database
conn = psycopg2.connect(
  host = secrets['host'],
  port = secrets['port'],
  database = secrets['database'], 
  user = secrets['user'], 
  password = secrets['pass'], 
  connect_timeout = 3
)

cur = conn.cursor()

# Generate a series of python numbers
number = 289864
for i in range(300):
  # The idea is to start in 1 and not 0 
  print(i+1, number)
  sql = "INSERT INTO pythonseq (iter, val) VALUES (%s, %s);"
  cur.execute(sql, (i+1, number, ))
  # Save the changes in the Database every 50 iterations
  if (i+1) % 50 == 0:
    conn.commit()
    print(f"Commited at iteration {i+1}")
 
  # Next iteration value
  number = int((number * 22) / 7) % 1000000

# If any change is not committed, lets do it 
conn.commit()

conn.close()

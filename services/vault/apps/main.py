import os
import hvac
from dotenv import load_dotenv

load_dotenv()

client = hvac.Client()
client = hvac.Client(
 url=os.environ['VAULT_URL'],
 token=os.environ['VAULT_TOKEN']
)
client.write('secret/snakes', type='pythons', lease='1h')
print(client.read('secret/snakes'))

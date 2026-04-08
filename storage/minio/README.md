1. Prepare mc buckets & objects
```bash
mc mb local/first
mc mb local/second

echo "Hello world" | mc pipe local/first/hello/world.txt
echo "My name is dungdm93" | mc pipe local/first/i_am/dungdm93.txt
echo "farewell" | mc pipe local/second/farewell.txt
```

2. Create users
```bash
mc admin user add local dungdm93 dungdm93
mc admin user add local trangpth trangpth

mc config host add dungdm93 http://minio:9000 dungdm93 dungdm93
mc config host add trangpth http://minio:9000 trangpth trangpth

mc config host list
```

3. Policy
```bash
mc admin policy list --json local

# Create policy
mc admin policy add  local/ dungdm93-policy dungdm93.json
mc admin policy info local/ dungdm93-policy

# Policy binding
mc admin policy set local dungdm93-policy user=dungdm93

# Test
mc cat dungdm93/first/hello/world.txt
echo "Hello there" | mc pipe dungdm93/first/hello/there.txt
```

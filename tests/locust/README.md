[`locust`](https://locust.io/)
==============================

## 1. Setup
* Install `locustio`
    ```bash
    pip install locustio
    ```

* Write test script in python file, default: `locustfile.py`

## 2. Run test
```bash
locust --host=http://example.com -f script.py 

# or with locustfile.py
locust --host=http://example.com
```

then open Locust’s web interface at http://localhost:8089

`prometheus`
============

## 1. Quizzes
1. Run Jupyter
```bash
docker run -d --rm \
    -v $PWD/scripts:/usr/local/bin/start-notebook.d \
    -v $PWD:/home/jovyan/work \
    -e JUPYTER_ENABLE_LAB=yes \
    -p 8888:8888 \
    jupyter/minimal-notebook
```

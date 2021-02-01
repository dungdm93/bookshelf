SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:SuperSecr3t@postgres:5432/superset'

class CeleryConfig(object):
    BROKER_URL = 'redis://redis:6379/0'
    CELERY_IMPORTS = (
        'superset.sql_lab',
        'superset.tasks',
    )
    CELERY_RESULT_BACKEND = 'redis://redis:6379/1'

CELERY_CONFIG = CeleryConfig

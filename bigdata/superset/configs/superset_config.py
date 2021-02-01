from cachelib.redis import RedisCache
from celery.schedules import crontab

LOG_LEVEL = 'DEBUG'

SUPERSET_WEBSERVER_PROTOCOL = 'http'
SUPERSET_WEBSERVER_ADDRESS = '0.0.0.0'
SUPERSET_WEBSERVER_PORT = 8088
ENABLE_PROXY_FIX = True
SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:SuperSecr3t@postgres:5432/superset'
WEBDRIVER_BASEURL = 'http://superset-webserver:8088/'

# ===== Celery =====

class CeleryConfig:
    BROKER_URL = 'redis://redis:6379/0' # _kombu.binding.
    CELERY_IMPORTS = (
        'superset.sql_lab',
        'superset.tasks',
        'superset.tasks.thumbnails',
    )
    CELERY_RESULT_BACKEND = 'redis://redis:6379/1'  # celery-task-meta-
    CELERYD_LOG_LEVEL = 'INFO'
    CELERYD_PREFETCH_MULTIPLIER = 10
    CELERY_ACKS_LATE = True
    CELERY_ANNOTATIONS = {
        'sql_lab.get_sql_results': {
            'rate_limit': '100/s'
        },
        'email_reports.send': {
            'rate_limit': '1/s',
            'time_limit': 120,
            'soft_time_limit': 150,
            'ignore_result': True,
        },
    }
    CELERYBEAT_SCHEDULE = {
        'email_reports.schedule_hourly': {
            'task': 'email_reports.schedule_hourly',
            'schedule': crontab(minute=1, hour='*'),
        },
        'cache-warmup-hourly': {
            'task': 'cache-warmup',
            'schedule': crontab(minute=0, hour='*'),  # hourly
            'kwargs': {
                'strategy_name': 'top_n_dashboards',
                'top_n': 5,
                'since': '7 days ago',
            },
        },
    }


CELERY_CONFIG = CeleryConfig
RESULTS_BACKEND = RedisCache(host='redis', port=6379, db=2, key_prefix='superset.results.')

# ===== Caching =====
# https://flask-caching.readthedocs.io/en/latest/#configuring-flask-caching

# Caching for Superset's own metadata
CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24,  # 1 day
    'CACHE_KEY_PREFIX': 'superset.metadata.',
    'CACHE_REDIS_URL': 'redis://redis:6379/3',
}

# Caching for charting data queried from datasources
DATA_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24,  # 1 day
    'CACHE_KEY_PREFIX': 'superset.query.',
    'CACHE_REDIS_URL': 'redis://redis:6379/4',
}

THUMBNAIL_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24,  # 1 day
    'CACHE_KEY_PREFIX': 'superset.thumbnail.',
    'CACHE_REDIS_URL': 'redis://redis:6379/5',
}

# ===== Optional Feature =====
FEATURE_FLAGS = {
    'THUMBNAILS': True,
    'THUMBNAILS_SQLA_LISTENERS': True,
}

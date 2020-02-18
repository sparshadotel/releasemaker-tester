""" Datamegh package. """
from os import environ
from logging import INFO, DEBUG, ERROR, WARNING, CRITICAL


name = "datamegh"
version = '-prerelease'

log_level_map = {
    "info": INFO,
    "debug": DEBUG,
    "error": ERROR,
    "warning": WARNING,
    "critical": CRITICAL,
}
config = {
    "logging": {
        "level": log_level_map.get(environ.get("LOG_LEVEL")) or DEBUG,
        "format": "%(asctime)s - [ %(levelname)s ] %(name)s - %(message)s",
    }
}

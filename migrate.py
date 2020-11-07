#!/usr/bin/env python

import logging;
logging.basicConfig(level=logging.DEBUG);

from core import migrations;
migrations.perform()

from core import indexes;
indexes.create_indexes()

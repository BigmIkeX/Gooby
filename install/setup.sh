#!/bin/bash

sudo rsync -a /opt/GooPlex/install/gooplex /bin
sudo chmod 755 /bin/gooplex
sudo chown -R plexuser:plexuser /opt/GooPlex
gooplex

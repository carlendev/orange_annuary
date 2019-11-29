#!/bin/bash

hhvm -m server -p 5000 -d hhvm.server.default_document="src/index.hack" 

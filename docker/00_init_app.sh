#!/bin/bash

bundle exec rails db:migrate:primary

bundle exec rails s -p 3000 -b '0.0.0.0'

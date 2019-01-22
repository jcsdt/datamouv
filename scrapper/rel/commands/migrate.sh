#!/bin/sh

release_ctl eval --mfa "Scrapper.ReleaseTasks.migrate/1" --argv -- "$@"

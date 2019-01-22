#!/bin/sh

release_ctl eval --mfa "Server.ReleaseTasks.migrate/1" --argv -- "$@"

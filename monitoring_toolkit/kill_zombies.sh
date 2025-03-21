#!/bin/bash

ZOMBIES=$(ps aux | awk '{if ($8=="Z") print $2}')

if [ -n "$ZOMBIES" ]; then
    echo "Killing zombie processes: $ZOMBIES"
    kill -9 $ZOMBIES
    echo "[$(date)] Zombie processes killed: $ZOMBIES" >> heal.log
fi

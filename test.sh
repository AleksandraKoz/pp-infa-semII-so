#!/bin/bash


lower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}


args=""
for arg; do
    args="${args} $(lower "$arg")"
done


echo "$args"
#!/bin/bash


./flink-1.14.3/bin/flink run -py process_movies.py -pyclientexec “path_to\python.exe” -pyexec “path_to\python.exe” -—output “path_to\out.txt” --input "path_to\input.txt"
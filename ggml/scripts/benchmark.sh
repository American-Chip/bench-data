#!/bin/bash

THREAD_COUNTS=($(seq 1 16))

OPT_FLAG="$HACO_OPT_FLAG"
COMPILER="$HACO_COMPILER"
USE_SUPEROPTIMIZER="$HACO_SUPEROPTIMIZER"
USE_INTRINSICS="$HACO_INTRINSICS"

declare -a times=()
for THREADS in "${THREAD_COUNTS[@]}"; do
    times=()  # Clear the times array for each thread count
    # Run the command 5 times
    for i in {1..5}; do
        current_time=$( (../build/bin/gpt-j -t $THREADS -m ../build/models/gpt-j-6B/ggml-model.bin -p "This is an example") 2>&1 | grep -oP '[0-9]+(\.[0-9]+)?(?= ms per token)')
        # echo "Run $i time: $current_time"
        times+=("$current_time")
    done

    # Sort the times and remove the highest and lowest values
    sorted_times=( $(printf '%s\n' "${times[@]}" | sort -n) )
    unset sorted_times[0]       # Remove the lowest value
    unset sorted_times[${#sorted_times[@]}-1]  # Remove the highest value

    # Sum the remaining times
    total_time=0
    for time in "${sorted_times[@]}"; do
        total_time=$(echo "$total_time + $time" | bc -l)
    done

    # Calculate the average, divide by 3 since we removed 2 outliers from 5 runs
    average_time=$(echo "$total_time / 3" | bc -l)

    echo "Threads: $THREADS, Intrinsics ${USE_SUPEROPTIMIZER}, SuperOptimizer ${USE_INTRINSICS} With ${COMPILER}, Optimization Flag: $OPT_FLAG | Average time: $average_time" >> benchmark.log


done

echo $average_time


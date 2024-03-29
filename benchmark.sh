#/usr/bin/env bash
FORMAT="%C %E %M"
# RTS="+RTS -N -RTS"
RTS=""
for bench in Lists Octonions Regex ListMonad HugeLists; do
    echo "Building $bench..."
    BRES=$(cabal build && cabal exec -- ghc benchmarks/$bench.hs -O2 -o $bench)
done

# We timeout after 1 hour.
TIMEOUT=3600

echo "Timing QuickSpec..."
for bench in Lists Octonions Regex ListMonad; do
    RES=$(/usr/bin/time --output=timed --format="$FORMAT" timeout $TIMEOUT ./$bench 7 $RTS | tail -n 1)
    TIMERES=$(cat timed)
    echo "$TIMERES $RES"
done
# HugeLists 7 3 runs out of memory and swap after 4 hours 6 minutes
# HugeLists 6 4 runs for >18.5 hours 
for s in 3 4 5;  do
    RES=$(/usr/bin/time --output=timed --format="$FORMAT" timeout $TIMEOUT ./HugeLists $s $RTS | tail -n 1)
    TIMERES=$(cat timed)
    echo "$TIMERES $RES"
done


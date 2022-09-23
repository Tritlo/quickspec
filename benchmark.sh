#/usr/bin/env bash
FORMAT="%C %E %M"
# RTS="+RTS -N -RTS"
RTS=""
for bench in Lists Octonions Regex ListMonad HugeLists; do
    echo "Building $bench..."
    BRES=$(cabal build && cabal exec -- ghc examples/$bench.hs -O2 -o $bench)
done

# We timeout after 1 hour.
TIMEOUT=3600

echo "Timing QuickSpec..."
for bench in Lists Octonions Regex ListMonad; do
    RES=$(/usr/bin/time --output=timed --format="$FORMAT" timeout $TIMEOUT ./$bench 7 $p $RTS | grep ' = ' | wc -l)
    TIMERES=$(cat timed)
    echo "$TIMERES $RES"
done

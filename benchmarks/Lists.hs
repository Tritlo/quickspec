-- Some usual list functions.
{-# LANGUAGE ScopedTypeVariables, ConstraintKinds, RankNTypes, ConstraintKinds, FlexibleContexts #-}
import QuickSpec
import QuickSpec.Internal (quickSpecResult)
import System.Environment (getArgs)

main = do
  [s] <- map read <$> getArgs
  res <- quickSpecResult $ [
    withMaxTermSize s,
    con "reverse" (reverse :: [A] -> [A]),
    con "++" ((++) :: [A] -> [A] -> [A]),
    con "[]" ([] :: [A]),
    con "map" (map :: (A -> B) -> [A] -> [B]),
    con "length" (length :: [A] -> Int),
    con "concat" (concat :: [[A]] -> [A]),

    -- Add some numeric functions to get more laws about length.
    arith (Proxy :: Proxy Int) ]
  print (length res)

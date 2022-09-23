-- The monad laws for lists.
import Control.Monad
import QuickSpec
import QuickSpec.Internal (quickSpecResult)
import System.Environment (getArgs)

main = do
  [s] <- map read <$> getArgs
  res <- quickSpecResult $ [
    withMaxTermSize s,
    withMaxTestSize 20,
    con "return" (return :: A -> [A]),
    con ">>=" ((>>=) :: [A] -> (A -> [B]) -> [B]),
    con "++" ((++) :: [A] -> [A] -> [A]),
    con ">=>" ((>=>) :: (A -> [B]) -> (B -> [C]) -> A -> [C]) ]
  print (length res)

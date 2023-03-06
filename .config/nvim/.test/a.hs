import Prelude hiding (sum)

sum :: (Num a) => a -> a -> a
sum x y = x + y

x :: Integer
x = sum 1 23

main :: IO ()
main = do
  print x


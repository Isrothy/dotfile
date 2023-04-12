sum' :: (Num a) => a -> a -> a
sum' x y = x + y

x :: Integer
x = sum' 1 23

gcd' :: (Integral a) => a -> a -> a
gcd' x y = if y == 0 then x else gcd' y (x `mod` y)

main :: IO ()
main = do
  print x

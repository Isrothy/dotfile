sum' :: (Num a) => a -> a -> a
sum' x y = x + y

x :: Integer
x = sum' 1 23

gcd' :: (Integral a) => a -> a -> a
gcd' x y = if y == 0 then x else gcd' y (x `mod` y)

exGcd :: (Integral a) => a -> a -> (a, a, a)
exGcd x y =
  if y == 0
    then (x, 1, 0)
    else
      let (d, a, b) = exGcd y (x `mod` y)
       in (d, b, a - (x `div` y) * b)

powerMod :: (Integral a) => a -> a -> a -> a
powerMod x y m =
  if y == 0
    then 1
    else
      let t = powerMod x (y `div` 2) m
       in if even y
            then (t * t) `mod` m
            else ((t * t) `mod` m * x) `mod` m

inverse :: (Integral a) => a -> a -> a
inverse x m =
  let (_, a, _) = exGcd x m
   in (a + m) `mod` m

primes :: (Integral a) => a -> [a]
primes n = sieve [2 .. n]
  where
    sieve [] = []
    sieve (x : xs) = x : sieve (filter (\y -> y `mod` x /= 0) xs)

main :: IO ()
main = do
  print x

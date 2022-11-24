newtons :: Float -> Int -> (Float -> Float) -> (Float -> Float) -> Float
newtons x n f fprime = (iterate x n)
    where iterate :: Float -> Int -> Float
          iterate x 0 = x
          iterate x n = iterate (x - (f x) / (fprime x)) (n - 1)

main = do putStrLn $ show $ newtons 1.0 8 (\x -> x * x - 2) (\x -> 2 * x)

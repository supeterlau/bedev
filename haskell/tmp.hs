-- main = do
--   putStrLn "What' your name"
--   name <- getLine
--   putStrLn ("Hey " ++ name ++ ", you rock!")

class DummyMonad m where
  (>>>=) :: m a -> (a -> m b) -> m b

instance DummyMonad Maybe where
  Nothing >>>= func = Nothing
  Just val >>>= func = func val

half x = if even x
          then Just (x `div` 2)
          else Nothing

-- main = do
--   putStrLn (Just(10) >>>= half)

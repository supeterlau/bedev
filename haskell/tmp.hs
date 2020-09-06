main = do
  putStrLn "What' your name"
  name <- getLine
  putStrLn ("Hey " ++ name ++ ", you rock!")

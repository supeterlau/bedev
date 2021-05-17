#! /usr/bin/env runhugs +l
--
-- fibs.hs
-- Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
--
-- Distributed under terms of the MIT license.
--

-- module fibs where

fibs 0 = 1
fibs 1 = 1
fibs n = fibs (n-1) + fibs (n-2)

fibs1 n
  | n == 0 = 1
  | n == 1 = 1
  | otherwise = fibs1 (n-1) + fibs1 (n-2)

sort [] = []
sort (pivot:rest) = lesser ++ [pivot] ++ greater
  where
    lesser = sort $ filter (<pivot) rest 
    greater = sort $ filter (>=pivot) rest

main :: IO ()
main = print $ map fibs [1..10]


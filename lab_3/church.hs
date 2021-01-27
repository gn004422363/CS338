overrideZeroC = const id
overrideMultiC = (.)
overrideAddC = (<*>) . fmap (.)

overrideSucc = (<*>) (.)
getChurchIntValue :: Int -> ((a -> a) -> a -> a)
getChurchIntValue 0 = overrideZeroC
getChurchIntValue n = overrideSucc $ getChurchIntValue (n - 1)


getIntValue :: ((Int -> Int) -> Int -> Int) -> Int
getIntValue x = x succ 0

[cFive] = getChurchIntValue <$> [5]

churchAdd =  print $  getIntValue <$> [overrideAddC cFive cFive]
churchMulti = print $  getIntValue <$> [overrideMultiC cFive cFive]

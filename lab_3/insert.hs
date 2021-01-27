data Tree a = Empty | Node a (Tree a) (Tree a)
                    deriving (Show, Read, Eq)


searchTree :: (Ord a) => a -> Tree a -> Bool
searchTree x (Empty) = False
searchTree x (Node y left right)
    |y == x = True
    |y > x = searchTree x left
    |y < x = searchTree x right

tinsert :: (Ord a) => Tree a -> a -> Tree a
tinsert Empty a         = Node a Empty Empty
tinsert (Node a left right)b
    | b == a = Node a left right
    | b < a = Node a (tinsert left b) right
    | b > a = Node a left (tinsert right b)

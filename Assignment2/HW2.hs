-- Name: Dayton Dekam  (the only contributer)

module HW2
     where

{- 1. groupbyNTail - 10%-}
groupbyNTail :: [a] -> Int -> [[a]]
groupbyNTail [] n = []
groupbyNTail iL n = grouptailhelper iL n [] []
     where
          grouptailhelper :: [a] -> Int -> [a] -> [[a]] -> [[a]]
          grouptailhelper [] n bufsub buflists = reverse ((reverse bufsub) : buflists)
          grouptailhelper (x:xs) n bufsub buflists | (length bufsub) >=n = grouptailhelper xs n (x:[]) ((reverse bufsub):buflists)
                                                   | otherwise = grouptailhelper xs n (x:bufsub) buflists
-----------------------------------------------------------

{- 2.  elemAll and stopsAt  -  20% -}

{- (a)  elemAll - 10%-}
-- please don't include the myCatsLog list in your solution file. 
elemAll :: [a] -> [a] -> Bool
elemAll [] [] = True
elemAll (x:xs) [] = False
elemAll [] (y:ys) = True
elemAll (x:xs) (y:ys) = False

{- (b) stopsAt - 10%-}

-----------------------------------------------------------

{- 3. isBigger and applyRange - 25% -}

--define the Timestamp datatype
-- data Timestamp =  DATE (Int,Int,Int) |  DATETIME (Int,Int,Int,Int,Int) 
--                   deriving (Show, Eq)

{- (a)  isBigger - 15% -}

{- (b) applyRange - 10% -}


-----------------------------------------------------------
{-4 - foldTree, createRTree, fastSearch  - 35%-}

--define Tree and RTree data types
-- data Tree a = LEAF a | NODE a (Tree a) (Tree a)
--                deriving (Show,  Eq, Ord)

-- data RTree a = RLEAF a | RNODE a (a,a) (RTree a) (RTree a)
--                     deriving (Show, Eq, Ord)

{- (a) foldTree - 8% -}

{- (b) createRTree - 12% -}

{- (c) fastSearch - 15% -}

-------------------------------------------------------------------

{- Tree Examples 5% -}
-- include your tree examples in the test file. 

{-Testing your tree functions - 5%-}



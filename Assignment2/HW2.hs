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
elemAll :: (Eq a) => [a] -> [a] -> Bool
elemAll [] [] = True          -- nothing is within nothing
elemAll (x:xs) [] = False
elemAll [] (y:ys) = True      -- debatable, but assumes nothing is an element of y:ys
elemAll (x:xs) (y:ys) | (elem False (map (elemhelper (y:ys)) (x:xs)) == False) = True
                      | otherwise = False
     where
          elemhelper [] z = False
          elemhelper (x:xs) z | ((elem z (x:xs)) == True) = True
                              | otherwise = False
{- (b) stopsAt - 10%-}
--stopsAt :: (Eq x) => [[a]] -> [(x,y)] -> [[a]]    (can't use this signature due to rigit type errors)
stopsAt [] [] = []
stopsAt [] ((x,y):xs) = []
stopsAt (z:zs) ((x,y):xs) = map fst (filter (stopsAtHelper (z:zs)) ((x,y):xs)) 
     where
          stopsAtHelper (z:zs) (x,y) = elemAll (z:zs) y
-----------------------------------------------------------

{- 3. isBigger and applyRange - 25% -}

-- define the Timestamp datatype
data Timestamp =  DATE (Int,Int,Int) |  DATETIME (Int,Int,Int,Int,Int) 
                  deriving (Show, Eq)

{- (a)  isBigger - 15% -}
-- isBigger :: Timestamp -> Timestamp -> Bool
-- isBigger (DATE (x1,x2,x3)) (DATE (y1,y2,y3)) = False
-- isBigger (DATE (x1,x2,x3,x4,x5)) (DATE (y1,y2,y3)) = False
--isBigger (DATE (x1,x2,x3)) (DATE (y1,y2,y3,y4,y5)) = False
--isBigger (DATE (x1,x2,x3,x4,x5)) (DATE (y1,y2,y3,y4,y5)) = False

{- (b) applyRange - 10% -}


-----------------------------------------------------------
{-4 - foldTree, createRTree, fastSearch  - 35%-}

-- define Tree and RTree data types
data Tree a = LEAF a | NODE a (Tree a) (Tree a)
               deriving (Show,  Eq, Ord)

data RTree a = RLEAF a | RNODE a (a,a) (RTree a) (RTree a)
                    deriving (Show, Eq, Ord)

{- (a) foldTree - 8% -}
foldTree :: (t -> t -> t) -> Tree t -> t
foldTree op (LEAF v) = v
foldTree op (NODE t1 t2 t3) = op t1 (op (foldTree op t2) (foldTree op t3))

{- (b) createRTree - 12% -}
createRTree :: Ord t => Tree t -> RTree t
createRTree (LEAF v) = RLEAF v
createRTree (NODE op left right) = RNODE op value (createRTree left) (createRTree right)
                              where value = (foldTree min (NODE op left right), foldTree max (NODE op left right))

{- (c) fastSearch - 15% -}
fastSearch :: Ord t => RTree t -> t -> [([Char], t)]
fastSearch (RLEAF l) x = [("leaf", l)]
fastSearch n x = reverse (fastSearchHelper n x []) -- need a helper to pass in empty list to cons
     where
          fastSearchHelper (RLEAF l) x buf = [("leaf", l)]       -- if n is within the tupil range, keep traversing right and left while adding the current node
          fastSearchHelper (RNODE n (a, b) left right) x buf | ((x >= a) && (x <= b)) = (fastSearchHelper right x buf) ++ (fastSearchHelper left x buf) ++ [("node", n)] ++ buf
                                                             | otherwise = ("node", n) : buf 

-------------------------------------------------------------------

{- Tree Examples 5% -}
-- include your tree examples in the test file. 

{-Testing your tree functions - 5%-}



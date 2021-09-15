-- CptS 355 - Lab 1 (Haskell) - Spring 2021
-- Name: Dayton Dekam
-- Collaborated with: 

module Lab1
     where

-- 1.insert 
insert :: (Eq t1, Num t1) => t1 -> t2 -> [t2] -> [t2]
insert 0 item [] = item : []
insert n item [] = []
insert n item (x:xs) | (n == 0) = item : x : xs
                     | otherwise = x : (insert (n - 1) item xs)

-- 2. insertEvery
insertEvery :: (Eq t, Num t) => t -> a -> [a] -> [a]
insertEvery 0 item [] = item : []
insertEvery n item [] = []
insertEvery n item (x:xs) = helper n item (x:xs)
                            where 
                                 helper 0 item [] = item : []
                                 helper 0 item (x:xs) = item : x : (helper (n - 1) item xs)
                                 helper count item [] = []
                                 helper count item (x:xs) = x : (helper (count - 1) item xs)
-- 3. getSales

                                                  
-- 4. sumSales


-- 5. split
split :: Eq a => a -> [a] -> [[a]]
split delim [] = [[]]
split delim (x:xs) = splithelper delim (x:xs) []
                     where
                          splithelper delim [] buf = (reverse buf) : []
                          splithelper delim (x:xs) buf | (x == delim) = ((reverse buf) : splithelper delim xs [])  -- maybe one test has a mistake? Passes all except test 3 (results in one extra empty list)
                                                       | otherwise = splithelper delim xs (x:buf)


-- 6. nSplit


-- CptS 355 - Fall 2021 -- Homework1 - Haskell
-- Name: Dayton Dekam
-- Collaborators: N/A

module HW1
     where

-- Q1 everyOther
everyOther :: [a] -> [a]
everyOther [] = []
everyOther (x:xs) = helperEveryOther 1 (x:xs) -- pass in 1 as a flag
                    where
                         helperEveryOther n [] = []
                         helperEveryOther 0 (x:xs) = helperEveryOther 1 xs      -- given the 0 flag, skip to next
                         helperEveryOther 1 (x:xs) = x : helperEveryOther 0 xs  -- given the 1 flag, copy character into list

-- Q2(a) eliminateDuplicates
eliminateDuplicates :: Eq a => [a] -> [a]
eliminateDuplicates [] = []
eliminateDuplicates (x:xs) = x : (eliminateDuplicates (cleanList x (x:xs)))
                              where -- cleanList takes a list and a token "c" and returns the list without any elements matching "c"
                                   cleanList c [] = []
                                   cleanList c (x:xs) | (c == x) = cleanList c xs
                                                       | otherwise = x : (cleanList c xs)

-- Q2(b) matchingSeconds
matchingSeconds :: Eq t => t -> [(t, a)] -> [a]
matchingSeconds v [] = []
matchingSeconds v ((a, b):xs) | (a == v) = b : matchingSeconds v xs
                              | otherwise = matchingSeconds v xs

-- Q2(c) clusterCommon
clusterCommon :: (Eq t, Eq a) => [(t, a)] -> [(t, [a])]
clusterCommon [] = []
clusterCommon ((a, b):xs) = (a, eliminateDuplicates (matchingSeconds a ((a, b):xs))) : clusterCommon (eliminate a xs)
                              where     -- eliminate takes a list of tuples and a token "tok" and returns a list without any elements matching "tok"
                                   eliminate tok [] = []
                                   eliminate tok ((a, b):xs) | (a == tok) = eliminate tok xs
                                                            | otherwise = (a, b) : eliminate tok xs

-- Q3 maxNumCases
maxNumCases :: (Num p, Ord p, Eq t) => [(a, [(t, p)])] -> t -> p
maxNumCases [] month = 0 -- if the month doesn't exist, 0 cases are reported
maxNumCases ((a, b):xs) month = helperMaxCases 0 ((a, b):xs) month    -- cases are initialized to 0
                         where
                              helperMaxCases cases [] month = cases   -- at end of list, return cases found (0 if none found)
                                                                      -- cases are changed to largest found
                              helperMaxCases cases ((a, b):xs) month | ((checkCounty b month) > cases) = helperMaxCases (checkCounty b month) xs month
                                                                     | otherwise = helperMaxCases cases xs month
                                                                     where      -- checkCounty finds the month within the county's tuple and returns the cases
                                                                          checkCounty [] m = 0
                                                                          checkCounty ((a, b):xs) m | (a /= m) = checkCounty xs m
                                                                                               | otherwise = b

-- Q4 groupIntoLists
groupIntoLists :: [a] -> [[a]]
groupIntoLists [] = []
groupIntoLists (x:xs) = helperGroupIntoLists 1 (x:xs) []   -- 1 is the starting value of the "n" parameter
                         where                             -- n represents the size of the list to return, and is decremented until 0 at each element
                              helperGroupIntoLists n [] buf = [reverse buf]  -- at the end of list, return the buffer (remaining elements) regardless of n
                              helperGroupIntoLists n (x:xs) buf | (n == 0) = ((reverse buf) : helperGroupIntoLists ((size buf) + 1) (x:xs) []) 
                                                                | otherwise = helperGroupIntoLists (n - 1) xs (x:buf)
                                                                 where
                                                                      size [] = 0
                                                                      size (x:xs) = 1 + (size xs)

-- Q5 getSlice 
getSlice :: Eq a => (a, a) -> [a] -> [a]
getSlice (a, b) [] = []
getSlice (a, b) (x:xs) = cutHead (a, b) (x:xs) -- first must get the rest of the list after the delimiter "a"
                         where
                              cutHead (a, b) [] = []
                              cutHead (a, b) (x:xs) | (x == a) = cutTail b xs []     -- then stop at the second delimiter "b"
                                                      | otherwise = cutHead (a, b) xs
                                                      where
                                                           cutTail b [] [] = []
                                                           cutTail b [] buf = reverse buf
                                                           cutTail b (x:xs) buf | (x == b) = reverse buf
                                                                                | otherwise = cutTail b xs (x:buf)

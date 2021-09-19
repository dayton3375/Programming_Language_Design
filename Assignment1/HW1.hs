-- CptS 355 - Fall 2021 -- Homework1 - Haskell
-- Name:
-- Collaborators: 

module HW1
     where

-- Q1 everyOther
everyOther :: [a] -> [a]
everyOther [] = []
everyOther (x:xs) = helperEveryOther 1 (x:xs)
                    where
                         helperEveryOther n [] = []
                         helperEveryOther 0 (x:xs) = helperEveryOther 1 xs
                         helperEveryOther 1 (x:xs) = x : helperEveryOther 0 xs

-- Q2(a) eliminateDuplicates
eliminateDuplicates :: Eq a => [a] -> [a]
eliminateDuplicates [] = []
eliminateDuplicates (x:xs) = helperEliminateDuplicates (x:xs)
                             where
                                  helperEliminateDuplicates [] = []
                                  helperEliminateDuplicates (x:xs) = x : (helperEliminateDuplicates (cleanList x (x:xs)))
                                                                     where
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
clusterCommon ((a, b):xs) = helperClusterCommon ((a, b):xs)
                            where
                                 helperClusterCommon [] = []
                                 helperClusterCommon ((a, b):xs) = (a, (matchingSeconds a ((a, b):xs))) : helperClusterCommon (eliminate a xs)
                                                                   where
                                                                        eliminate tok [] = []
                                                                        eliminate tok ((a, b):xs) | (a == tok) = eliminate tok xs
                                                                                                  | otherwise = (a, b) : eliminate tok xs

-- Q3 maxNumCases


-- Q4 groupIntoLists


-- Q5 getSlice 



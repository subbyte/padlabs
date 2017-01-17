--------------------------------------------------------------------
--
-- Shingling by Line (Haskell version)
--
-- Functionality: generate shingles (n-grams) from a sequence of
--      items, e.g., system call trace
--
-- Input example (lines in the input file):
--      sysa
--      sysb
--      sysc
--      sysd
-- Output example (lines in the output file):
--      sysa:sysb:sysc
--      sysb:sysc:sysd
--
-- Copyright : (c) Xiaokui Shu
-- Email : xiaokui.shu@ibm.com
-- License : GPLv3
--
--------------------------------------------------------------------

module Main where

import Data.List
import Control.Exception
import System.Environment
import System.IO
import System.IO.Error

shiftLists :: Int -> [String] -> [[String]]
shiftLists shglen items@(x:xs)
    | shglen <= 0           = []
    | length items == 2     = [items]
    | otherwise             = items:shiftLists (shglen-1) xs

generateSHG :: Int -> String -> [String] -> [String]
generateSHG shglen splitter items =
    map (intercalate splitter) .
    filter (\shg -> length shg == shglen) .
    transpose .
    shiftLists shglen
    $ items

ioMain :: IO ()
ioMain = do
    filepath:shglenString:opArgs <- getArgs
    syscalls <- readFile filepath
    writeFile (filepath ++ "." ++ shglenString) $
        unlines .
        generateSHG (read shglenString) (if null opArgs then ":" else head opArgs) .
        lines
        $ syscalls

handler :: IOError -> IO ()
handler e = do
    putStrLn "Usage:"
    putStrLn "  ./shingling syslist n [splitter]"
    putStrLn "    syslist (string): filename/path of the input list"
    putStrLn "    n (integer): the length of shingles"
    putStrLn "    splitter (string): splitter between output shingles, by default \":\""
    putStrLn "Output:"
    putStrLn "  file syslist.n containing all shingles"

main = catch ioMain handler

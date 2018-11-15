import System.Console.ANSI

-- COLOR OUTPUT
main = do
    setSGR [SetConsoleIntensity BoldIntensity]
    setSGR [SetColor Foreground Vivid Green]
    putStr "\n\nH "
    setSGR [SetColor Foreground Vivid Red]
    putStr "E "
    setSGR [SetColor Foreground Vivid Blue]
    putStr "L "
    setSGR [SetColor Foreground Vivid Magenta]
    putStr "L "
    setSGR [SetColor Foreground Vivid Yellow]
    putStr "O\n\n"

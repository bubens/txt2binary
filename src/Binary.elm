module Binary exposing (fromInt)


fromInt : Int -> String
fromInt x =
    maxMultiple x 1
        |> toFloat
        |> fromIntHelper "" x


maxMultiple : Int -> Int -> Int
maxMultiple x multiple =
    if 2 * multiple > x then
        multiple

    else
        maxMultiple x (2 * multiple)


fromIntHelper : String -> Int -> Float -> String
fromIntHelper s x multiple =
    if multiple == 1 then
        if x == 0 then
            s ++ "0"

        else
            s ++ "1"

    else
        let
            ratio =
                toFloat x / multiple
        in
        if ratio >= 1 then
            fromIntHelper (s ++ "1") (x - round multiple) (multiple / 2)

        else
            fromIntHelper (s ++ "0") x (multiple / 2)

module Main exposing (main)

import Binary
import Browser exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Url



-- TYPES


type alias Document msg =
    { title : String
    , body : List (Html msg)
    }


type Msg
    = Noop
    | Input String



-- UTILS


darkBackgroundColor : Element.Color
darkBackgroundColor =
    rgb255 34 40 49


brightBackgroundColor : Element.Color
brightBackgroundColor =
    rgb255 57 62 70


textColor : Element.Color
textColor =
    rgb255 238 238 238


colorColor : Element.Color
colorColor =
    rgb255 214 90 49


withTitle : String -> List (Html msg) -> Document msg
withTitle title body =
    Document title body



-- MODEL


type alias Model =
    String

-- INIT


init : ( Model, Cmd msg )
init =
    ( "", Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        Input str ->
            ( str, Cmd.none )



-- VIEW


viewTextColumn : List String -> Element.Element msg
viewTextColumn paragraphs =
    textColumn
        [ width <| fill
        , Font.size 16
        , Font.justify
        , Font.light
        , paddingXY 0 5
        ]
        (List.map
            (\p ->
                paragraph
                    [ width <| fill ]
                    [ text p ]
            )
            paragraphs
        )


viewHeader : Element.Element msg
viewHeader =
    row
        [ Font.size 28
        , Font.color colorColor
        , width <| fill
        , paddingEach
            { top = 20
            , right = 20
            , left = 20
            , bottom = 0
            }
        ]
        [ el
            [ centerX
            , width <| fill
            , Border.widthEach
                { bottom = 3
                , left = 0
                , right = 0
                , top = 0
                }
            ]
            (text "Übung: Im Computer ist alles Zahlen")
        ]


viewExplanation : Element.Element msg
viewExplanation =
    let
        explanation =
            [ "Computer können mit Text, Bildern und Tönen nichts anfangen. Computer verstehen nur Zahlen. Alles was du auf dem Monitor siehst und liest, alles was du aus den Kopfhörern hörst und alles andere was der Computer aus den Ausgabe-Geräten spuckt: für den Computer sind das alles nur Zahlen. Erst die Ausgabe-Geräte machen aus Zahlen wieder Töne, Bilder und Text."
            , "Andersrum wird alles was du über die Eingabe-Geräte in einen Computer eingibst erst zu Zahlen umgewandelt bevor der Computer etwas damit anfangen kann. Die Soundkarte macht aus deiner Stimme eine lange Reihe aus Zahlen. Die Webcam macht aus den Bildern die du damit machst Zahlen und auch den Text den du über die Tastatur eingibst sind für den Computer nichts als Zahlen."
            , "Auf dieser Seite kannst du sehen wie Text für einen Computer aussieht. Gebe in das oberste Fenster einen beliebigen Text ein. In den unteren Fenstern erscheinen dann die Zahlen mit denen der Computer etwas anfangen kann."
            ]
    in
    row
        [ width fill
        , paddingXY 20 5
        ]
        [ viewTextColumn explanation ]


viewInput : Model -> Element.Element Msg
viewInput str =
    let
        placeholder =
            Input.placeholder
                []
                (text "Dein Text...")

        label =
            Input.labelAbove
                [ Font.size 16
                , width fill
                , Font.color colorColor
                , Border.widthEach
                    { bottom = 2
                    , top = 0
                    , left = 0
                    , right = 0
                    }
                ]
                (text "Dein Text:")
    in
    row
        [ paddingXY 20 10
        , width <| fill
        ]
        [ Input.multiline
            [ width <| fill
            , height <| px 100
            , Font.size 16
            , Font.color colorColor
            , paddingXY 5 5
            ]
            { onChange = Input
            , text = str
            , placeholder = Just placeholder
            , label = label
            , spellcheck = False
            }
        ]


viewAscii : Model -> Element Msg
viewAscii string =
    let
        explanation =
            [ "Jeder Buchstaben, Zahl und Satzzeichen in deinem Text wandelt der Computer in eine Zahl um. Hier kannst\n-                du die Zahlen sehen die zu den Buchstaben in deinem Text gehören."
            ]

        asciiString =
            string
                |> String.foldr
                    (\char list ->
                        Char.toCode char :: list
                    )
                    []
                |> List.foldl
                    (\code str ->
                        str ++ String.fromInt code ++ "   "
                    )
                    ""

        placeholder =
            Input.placeholder
                []
                (text "Ascii-Codes...")

        label =
            Input.labelHidden
                "Ascii.Codes"

        asciiCodes =
            Input.multiline
                [ width <| fill
                , height <| px 100
                , Font.size 16
                , Font.color colorColor
                , paddingXY 5 5
                ]
                { onChange = \_ -> Noop
                , text = asciiString
                , placeholder = Just placeholder
                , label = label
                , spellcheck = False
                }
    in
    column
        [ width <| fill
        , paddingXY 20 10
        ]
        [ el
            [ Font.size 16
            , Font.color colorColor
            , width fill
            , Border.widthEach
                { bottom = 2
                , left = 0
                , right = 0
                , top = 0
                }
            ]
            (text "Ascii-Zeichen:")
        , viewTextColumn explanation
        , asciiCodes
        ]


viewBinary : Model -> Element Msg
viewBinary string =
    let
        explanation =
            [ "Um ehrlich zu sein: Computer können auch mit den Zahlen wie sie oben stehen nichts anfagen. Computer kennen nämlich eigentlich nur die Zahlen 0 und 1. Mit dem sogenannten Binären System können Computer alle anderen Zahlen aus Nullen und Einsen zusammen bauen. Hier kannst du sehen wie die Zahlen die zu den Buchstaben in deinem Text gehören in Binärcode aussehen."
            ]

        binaryString =
            string
                |> String.foldr
                    (\char list ->
                        Char.toCode char ::  list
                    )
                    []
                |> List.foldl
                    (\x str ->
                        let
                            binStr =
                                Binary.fromInt x
                                    |> String.padLeft 8 '0'
                        in
                        str ++ binStr ++ "   "
                    )
                    ""

        placeholder =
            Input.placeholder
                []
                (text "Binäre Darstellung...")

        label =
            Input.labelHidden
                "Binäre Darstellung"

        binaryCodes =
            Input.multiline
                [ width <| fill
                , height <| px 100
                , Font.size 16
                , Font.color colorColor
                , paddingXY 5 5
                ]
                { onChange = \_ -> Noop
                , text = binaryString
                , placeholder = Just placeholder
                , label = label
                , spellcheck = False
                }
    in
    column
        [ width <| fill
        , paddingXY 20 10
        ]
        [ el
            [ Font.size 16
            , Font.color colorColor
            , width fill
            , Border.widthEach
                { bottom = 2
                , left = 0
                , right = 0
                , top = 0
                }
            ]
            (text "Binäre Darstellung:")
        , viewTextColumn explanation
        , binaryCodes
        ]


view : Model -> Document Msg
view model =
    column
        [ width <| px 920
        , height <| fill
        , Background.color darkBackgroundColor
        , centerX
        , Border.widthXY 2 0
        , Border.color colorColor
        , Border.glow colorColor 1.0
        ]
        [ viewHeader
        , viewExplanation
        , viewInput model
        , viewAscii model
        , viewBinary model
        ]
        |> Element.layout
            [ Background.color brightBackgroundColor
            , Font.color textColor
            ]
        |> List.singleton
        |> withTitle "Übung: Im Computer ist alles Zahlen"



-- MAIN


main : Program () Model Msg
main =
    Browser.document
        { init = always init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }

import Html exposing (Html, Attribute, div, input, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Json.Decode exposing (..)
import Json.Decode.Extra exposing (..)
import Maybe as Maybe

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- genericDecode decoder payload =
--   case decodeValue decoder payload of
--     Ok val -> val
--     Err message -> genericError message

-- -- TODO: fix this
-- genericError msg = {}

-- decodePersons : Value -> List Person
-- decodePersons payload = genericDecode personsDecoder payload

-- decodePerson : Value -> Person
-- decodePerson payload = genericDecode personDecoder payload


-- personsDecoder : Decoder (List Person)
-- personsDecoder = Json.Decode.list personDecoder

-- personDecoder : Decoder Person
-- personDecoder =
--   succeed Person
--     |: ("name" := string)
--     |: ("id" := int)

-- MODEL

type alias Person =
  { id : Int
  , name : String
  }

type alias Model =
  { persons : List Person
  , selectedPersonId : Maybe Int
  }

model : Model
model =
  { persons = fetchPersons
  , selectedPersonId = Nothing }

fetchPersons : List Person
fetchPersons = --- decodePersons """[ {name: whatever, id: 1}, {name: derp, id: 2}]"""
  [Person 1 "whatever", Person 2 "derp"]

-- UPDATE

type Msg
  = Search String
  | SelectPerson Int

update : Msg -> Model -> Model
update msg model =
  case msg of
    Search term ->
      { model | persons = List.filter (\person -> String.contains term person.name) fetchPersons }
    SelectPerson id ->
      { model | selectedPersonId = Just id }

-- VIEW

personList ps =
  Html.ul [ personListStyle ] (List.map personListElement ps)

personListStyle =
  style
    [ ("list-style", "none")
    ]

personListElement p = Html.li [onClick (SelectPerson p.id)] [text p.name]

view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "search persons", onInput Search ] []
    , personList model.persons
    -- , Html.p [] [(Maybe.withDefault 0 model.selectedPersonId)]
    ]

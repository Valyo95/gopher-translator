Gopher Translator
==========

Gopher translator is a simple web server that implements these requirements: [gopher-transaltor-requirements](./gopher-transaltor-requirements.pdf).

API
----------------------
Gopher translator provides with a rest API of the following:
* POST on `/word/`: translates a given english word into a gopher word
* POST on `/sentence/`: translates whole english sentence into a gopher sentence
* GET on `/history`: return each English word or sentence that was given to the server from the time the server was started along with its translation in gopher language


Translation
----------------------
The language that the gophers speak is a modified version of English and has a few simple rules:

1. If a word starts with a vowel letter, add the prefix “g” to the word (ex. apple => gapple)
2. If a word starts with the consonant letters “xr”, add the prefix “ge” to the begging of the word. Such words as “xray” actually sound in the beginning with vowel sound as you pronounce them so a true gopher would say “gexray”.
3. If a word starts with a consonant sound, move it to the end of the word and then add “ogo” suffix to the word. Consonant sounds can be made up of multiple consonants, a.k.a. a consonant cluster (e.g. "chair" -> "airchogo”).
4. If a word starts with a consonant sound followed by "qu", move it to the end of the word, and then add "ogo" suffix to the word (e.g. "square" -> "aresquogo").


Translating Implementation
----------------------
The gopher translator uses a simple method `func TranslateWord(word string) string` to translate each of the given words
that can be found in the [translate.go](./translator/translate.go) file. 

In order to do this there exists the [stringutil.go](./stringutil/stringutil.go) which provides the user
with some basic string utility methods like:

```go
func IsNumeric(s string) bool 
func StartsWithAVowel(word string) bool
func StartsWithXR(word string) bool
func StartsWithConsonant(word string) (bool, *regexp.Regexp)
func StartsWithConsonantFollowedByString(word string, str string)
func SplitSentenceIntoWords(sentenceRequest domain.SentenceRequest) []string
func TrimSuffix(s, suffix string) string
```

Server Implementation
----------------------
The app uses the [gorrila/mux](https://github.com/gorilla/mux) package to implement the proper routing of the incoming
requests and their respective handlers.

The executable program can accept one command line argument `--port` which is the port that the server is running.
If no port is given then the default 8080 is used.

Build & Run
----------------------
A [Makefile](Makefile) has been created in order to make the building of the program easier.

Clean the project:
    
    make clean

Build the application:

    make build  # build an executable named 'gopher-translator'

Run unit test and create a `coverage.out` file that can be viewed as HTML with the following command `go tool cover -html=covererage.out`: 

    make test


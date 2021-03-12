 # Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
COVERAGE_FILE=coverage.out
COVER_PROFILE=-coverprofile=$(COVERAGE_FILE)
BINARY_NAME=gopher-translator

all: test build
build:
	$(GOBUILD) -o $(BINARY_NAME) -v
test:
	$(GOTEST) -v ./... $(COVER_PROFILE)
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME) $(COVERAGE_FILE)

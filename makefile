ORG_FILES := $(wildcard $(CURDIR)/org/*.org)
MD_FILES := $(patsubst $(CURDIR)/org/%.org, $(CURDIR)/temp/%.md, $(ORG_FILES))

.PHONY: all
all: $(MD_FILES)

$(CURDIR)/temp/%.md: $(CURDIR)/org/%.org
	emacsclient -e "(holy/publish_md \"$<\")"

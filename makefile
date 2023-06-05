ORG_DIR := $(CURDIR)/org
TEMP_DIR := $(CURDIR)/temp

ORG_FILES := $(wildcard $(ORG_DIR)/*.org)
MD_FILES := $(patsubst $(ORG_DIR)/%.org, $(TEMP_DIR)/%.md, $(ORG_FILES))

.PHONY: all
all: clean $(MD_FILES)

clean:
	rm -rf $(CURDIR)/content/posts

$(TEMP_DIR)/%.md: $(ORG_DIR)/%.org
	@if [ ! -e $@ ] || [ $< -nt $@ ]; then \
		emacsclient -e "(holy/publish_md \"$<\")"; \
	fi

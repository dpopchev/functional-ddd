MAKEFLAGS += --warn-undefined-variables

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

.DELETE_ON_ERROR:
.SUFFIXES:

.DEFAULT_GOAL := help

.PHONY: help ### show this menu
help:
	@sed -nr '/#{3}/{s/\.PHONY:/--/; s/\ *#{3}/:/; p;}' ${MAKEFILE_LIST}

FORCE:

inspect-%: FORCE
	@echo $($*)

# standard status messages to be used for logging;
# length is fixed to 4 charters
TERM ?=
donestr := done
failstr := fail
infostr := info
warnstr := warn

# justify stdout log message using terminal screen size, if available
# otherwise use predefined values
define log
if [ ! -z "$(TERM)" ]; then \
	printf "%-$$(($$(tput cols) - 7))s[%-4s]\n" $(1) $(2);\
	else \
	printf "%-73s[%4s] \n" $(1) $(2);\
fi
endef

define add_gitignore
echo $(1) >> .gitignore;
sort --unique --output .gitignore{,};
endef

define del_gitignore
if [ -e .gitignore ]; then \
	sed --in-place '\,$(1),d' .gitignore;\
	sort --unique --output .gitignore{,};\
fi
endef
src_dir := src
data_dir := data


$(src_dir) $(data_dir):
	@mkdir -p $@

build_dir := build
$(build_dir):
	@$(call add_gitignore,$@)
	@mkdir -p $@

.PHONY: clean-build ### clean build
clean-build:
	@rm -rf $(build_dir)
	@$(call del_gitignore,$(build_dir))

presentation_name := presentation
presentation_format := pdf
presentation_object := $(build_dir)/$(presentation_name).md
presentation_target := $(build_dir)/$(presentation_name).$(presentation_format)

.PHONY: presentation
presentation: $(presentation_target) | $(build_dir)

$(presentation_target): $(presentation_object) | $(build_dir)
	@pandoc -t beamer $< --pdf-engine-opt=-shell-escape -o $@
	@$(call log,'build presentation',$(donestr))

$(presentation_object): $(src_dir)/main.md $(wildcard $(src_dir)/*.md) | $(build_dir)
	@cat /dev/null > $@
	@while IFS= read -r mainline; do \
		if [[ ! "$$mainline" =~ ^@include ]]; then \
			echo "$$mainline" >> $@; \
			continue; \
		fi; \
		cat $(src_dir)/"$${mainline//@include:[[:blank:]]/}" >> $@; \
	done < "$<"

.PHONY: run-presentation-build-daemon
run-presentation-build-daemon:
	find $(src_dir) -type f -name '*.md' | entr make presentation

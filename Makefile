EMPTY ?=
SPACE ?= $(EMPTY) $(EMPTY)
COMMA ?= ,
AVAILABLE_BACKEND_NAMES ?= relabs kurbis
BACKEND_NAME ?= $(firstword $(AVAILABLE_BACKEND_NAMES))

ifneq ($(BACKEND_NAME),$(filter $(BACKEND_NAME),$(AVAILABLE_BACKEND_NAMES)))
$(error make variable BACKEND_NAME should be equal one of these: \
	$(subst $(SPACE),$(COMMA)$(SPACE),$(strip $(AVAILABLE_BACKEND_NAMES))))
endif

.PHONY: testing
testing:
	echo $(filter $(BACKEND_NAME), \
	$(subst $(COMMA),$(SPACE),$(AVAILABLE_BACKEND_NAMES)))

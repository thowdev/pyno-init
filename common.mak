################################################################################
# Get the (root) directory where common.mak is located
#   - "-P" option of cd
#      Enter the physical directory directly without following symbolic links
#  - $MAKEFILE_LIST:
#    - https://ftp.gnu.org/old-gnu/Manuals/make-3.80/html_node/make_17.html
#  - lastword:
#    - Extract the last word of names.
#    - https://www.gnu.org/software/make/manual/html_node/Quick-Reference.html
ROOT-DIR := $(shell cd -P $(dir $(lastword $(MAKEFILE_LIST))) ; pwd)

# GIT-DIR example
GIT-DIR		:= $(shell cd -P $(ROOT-DIR)/.. ; pwd)

THOWDEV-DIR	:= $(shell mkdir -p $(HOME)/.thowdev && cd -P $(HOME)/.thowdev ; pwd)

ifndef GIT-DIR
$(error GIT-DIR is not set)
endif

################################################################################
# - Phony Targets:
#   - "A phony target is one that is not really the name of a file"
#   - https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
PHONY: activate all clean-all clean-node help node python targets
.DEFAULT_GOAL := help

################################################################################
# - order-only-prerequisites:
#   - http://www.gnu.org/savannah-checkouts/gnu/make/manual/html_node/Prerequisite-Types.html
#   - https://stackoverflow.com/questions/20763629/test-whether-a-directory-exists-inside-a-makefile
activate: | activate-python activate-node

################################################################################
all: clean python node activate

################################################################################
clean: clean-node clean-python

################################################################################
debug:
	@echo "################################################################################"
	@echo "# common.mak variables:"
	@echo "#   - ROOT-DIR: $(ROOT-DIR)"
	@echo "#   - GIT-DIR: $(GIT-DIR)"
	@echo "#   - HOME-DIR: $(HOME)"
	@echo "#   - MAKEFILE_LIST: $(MAKEFILE_LIST)"
	@echo "#   - lastword MAKEFILE_LIST: $(lastword $(MAKEFILE_LIST))"
	@echo "#   - dir lastword MAKEFILE_LIST: $(dir $(lastword $(MAKEFILE_LIST)))"
	@echo "################################################################################"
	@echo "# node.mak variables:"
	@echo "#   - GIT-REPO-NODEENV: $(GIT-REPO-NODEENV)"
	@echo "#   - NODE_VERSION: $(NODE_VERSION)"
	@echo "#   - DIR-NODEENV: $(DIR-NODEENV)"
	@echo "#   - DIR-NODE_MODULES: $(DIR-NODE_MODULES)"
	@echo "#   - DIR-VIRTUAL_ENV_NODE: $(DIR-VIRTUAL_ENV_NODE)"
	@echo "################################################################################"
	@echo "# python.mak variables:"

################################################################################
help targets: help-common help-node help-python

################################################################################
help-common:
	@echo "################################################################################"
	@echo "# ______________________________________________________________________________"
	@echo "# List of important targets:"
	@echo "# --------------------------"
	@echo "# > activate     - show activation instruction for virtual node and"
	@echo "#                  python environments"
	@echo "# > all          - doing all, cleanup and creating an node and"
	@echo "#                  python environment"
	@echo "# > clean        - clean-node && clean-python"
	@echo "# > help         - this target list (default target)"
	@echo "# > node         - Create an virtual node environment based on"
	@echo "#                  NODE_VERSION variable defined in node.mak and"
	@echo "#                  show activation instruction"
	@echo "# > python       - Create an virtual python environment based on"
	@echo "#                  PYTHON_VERSION variable defined in python.mak and"
	@echo "#                  show activation instruction"
	@echo "# > targets      - this target list (default target)"

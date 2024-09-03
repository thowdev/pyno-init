GIT-REPO-NODEENV		:= https://github.com/ekalinin/nodeenv.git

NODE_VERSION			:= 18.14.2

DIR-NODEENV				:= $(GIT-DIR)/nodeenv
DIR-NODE_MODULES		:= node_modules
DIR-VIRTUAL_ENV_NODE	:= .virt_env_node

ifndef NODE_VERSION
$(error NODE_VERSION is not set)
endif

# - Phony Targets:
#   - "A phony target is one that is not really the name of a file"
#   - https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
PHONY: activate-node clean-node help-node install-node node update-nodeenv update

activate-node:| $(DIR-NODEENV) $(DIR-VIRTUAL_ENV_NODE)
	@echo "################################################################################"
	@echo "# Activate $(DIR-VIRTUAL_ENV_NODE) with $(NODE_VERSION) using the following command:"
	@echo "source $(DIR-VIRTUAL_ENV_NODE)/bin/activate"
	@echo ""
	@echo "(Use \"deactivate_node\" to deactivate this virtual environment for node)"

clean-node:
	@echo "################################################################################"
	@echo "# Delete $(DIR-NODEENV)"
	@rm -rf $(DIR-NODEENV)
	@echo "# ----------------------------------------"
	@echo "# Delete $(DIR-VIRTUAL_ENV_NODE)"
	@rm -rf $(DIR-VIRTUAL_ENV_NODE)
	@echo "# ----------------------------------------"
	@echo "# Delete $(DIR-NODE_MODULES)"
	@rm -rf $(DIR-NODE_MODULES)
	@echo "# ----------------------------------------"
	@echo "# Delete yarn-error.log, yarn.lock"
	@rm -rf yarn-error.log yarn.lock

help-node:
	@echo "# ______________________________________________________________________________"
	@echo "# Specific node targets:"
	@echo "# ----------------------"
	@echo "# > activate-node    - show activation instruction for virtual node"
	@echo "#                      environments"
	@echo "# > clean-node       - cleanup node virt. environment incl."
	@echo "#                      $(DIR-NODE_MODULES)"
	@echo "# > help-node        - this target list (node targets)"

node: activate-node

# Check, if $(DIR-NODEENV) exists
$(DIR-NODEENV):
	@echo "################################################################################"
	@echo "# Clone repo from $(GIT-REPO-NODEENV) to $(DIR-NODEENV)"
	@git clone $(GIT-REPO-NODEENV) $(DIR-NODEENV)

# Check, if $(DIR-VIRTUAL_ENV_NODE) exists
$(DIR-VIRTUAL_ENV_NODE):
	@echo "################################################################################"
	@echo "# Install new virtual Node.js environment with version $(NODE_VERSION) into $(DIR-VIRTUAL_ENV_NODE)"
	@python $(DIR-NODEENV)/nodeenv.py -n $(NODE_VERSION) $(DIR-VIRTUAL_ENV_NODE)

update update-nodeenv: $(wildcard DIR-NODEENV)
	@echo "################################################################################"
	@echo "# Update $(DIR-NODEENV)"
	git -C $(DIR-NODEENV) pull

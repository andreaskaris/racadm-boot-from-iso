hosts: ## Create hosts file. Provide parameters SERVERS=<idrac IP address of server>, USER=<idrac username>, PASS=<idrac password>. Will only run if hosts does not exist.
	\cp hosts.j2 hosts
	sed -i 's/{{ servers }}/$(SERVERS)/' hosts
	sed -i 's/{{ ansible_ssh_user }}/$(USER)/' hosts
	sed -i 's/{{ ansible_ssh_pass }}/$(PASS)/' hosts
	cp group_vars/all.yml.j2 group_vars/all.yml

.PHONY: image_location
image_location: ## Update image_location in group_vars/all.yml. Requires IMAGE_LOCATION=<location of generated deploy image>.
ifndef IMAGE_LOCATION
	$(error IMAGE_LOCATION is undefined)
endif
	sed -i '/^image_location:.*/d' group_vars/all.yml
	echo "image_location: $(IMAGE_LOCATION)" >> group_vars/all.yml

.PHONY: shutdown_host
shutdown_host: ## Shutdown hosts.
	ansible-playbook deploy_host.yml --tags "power.off"

.PHONY: deploy_host
deploy_host: ## Deploy hosts.
	ansible-playbook deploy_host.yml

# Source https://gist.github.com/prwhite/8168133
.PHONY: help
help:	## Show this help.
	@grep -hE '^[A-Za-z0-9_ \-]*?:.*##.*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: list help

help:
	@echo "Convenience Make commands for provisioning a scarlett node"

list:
	@$(MAKE) -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$$)/ {split($$1,A,/ /);for(i in A)print A[i]}' | sort

vagrant-provision:
	vagrant provision

vagrant-up:
	vagrant up

vagrant-ssh:
	vagrant ssh

vagrant-destroy:
	vagrant destroy

vagrant-halt:
	vagrant halt

vagrant-config:
	vagrant ssh-config

serverspec-diff:
	cat serverspec_things_to_check_for.txt

serverspec:
	bundle exec rake

serverspec-install:
	bundle install --path .vendor

download-roles:
	# ansible-galaxy install geerlingguy.docker
	# ansible-galaxy install bennojoy.ntp
	# ansible-galaxy install jorti.fail2ban
	# ansible-galaxy install ksylvan.docker
	ansible-galaxy install -r install_roles.txt --roles-path roles/

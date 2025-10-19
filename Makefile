.PHONY: deploy push commit

all: commit deploy push

offline: commit deploy

commit:
	git add .
	git commit -m "Update at $$(date +"%Y-%m-%d %H:%M:%S")" || true
deploy:
	nix build .#darwinConfigurations.libr-macbook-air.system \
	   --extra-experimental-features 'nix-command flakes' || exit 1
	sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#libr-macbook-air
push: 
	git push


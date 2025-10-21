.PHONY: deploy push commit clean offline all

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
clean:
	@echo "Cleaning Nix caches and garbage..."
	sudo nix-collect-garbage -d || true
	sudo rm -rf /nix/var/nix/downloads || true
	sudo rm -rf /nix/var/log/nix/drvs || true
	rm -rf ~/.cache/nix || true
	sudo rm -rf /root/.cache/nix 2>/dev/null || true
	sudo nix-env --delete-generations old || true
	sudo nix-collect-garbage -d || true
	@echo "Nix caches cleaned successfully."


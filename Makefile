deploy:
	git add .
	git commit -m "New Deploy at $$(date +"%Y-%m-%d %H:%M:%S")" || true
	nix build .#darwinConfigurations.libr-macbook-air.system \
	   --extra-experimental-features 'nix-command flakes' || exit 1
	sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#libr-macbook-air
	git push 
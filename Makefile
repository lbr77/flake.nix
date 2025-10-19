deploy:
	git add .
	git commit -m "New Deploy at $(date +"%Y-%m-%d %H:%M:%S")"
	git push
	nix build .#darwinConfigurations.libr-macbook-air.system \
	   --extra-experimental-features 'nix-command flakes'

	sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#libr-macbook-air
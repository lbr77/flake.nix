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
	@echo "🧹 Cleaning Nix caches and garbage..."
	# 1. 清理未被引用的 /nix/store 包
	sudo nix-collect-garbage -d || true
	# 2. 删除下载缓存
	sudo rm -rf /nix/var/nix/downloads || true
	# 3. 删除构建日志
	sudo rm -rf /nix/var/log/nix/drvs || true
	# 4. 删除用户级别 flake 缓存
	rm -rf ~/.cache/nix || true
	# 5. 删除 root 用户缓存（可选）
	sudo rm -rf /root/.cache/nix 2>/dev/null || true
	# 6. 删除历史 generations
	sudo nix-env --delete-generations old || true
	sudo nix-collect-garbage -d || true
	@echo "✅ Nix caches cleaned successfully."


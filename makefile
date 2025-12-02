init:
	@if command -v pnpm >/dev/null 2>&1; then \
		echo "pnpm already installed, skipping global install."; \
	else \
		npm install -g pnpm; \
	fi
	pnpm install

clean:
	rm -rf node_modules

start: clean init
	pnpm run build
	pnpm run start
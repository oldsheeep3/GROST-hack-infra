TTSREPO=hakkason
TTSUSER=yuka383
STTREPO=GROST-hack-for-change-STT
STTUSER=Kou-web06
STTTOTTSREPO=GROST-hack-for-change-all
STTTOTTSUSER=oldsheeep3
REPOS:= ${TTSREPO} ${STTREPO} ${STTTOTTSREPO}
CURRENT_DIR:=$(shell pwd)


clone:
	test -d ${TTSREPO} && \
	echo "${TTSREPO} is exists. Skipping clone." || \
	git clone https://github.com/${TTSUSER}/${TTSREPO}

	test -d ${STTREPO} && \
	echo "${STTREPO} is exists. Skipping clone." || \
	git clone https://github.com/${STTUSER}/${STTREPO}

	test -d ${STTTOTTSREPO} && \
	echo "${STTTOTTSREPO} is exists. Skipping clone." || \
	git clone https://github.com/${STTTOTTSUSER}/${STTTOTTSREPO}

init: clone
	@for f in ${REPOS}; do \
		cd ${CURRENT_DIR}/$$f && \
		git pull && \
		$(MAKE) init; \
	done

start: init
	@for f in ${REPOS}; do \
		cd $$f && \
		$(MAKE) start; \
	done

clean:
	@$(foreach f,${REPOS}, \
		cd ${f} && \
		make clean
	)

pyenv:
	rm -rf "${HOME}/.pyenv" && \
	(curl -fsSL https://pyenv.run | bash) && \
	(export PYENV_ROOT="${HOME}/.pyenv") && \
	([[ -d ${PYENV_ROOT}/bin ]] && export PATH="${PYENV_ROOT}/bin:${PATH}") && \
	(eval "$(pyenv init - bash)")
	pyenv install 3.13
	pyenv local 3.13
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

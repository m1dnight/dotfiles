.PHONY: all
all: bin dotfiles etc ## Installs the bin and etc directory files and the dotfiles.


.PHONY: dotfiles
zsh:
	for file in $(shell find $(CURDIR) -name ".*" -not -name "*bash*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		echo "Linking $$f"; \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
    # mkdir -p $(HOME)/.local/share;
	# ln -snf $(CURDIR)/.fonts $(HOME)/.local/share/fonts;

	# mkdir -p $(HOME)/.config/ ;
	# ln -snf $(CURDIR)/i3 $(HOME)/.config ;

	mkdir -p $(HOME)/.ssh/ ;
	ln -snf $(CURDIR)/ssh/* $(HOME)/.ssh/ ;

	ln -sfn $(CURDIR)/global_gitignore $(HOME)/.gitignore;

	# I don't know what this is supposed to do to be fair.
	# git update-index --skip-worktree $(CURDIR)/.gitconfig;
	ln -sfn $(CURDIR)/global_gitconfig $(HOME)/.gitconfig;

	ln -snf $(CURDIR)/.bash_profile $(HOME)/.profile;

	ln -snf $(CURDIR)/wallpaper.jpg $(HOME)/wallpaper.jpg
	
	ln -snf $(CURDIR)/.secrets $(HOME)/.secrets

dotfiles:
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		echo "Linking $$f"; \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
    # mkdir -p $(HOME)/.local/share;
	# ln -snf $(CURDIR)/.fonts $(HOME)/.local/share/fonts;

	# mkdir -p $(HOME)/.config/ ;
	# ln -snf $(CURDIR)/i3 $(HOME)/.config ;

	mkdir -p $(HOME)/.ssh/ ;
	ln -snf $(CURDIR)/ssh/* $(HOME)/.ssh/ ;

	ln -sfn $(CURDIR)/global_gitignore $(HOME)/.gitignore;

	# I don't know what this is supposed to do to be fair.
	# git update-index --skip-worktree $(CURDIR)/.gitconfig;
	ln -sfn $(CURDIR)/global_gitconfig $(HOME)/.gitconfig;

	ln -snf $(CURDIR)/.bash_profile $(HOME)/.profile;

	ln -snf $(CURDIR)/wallpaper.jpg $(HOME)/wallpaper.jpg
	
	ln -snf $(CURDIR)/.secrets $(HOME)/.secrets

.PHONY: test
test: shellcheck ## Runs all the tests on the files in the repository.

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		m1dnight/shellcheck ./test.sh

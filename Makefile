dotfiles:
	@for file in $(shell find $(CURDIR) -maxdepth 1 -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		echo "Linking $$f"; \
		ln -sfn $$file $(HOME)/$$f; \
	done; \

# install fonts
	mkdir -p $(HOME)/.local/share;
	ln -snf $(CURDIR)/.fonts $(HOME)/.local/share/fonts;

# ssh config
	mkdir -p $(HOME)/.ssh/ ;
	ln -snf $(CURDIR)/ssh/* $(HOME)/.ssh/ ;

# gitconfig
	ln -sfn $(CURDIR)/global_gitignore $(HOME)/.gitignore;
	ln -sfn $(CURDIR)/global_gitconfig $(HOME)/.gitconfig;
	ln -sfn $(CURDIR)/global_gitattributes $(HOME)/.gitattributes;

# betterbranch script
	ln -snf $(CURDIR)/better_branch.sh $(HOME)/better_branch.sh;

SERVICE_FILES = macos/services
services: $(SERVICE_FILES)/*
	@echo $^
	cp $^ ~/Library/LaunchAgents/
	launchctl unload $^
	launchctl load $^

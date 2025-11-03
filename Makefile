RSYNC_CMD=/usr/bin/rsync
SSH_CMD=/usr/bin/ssh

## SSH key is not in this respository

DEST_HOST=jpgoldberg.pairserver.com
DEST_DIR=public_html/rethinking-security.org
DEST_USR=jpgoldberg

DEST=$(DEST_USR)@$(DEST_HOST):$(DEST_DIR)

## Could get this from config.toml, but just say it
SRC_DIR= ./public/

# Archive style rsync options
RSYNC_OPTS=-Crltp

# verbosity opts
RSYNC_OPTS += -v


.PHONY: build
build:
	zola build

.PHONY: publish
publish: build
	$(RSYNC_CMD) $(RSYNC_OPTS) -e $(SSH_CMD) $(SRC_DIR) $(DEST)

.PHONY: serve
serve:
	zola serve

.PHONY: draft
draft:
	zola build --drafts

.PHONY: serve-draft
serve-draft:
	zola serve --drafts

.PHONY: check
check:
	zola check



all: deps json-ps lib/Web/IDL/_Defs.pm

clean: clean-json-ps
	rm -fr local/*.json

updatenightly: local/bin/pmbp.pl clean all
	curl https://gist.githubusercontent.com/wakaba/34a71d3137a52abb562d/raw/gistfile1.txt | sh
	git add t_deps/modules
	perl local/bin/pmbp.pl --update
	git add config lib/

## ------ Setup ------

WGET = wget
GIT = git
PERL = ./perl

deps: git-submodules pmbp-install

git-submodules:
	$(GIT) submodule update --init

local/bin/pmbp.pl:
	mkdir -p local/bin
	$(WGET) -O $@ https://raw.github.com/wakaba/perl-setupenv/master/bin/pmbp.pl
pmbp-upgrade: local/bin/pmbp.pl
	perl local/bin/pmbp.pl --update-pmbp-pl
pmbp-update: git-submodules pmbp-upgrade
	perl local/bin/pmbp.pl --update
pmbp-install: pmbp-upgrade
	perl local/bin/pmbp.pl --install \
            --create-perl-command-shortcut perl \
            --create-perl-command-shortcut prove

json-ps: local/perl-latest/pm/lib/perl5/JSON/PS.pm
clean-json-ps:
	rm -fr local/perl-latest/pm/lib/perl5/JSON/PS.pm
local/perl-latest/pm/lib/perl5/JSON/PS.pm:
	mkdir -p local/perl-latest/pm/lib/perl5/JSON
	$(WGET) -O $@ https://raw.githubusercontent.com/wakaba/perl-json-ps/master/lib/JSON/PS.pm

## ------ Build ------

lib/Web/IDL/_Defs.pm: bin/generate-webidl-defs.pl local/webidl-grammer.json \
    local/webidl.json
	$(PERL) bin/generate-webidl-defs.pl > $@
	$(PERL) -c $@

local/webidl-grammer.json: bin/parse-grammer.pl src/webidl-grammer.txt
	$(PERL) bin/parse-grammer.pl > $@

local/webidl.json: 
	$(WGET) -O $@ https://raw.githubusercontent.com/manakai/data-web-defs/master/data/webidl.json

## ------ Tests ------

PROVE = ./prove

test: test-deps test-main

test-deps: deps json-ps

test-main:
	$(PROVE) t/modules/*.t t/parsing/*.t

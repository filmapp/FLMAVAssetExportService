PROJECT = FLMAVAssetExportService
TARGET = $(PROJECT)
IOS_VERSION = 8.1
DEVICE = iPhone 6
ORGANIZATION = filmapp
DOMAIN = org.openaquamarine
GITHUB = https://github.com/$(ORGANIZATION)/$(PROJECT)
# GitHub account
USER = filmapp
APPLEDOC_TEMPLATE = ~/RubymineProjects/SwiftyDoc
APPLEDOC_OUTPUT = ~/dropbox/Public/___doc___$(PROJECT)
PROJ_PATH = $(PROJECT)

podspec_path := $(wildcard *.podspec)

# @public
test:
	xctool \
	-sdk iphonesimulator \
	-workspace $(PROJ_PATH).xcworkspace \
	-scheme $(TARGET) \
	-destination 'platform=iOS Simulator,name=$(DEVICE),OS=$(IOS_VERSION)' \
	GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
	GCC_GENERATE_TEST_COVERAGE_FILES=YES \
	test

# @public
coveralls:
	coveralls -r ./ -e Pods -e $(PROJ_PATH)Tests

# @public
loc:
	find $(PROJ_PATH) \( -iname \*.m -o -iname \*.mm -o -iname \*.c -o -iname \*.cc -o -iname \*.h \) -exec wc -l '{}' \+
	find $(PROJ_PATH)Tests \( -iname \*.m -o -iname \*.mm -o -iname \*.c -o -iname \*.cc -o -iname \*.h \) -exec wc -l '{}' \+

# @public
# @param VER: string
# @example make release VER=v0.1.0
release: github_release podspec pod_push
	
# @param VER: string
# @example make release VER=v0.1.0
github_release:
	git tag $(VER) && git push --tags
	github-release release \
	--user $(USER) \
	--repo $(PROJECT) \
	--tag $(VER) \
	--name $(VER) \
	--pre-release

# Update *.podspec's version to specified version.
#
# @param VER: string
# @example make podspec VER=v0.1.0
podspec:
	sed \
	-i "" \
	-e 's/= "[0-9]*\.[0-9]*\.[0-9]*"/= \"$(subst v,,$(VER))\"/' \
	-e "s/v[0-9]*\.[0-9]*\.[0-9]*/$(VER)/" \
	$(podspec_path)

# Push to the CocoaPods Specs Repo
pod_push:
	pod trunk push

# @public
# @warning At first, setup preferences by `make setup_appledocplist`
doc:
	appledoc \
	AppledocSettings.plist \
 	$(PROJ_PATH)/Classes | exit 0

# @public
repo:
	open $(GITHUB)

# @public
setup: setup_appledocplist
	curl https://gist.githubusercontent.com/kaiinui/25662e9e32dffbb0ebcb/raw/4f10811aa798dcd95d3d96dbd50fac68b3c018e8/gitignore > .gitignore
	curl https://gist.githubusercontent.com/kaiinui/25662e9e32dffbb0ebcb/raw/6c0fc845772ac271cafeb0755bd2eaaf599ee335/template.podspec | sed "s/#{PROJECT}/$(PROJECT)/g" | sed "s@#{GITHUB}@$(GITHUB)@g" > $(PROJECT).podspec
	curl https://gist.githubusercontent.com/kaiinui/25662e9e32dffbb0ebcb/raw/85d9eacaf2a725454b5ea5b4834bd4a5aa1695a4/travis.yml > .travis.yml
	curl https://gist.githubusercontent.com/kaiinui/25662e9e32dffbb0ebcb/raw/fb744d94ef7d9a397ae07785d4d8c969504ddf3b/Podfile | sed "s/#{PROJECT}/HOGE/g" > Podfile

setup_appledocplist:
	curl 'https://gist.githubusercontent.com/kaiinui/25662e9e32dffbb0ebcb/raw/e64195c721fb946fc896005ab4f0249925a74db1/AppledocSettings.plist' | \
	sed "s/#{DOMAIN}/$(DOMAIN)/g" \
	| sed "s/#{ORGANIZATION}/$(ORGANIZATION)/g" \
	| sed "s/#{PROJECT}/$(PROJECT)/g" \
	| sed "s@#{APPLEDOC_TEMPLATE}@$(APPLEDOC_TEMPLATE)@g" \
	| sed "s@#{APPLEDOC_OUTPUT}@$(APPLEDOC_OUTPUT)@g" \
	> AppledocSettings.plist

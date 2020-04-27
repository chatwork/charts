KIND_VERSION = 0.7.0
KUBERNETES_VERSION = 1.15.7
KIND_NODE_HASH = e2df133f80ef633c53c0200114fce2ed5e1f6947477dbc83261a6a921169488d
HELM_VERSION = 3.2.0

.PHONY: apply
apply:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make apply || exit 255";

.PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test || exit 255";

.PHONY: ci\:enable\:k8s
ci\:enable\:k8s:
	@mkdir -p .bin/
	@if [ ! -f " ./.bin/kind" ]; then \
	    curl -sSL -o ./.bin/kind https://github.com/kubernetes-sigs/kind/releases/download/v$(KIND_VERSION)/kind-linux-amd64; \
	    chmod +x ./.bin/kind; \
	fi
	@sudo cp ./.bin/kind /usr/local/bin/kind;

	@if [ ! -f "./.bin/kubectl" ]; then \
	    curl -sSL -o ./.bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v$(KUBERNETES_VERSION)/bin/linux/amd64/kubectl; \
	    chmod +x ./.bin/kubectl; \
	fi
	@sudo cp ./.bin/kubectl /usr/local/bin/kubectl;
	kind create cluster --image kindest/node:v$(KUBERNETES_VERSION)@sha256:$(KIND_NODE_HASH) --wait 3m;

.PHONY: ci\:enable\:helm
ci\:enable\:helm:
	@mkdir -p .bin/
	@if [ ! -f "./.bin/helm" ]; then \
	    curl -sSL https://get.helm.sh/helm-v$(HELM_VERSION)-linux-amd64.tar.gz | tar zxvf - -O linux-amd64/helm > ./.bin/helm; \
	    chmod +x ./.bin/helm; \
	fi
	@sudo mv ./.bin/helm /usr/local/bin/helm;

.PHONY: ci\:diff\:from
ci\:diff\:from:
	@if [ "$(shell git rev-parse --abbrev-ref HEAD)" = "master" ]; then \
	    git --no-pager log --first-parent master --merges -n 2 --pretty=format:"%H" | tail -n 1; \
	else \
	    echo "remotes/origin/master"; \
	fi

.PHONY: ci\:diff\:to
ci\:diff\:to:
	@echo "HEAD";

.PHONY: ci\:diff
ci\:diff:
	@git --no-pager diff --diff-filter=ACMRTUXB --name-only "$(shell make ci:diff:from)" "$(shell make ci:diff:to)" \
	  | sed 's:^.*/compare/::g' \
	  | grep -v README.md \
	  | grep -v Makefile \
	  | grep -v variant.lock \
	  | grep -v variant.mod \
	  | xargs -I{} dirname {} \
	  | xargs -I{} sh -c "test -d {} && echo {}" \
	  | sed 's/[.\/].*$$//' \
	  | sed '/^$$/d' \
	  | uniq;

.PHONY: ci\:changelog
ci\:changelog:
	@if [ -n "${DIR}" ]; then \
	    git --no-pager log --no-merges --pretty=format:"- %s" "$(shell make ci:diff:from)...$(shell make ci:diff:to)" -- ${DIR}; \
	else \
	    git --no-pager log --no-merges --pretty=format:"- %s" "$(shell make ci:diff:from)...$(shell make ci:diff:to)"; \
	fi

.PHONY: ci\:notify
ci\:notify:
	docker run -e CHATWORK_TOKEN=$${CHATWORK_TOKEN} \
	                     -e ROOM_ID=$${CHATWORK_NOTIFICATION_ROOM_ID} \
	                     chatwork/chatwork-notify "[info][title]$${TITLE}[/title]$${BODY}[hr]$${CIRCLE_BUILD_URL}[/info]";

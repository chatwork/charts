KUBERNETES_VERSION="1.18.1"
RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm repo add argo https://argoproj.github.io/argo-helm
	helm upgrade -i --wait $(RELEASE)-argo-cd argo/argo-cd
	helm upgrade -i --wait -f ci.yaml $(RELEASE) .

.PHONY: lint
lint: lint-default

.PHONY: lint-default
lint-default:
	@echo "=> Indent check default values.yaml"
	../.circleci/lint-indent.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint --strict
	@echo ""

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	helm uninstall $(RELEASE)-argo-cd

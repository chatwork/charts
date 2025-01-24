KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.31.0"}
RELEASE = $$(basename $$PWD)

.PHONY: install
install:
	kubectl create namespace guestbook
	helm repo add argo https://argoproj.github.io/argo-helm
	helm upgrade -i --wait $(RELEASE)-argo-cd argo/argo-cd
	helm upgrade -i --wait -f ci.yaml $(RELEASE) .

.PHONY: lint
lint: lint-default

.PHONY: lint-default
lint-default:
	@echo "=> Indent check default values.yaml"
	../.github/scripts/lint-chart.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint --strict
	@echo ""
	@echo "=> Validating default value.yaml"
	helm template . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	helm uninstall $(RELEASE)-argo-cd

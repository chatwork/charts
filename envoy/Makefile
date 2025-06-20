KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.33.0"}
RELEASE = $$(basename $$PWD)

.PHONY: install
install:
	helm upgrade -i --wait $(RELEASE) .

.PHONY: lint
lint: lint-default lint-xds

.PHONY: lint-default
lint-default:
	@echo "=> Indent check default values.yaml"
	../.github/scripts/lint-chart.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint --strict
	@echo "=> Validating default value.yaml"
	helm template . | kubeval --strict --ignore-missing-schemas  --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: lint-xds
lint-xds:
	@echo "=> Indent check default values.yaml"
	../.github/scripts/lint-chart.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint -f example/xds.yaml --strict
	@echo "=> Validating default value.yaml"
	helm template -f example/xds.yaml . | kubeval --strict --ignore-missing-schemas  --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

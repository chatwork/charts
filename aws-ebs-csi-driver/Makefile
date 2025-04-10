KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.32.0"}
RELEASE = $$(basename $$PWD)

.PHONY: install
install:
	echo "no install"
	echo "This application cannot be launched without AWS privileges."

.PHONY: lint
lint: lint-default

.PHONY: lint-default
lint-default:
	@echo "=> Indent check default values.yaml"
	../.github/scripts/lint-chart.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint --strict
	@echo "=> Validating default value.yaml"
	helm template . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	if helm ls | grep $(RELEASE) > /dev/null;then \
		helm uninstall $(RELEASE); \
	else \
		echo "no uninstall"; \
	fi

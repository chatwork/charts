KUBERNETES_VERSION="1.18.1"
RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	echo "no install"
	echo "This application cannot be launched without AWS privileges."

.PHONY: lint
lint: lint-default

.PHONY: lint-default
lint-default:
	@echo "=> Linting default values.yaml"
	helm lint --strict
	@echo "=> Validating default value.yaml"
	helm template . | kubeval --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
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

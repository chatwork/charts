KUBERNETES_VERSION="1.18.1"
RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm install --wait sample-kafka bitnami/kafka
	helm upgrade -i --wait --set image.repository=cwsakamoto/burrow --set readinessProbe.enable=false --set livenessProbe.enable=false $(RELEASE) .

.PHONY: lint
lint: lint-default

.PHONY: lint-default
lint-default:
	@echo "=> Indent check default values.yaml"
	../.circleci/lint-indent.sh $$PWD/templates
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
	helm uninstall $(RELEASE)
	helm uninstall sample-kafka

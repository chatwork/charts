KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.30.0"}
RELEASE = $$(basename $$PWD)

.PHONY: install
install:
	helm install --wait sample-kafka oci://registry-1.docker.io/bitnamicharts/kafka
	helm upgrade -i --wait --set readinessProbe.enable=false --set livenessProbe.enable=false $(RELEASE) .

.PHONY: lint
lint: lint-default

.PHONY: lint-default
lint-default:
	@echo "=> Indent check default values.yaml"
	../.github/scripts/lint-chart.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint --strict
	@echo "=> Validating default value.yaml"
	helm template . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/cw-ozaki/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	helm uninstall sample-kafka

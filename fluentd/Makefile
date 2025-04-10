KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.32.0"}
RELEASE = $$(basename $$PWD)

.PHONY: install
install:
	helm upgrade -i --wait $(RELEASE) .

.PHONY: lint
lint: lint-daemonset lint-statefulset lint-use-udp lint-use-udp

.PHONY: lint-default
lint-default:
	@echo "=> Indent check default values.yaml"
	../.github/scripts/lint-chart.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint --strict
	@echo "=> Validating default value.yaml"
	helm template . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: lint-daemonset
lint-daemonset:
	@echo "=> Linting examples/daemonset.yaml"
	helm lint --strict -f examples/daemonset.yaml
	@echo "=> Validating examples/daemonset.yaml"
	helm template -f examples/daemonset.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-statefulset
lint-statefulset:
	@echo "=> Linting examples/statefulset.yaml"
	helm lint --strict -f examples/statefulset.yaml
	@echo "=> Validating examples/statefulset.yaml"
	helm template -f examples/statefulset.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-use-udp
lint-use-udp:
	@echo "=> Linting examples/use-udp.yaml"
	helm lint --strict -f examples/use-udp.yaml
	@echo "=> Validating examples/use-udp.yaml"
	helm template -f examples/use-udp.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: test
test: test-daemonset test-statefulset test-use-udp test-default

.PHONY: test-default
test-default:
	@echo "=> Testing default values.yaml"
	helm upgrade -i --wait $(RELEASE) .
	helm test --logs $(RELEASE)

.PHONY: test-daemonset
test-daemonset:
	-@helm uninstall $(RELEASE)
	@echo "=> Testing examples/daemonset.yaml"
	helm upgrade -i --wait -f examples/daemonset.yaml $(RELEASE)-daemonset .
	helm test --logs $(RELEASE)-daemonset
	helm uninstall $(RELEASE)-daemonset

.PHONY: test-statefulset
test-statefulset:
	-@helm uninstall $(RELEASE)
	@echo "=> Testing examples/statefulset.yaml"
	helm upgrade -i --wait -f examples/statefulset.yaml $(RELEASE)-statefulset .
	helm test --logs $(RELEASE)-statefulset
	helm uninstall $(RELEASE)-statefulset

.PHONY: test-use-udp
test-use-udp:
	-@helm uninstall $(RELEASE)
	@echo "=> Testing examples/use-udp.yaml"
	helm upgrade -i --wait -f examples/use-udp.yaml $(RELEASE)-use-udp .
	helm test --logs $(RELEASE)-use-udp
	helm uninstall $(RELEASE)-use-udp

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

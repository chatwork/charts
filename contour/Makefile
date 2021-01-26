KUBERNETES_VERSION="1.18.1"
RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	kubectl apply -f ./crd.yaml
	kubectl apply -f https://projectcontour.io/examples/kuard.yaml
	helm upgrade -i --wait --set envoy.service.type=ClusterIP $(RELEASE) .

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
	helm test --logs $(RELEASE)

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	kubectl delete -f https://projectcontour.io/examples/kuard.yaml

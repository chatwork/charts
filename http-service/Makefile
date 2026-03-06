KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.33.0"}
RELEASE = $$(basename $$PWD)

.PHONY: install
install:
	helm upgrade -i -f examples/deployment.yaml --wait $(RELEASE) .

.PHONY: lint
lint: lint-deployment lint-deployment-hpa lint-deployment-ingress lint-deployment-keda lint-deployment-rollout

.PHONY: lint-deployment
lint-deployment:
	@echo "=> Linting examples/deployment.yaml"
	helm lint --strict -f examples/deployment.yaml
	@echo "=> Validating examples/deployment.yaml"
	helm template -f examples/deployment.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-deployment-hpa
lint-deployment-hpa:
	@echo "=> Linting examples/deployment-hpa.yaml"
	helm lint --strict -f examples/deployment-hpa.yaml
	@echo "=> Validating examples/deployment-hpa.yaml"
	helm template -f examples/deployment-hpa.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-deployment-ingress
lint-deployment-ingress:
	@echo "=> Linting examples/deployment-ingress.yaml"
	helm lint --strict -f examples/deployment-ingress.yaml
	@echo "=> Validating examples/deployment-ingress.yaml"
	helm template -f examples/deployment-ingress.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-deployment-keda
lint-deployment-keda:
	@echo "=> Linting examples/deployment-keda.yaml"
	helm lint --strict -f examples/deployment-keda.yaml
	@echo "=> Validating examples/deployment-keda.yaml"
	helm template -f examples/deployment-keda.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-deployment-rollout
lint-deployment-rollout:
	@echo "=> Linting examples/deployment-rollout.yaml"
	helm lint --strict -f examples/deployment-rollout.yaml
	@echo "=> Validating examples/deployment-rollout.yaml"
	helm template -f examples/deployment-rollout.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: test
test: test-deployment

.PHONY: test-deployment
test-deployment:
	@if helm ls | grep -v "NAME" | cut -f1 | grep -e "^$(RELEASE)$$" > /dev/null; then helm uninstall $(RELEASE); fi
	@echo "=> Testing examples/deployment.yaml"
	helm upgrade -i --wait -f examples/deployment.yaml $(RELEASE)-deployment .
	sleep 30
	helm test $(RELEASE)-deployment --logs
	helm uninstall $(RELEASE)-deployment

.PHONY: uninstall
uninstall:
	@if helm ls | grep -v "NAME" | cut -f1 | grep -e "^$(RELEASE)$$" > /dev/null; then helm uninstall $(RELEASE); fi

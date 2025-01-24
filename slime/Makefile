KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.30.0"}
RELEASE = $$(basename $$PWD)

.PHONY: install
install:
	helm upgrade -i -f examples/deployment.yaml --wait $(RELEASE) .

.PHONY: lint
lint: lint-deployment lint-deployment-ingress lint-deployment-hpa lint-cronjob lint-cronjob-advanced

.PHONY: lint-deployment
lint-deployment:
	@echo "=> Linting examples/deployment.yaml"
	helm lint --strict -f examples/deployment.yaml
	@echo "=> Validating examples/deployment.yaml"
	helm template -f examples/deployment.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-deployment-ingress
lint-deployment-ingress:
	@echo "=> Linting examples/deployment-ingress.yaml"
	helm lint --strict -f examples/deployment-ingress.yaml
	@echo "=> Validating examples/deployment-ingress.yaml"
	helm template -f examples/deployment-ingress.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-deployment-hpa
lint-deployment-hpa:
	@echo "=> Linting examples/deployment-hpa.yaml"
	helm lint --strict -f examples/deployment-hpa.yaml
	@echo "=> Validating examples/deployment-hpa.yaml"
	helm template -f examples/deployment-hpa.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-cronjob
lint-cronjob:
	@echo "=> Linting examples/cronjob.yaml"
	helm lint --strict -f examples/cronjob.yaml
	@echo "=> Validating examples/cronjob.yaml"
	helm template -f examples/cronjob.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: lint-cronjob-advanced
lint-cronjob-advanced:
	@echo "=> Linting examples/cronjob-advanced.yaml"
	helm lint --strict -f examples/cronjob-advanced.yaml
	@echo "=> Validating examples/cronjob-advanced.yaml"
	helm template -f examples/cronjob-advanced.yaml . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error

.PHONY: test
test: test-deployment test-cronjob test-cronjob-advanced

.PHONY: test-deployment
test-deployment:
	@if helm ls | grep -v "NAME" | cut -f1 | grep -e "^$(RELEASE)$$" > /dev/null; then helm uninstall $(RELEASE); fi
	@echo "=> Testing examples/deployment.yaml"
	helm upgrade -i --wait -f examples/deployment.yaml $(RELEASE)-deployment .
	sleep 30
	helm test $(RELEASE)-deployment --logs
	helm uninstall $(RELEASE)-deployment

.PHONY: test-cronjob
test-cronjob:
	@if helm ls | grep -v "NAME" | cut -f1 | grep -e "^$(RELEASE)$$" > /dev/null; then helm uninstall $(RELEASE); fi
	@echo "=> Testing examples/cronjob.yaml"
	helm upgrade -i --wait -f examples/cronjob.yaml $(RELEASE)-cronjob .
	sleep 30
	helm test $(RELEASE)-cronjob --logs
	helm uninstall $(RELEASE)-cronjob

.PHONY: test-cronjob-advanced
test-cronjob-advanced:
	@if helm ls | grep -v "NAME" | cut -f1 | grep -e "^$(RELEASE)$$" > /dev/null; then helm uninstall $(RELEASE); fi
	@echo "=> Testing examples/cronjob-advanced.yaml"
	helm upgrade -i --wait -f examples/cronjob-advanced.yaml $(RELEASE)-cronjob-advanced .
	sleep 30
	helm test $(RELEASE)-cronjob-advanced --logs
	helm uninstall $(RELEASE)-cronjob-advanced

.PHONY: uninstall
uninstall:
	@if helm ls | grep -v "NAME" | cut -f1 | grep -e "^$(RELEASE)$$" > /dev/null; then helm uninstall $(RELEASE); fi

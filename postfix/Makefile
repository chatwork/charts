KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.33.0"}
RELEASE = $$(basename $$PWD)

helmInstallOptions = -i --wait --set "terminationGracePeriodSeconds=0"
mailcatcher = --set mailcatcher.enabled=true --set mailcatcher.service.type=ClusterIP

.PHONY: install
install:
	helm upgrade $(helmInstallOptions) $(RELEASE) .

.PHONY: lint
lint: lint-daemonset lint-daemonset-mailcatcher lint-deployment lint-deployment-mailcatcher

.PHONY: lint-daemonset
lint-daemonset:
	@echo "=> Indent check default values.yaml"
	../.github/scripts/lint-chart.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint --strict
	@echo "=> Validating default value.yaml"
	helm template . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: lint-daemonset-mailcatcher
lint-daemonset-mailcatcher:
	@echo "=> Linting default values.yaml"
	helm lint $(mailcatcher) --strict
	@echo "=> Validating default value.yaml"
	helm template $(mailcatcher) . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: lint-deployment
lint-deployment:
	@echo "=> Linting default values.yaml"
	helm lint --set deployment.enabled=true --set daemonset.enabled=false --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP --strict
	@echo "=> Validating default value.yaml"
	helm template --set deployment.enabled=true --set daemonset.enabled=false --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: lint-deployment-mailcatcher
lint-deployment-mailcatcher:
	@echo "=> Linting default values.yaml"
	helm lint --set deployment.enabled=true --set daemonset.enabled=false $(mailcatcher) --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP --strict
	@echo "=> Validating default value.yaml"
	helm template --set deployment.enabled=true --set daemonset.enabled=false $(mailcatcher) --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: test
test: test-daemonset test-daemonset-mailcatcher test-deployment test-deployment-mailcatcher

.PHONY: test-daemonset
test-daemonset:
	-helm uninstall $(RELEASE) && kubectl delete pod $(RELEASE)-test && kubectl wait --all --for="delete" pod
	helm upgrade $(helmInstallOptions) $(RELEASE) .
	kubectl wait --all --for="condition=Ready" --timeout="300s" pod
	helm test --logs $(RELEASE)

.PHONY: test-daemonset-mailcatcher
test-daemonset-mailcatcher:
	-helm uninstall $(RELEASE) && kubectl delete pod $(RELEASE)-test && kubectl wait --all --for="delete" pod
	helm upgrade $(helmInstallOptions) $(mailcatcher) $(RELEASE) .
	kubectl wait --all --for="condition=Ready" --timeout="300s" pod
	helm test --logs $(RELEASE)

.PHONY: test-deployment
test-deployment:
	-helm uninstall $(RELEASE) && kubectl delete pod $(RELEASE)-test && kubectl wait --all --for="delete" pod
	# If you use Service in kubeadm-dind-cluster environment, it will not start if type=LoadBalancer. So ClusterIP is set.
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set deployment.service.type=ClusterIP $(RELEASE) .
	kubectl wait --all --for="condition=Ready" --timeout="300s" pod
	helm test --logs $(RELEASE)

.PHONY: test-deployment-mailcatcher
test-deployment-mailcatcher:
	helm uninstall $(RELEASE) && kubectl delete pod $(RELEASE)-test && kubectl wait --all --for="delete" pod
	# If you use Service in kubeadm-dind-cluster environment, it will not start if type=LoadBalancer. So ClusterIP is set.
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false $(mailcatcher) --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP  $(RELEASE) .
	kubectl wait --all --for="condition=Ready" --timeout="300s" pod
	helm test --logs $(RELEASE)

.PHONY: uninstall
uninstall:
	-helm uninstall $(RELEASE)
	-helm uninstall $(RELEASE)-test-daemonset-mailcatcher
	-helm uninstall $(RELEASE)-test-deployment
	-helm uninstall $(RELEASE)-test-deployment-mailcatcher

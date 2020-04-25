RELEASE = "$$(basename $$PWD)"

helmInstallOptions = -i --wait --set "terminationGracePeriodSeconds=0"
mailcatcher = --set mailcatcher.enabled=true --set mailcatcher.service.type=ClusterIP

.PHONY: install
install:
	helm upgrade $(helmInstallOptions) $(RELEASE) .

.PHONY: test
test: test-daemonset test-daemonset-mailcatcher test-deployment test-deployment-mailcatcher

.PHONY: test-daemonset
test-daemonset:
	helm upgrade $(helmInstallOptions) $(RELEASE) .
	helm test $(RELEASE) || (make test:debug && exit 1)

.PHONY: test-daemonset-mailcatcher
test-daemonset-mailcatcher:
	helm upgrade $(helmInstallOptions) $(mailcatcher) $(RELEASE) .
	helm test $(RELEASE) || (make test:debug && exit 1)

.PHONY: test-deployment
test-deployment:
	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。ClusterIP を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP  $(RELEASE) .
	helm test $(RELEASE) || (make test:debug && exit 1)

.PHONY: test-deployment-mailcatcher
test-deployment-mailcatcher:
	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。ClusterIP を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false $(mailcatcher) --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP  $(RELEASE) .
	helm test $(RELEASE) || (make test:debug && exit 1)

.PHONY: test\:debug
test\:debug:
	kubectl get pod | grep $(RELEASE)
	kubectl get pod --field-selector=status.phase=Failed -ojsonpath='{.items..metadata.name}' | xargs -I{} kubectl logs {} --all-containers

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

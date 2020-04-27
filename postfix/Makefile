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
	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。ClusterIP を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP $(RELEASE) .
	kubectl wait --all --for="condition=Ready" --timeout="300s" pod
	helm test --logs $(RELEASE)

.PHONY: test-deployment-mailcatcher
test-deployment-mailcatcher:
	# Chart を削除して再生成すると、test-pod では古い Service の IP を引いてしまうので削除しない。
	-kubectl delete pod $(RELEASE)-test && kubectl wait --all --for="delete" pod
	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。ClusterIP を指定して回避。
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

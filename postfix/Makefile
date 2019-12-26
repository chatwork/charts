namespace = "$$(basename $$PWD)$$(git rev-parse HEAD)"
helmContext = --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"}
releaseName = $$(basename $$PWD)-$$(git rev-parse HEAD)

helmInstallOptions = --wait --install --namespace $(namespace) --set terminationGracePeriodSeconds=0
deleteTestPod = kubectl delete pods --namespace $(namespace) $(releaseName)-test
deleteChart = helm $(helmContext) delete $(releaseName) --purge
helmTest = helm $(helmContext) test $(releaseName)
mailcatcher = --set mailcatcher.enabled=true --set mailcatcher.service.type=ClusterIP

.PHONY: apply
apply:
	@if ! kubectl get namespace $(namespace) >/dev/null 2>&1; then \
		kubectl create namespace $(namespace); \
	fi
	# enable daemonset
	helm $(helmContext) upgrade $(helmInstallOptions) $(releaseName) .;

.PHONY: test
test: test-daemonset test-daemonset-mailcatcher test-deployment test-deployment-mailcatcher

.PHONY: test-daemonset
test-daemonset:
	-$(deleteTestPod)
	-$(deleteChart)

	helm $(helmContext) upgrade $(helmInstallOptions) $(releaseName) .;

	$(helmTest)

.PHONY: test-daemonset-mailcatcher
test-daemonset-mailcatcher:
	-$(deleteTestPod)
	-$(deleteChart)

	helm $(helmContext) upgrade $(helmInstallOptions) $(mailcatcher) $(releaseName) .;
	$(helmTest)

.PHONY: test-deployment
test-deployment:
	-$(deleteTestPod)
	-$(deleteChart)

	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。ClusterIP を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm $(helmContext) upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP  $(releaseName) .;

	$(helmTest)

.PHONY: test-deployment-mailcatcher
test-deployment-mailcatcher:
    # Chart を削除して再生成すると、test-pod では古い Service の IP を引いてしまうので削除しない。
	-$(deleteTestPod)

	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。ClusterIP を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm $(helmContext) upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false $(mailcatcher) --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=ClusterIP  $(releaseName) .;

	$(helmTest)

.PHONY: delete
delete:
	helm $(helmContext) ls -q \
		| xargs -I {} helm $(helmContext) delete --purge $(releaseName);

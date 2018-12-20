namespace = "$$(basename $$PWD)$$(git rev-parse HEAD)"
helmContext = --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"}
releaseName = $$(basename $$PWD)-$$(git rev-parse HEAD)

helmInstallOptions = --wait --install --namespace $(namespace) --set terminationGracePeriodSeconds=1
deleteTestPod = kubectl delete pods --namespace $(namespace) $(releaseName)-test
deleteChart = helm $(helmContext) delete $(releaseName) --purge
helmTest = helm $(helmContext) test $(releaseName)

.PHONY: apply
apply:
	@if ! kubectl get namespace $(namespace) >/dev/null 2>&1; then \
		kubectl create namespace $(namespace); \
	fi
	# enable daemonset
	helm $(helmContext) upgrade $(helmInstallOptions) -f templates/test/test-hostPath-values.yaml $(releaseName) .;

.PHONY: test
test: test-daemonset test-daemonset-mailhog test-deployment test-deployment-mailhog

.PHONY: test-daemonset
test-daemonset:
	-$(deleteTestPod)
	-$(deleteChart)

	helm $(helmContext) upgrade $(helmInstallOptions) -f templates/test/test-hostPath-values.yaml $(releaseName) .;

	$(helmTest)

.PHONY: test-daemonset-mailhog
test-daemonset-mailhog:
	-$(deleteTestPod)
	-$(deleteChart)

	helm $(helmContext) upgrade $(helmInstallOptions) -f templates/test/test-hostPath-values.yaml --set mailhog.enabled=true $(releaseName) .;
	$(helmTest)

.PHONY: test-deployment
test-deployment:
	-$(deleteTestPod)
	-$(deleteChart)

	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。NodePort を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm $(helmContext) upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=NodePort  $(releaseName) .;

	$(helmTest)

.PHONY: test-deployment-mailhog
test-deployment-mailhog:
	-$(deleteTestPod)

	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。NodePort を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm $(helmContext) upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set mailhog.enabled=true --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=NodePort  $(releaseName) .;

	$(helmTest)

.PHONY: delete
delete:
	helm $(helmContext) ls -q \
		| xargs -I {} helm $(helmContext) delete --purge $(releaseName);

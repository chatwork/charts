namespace = "$$(basename $$PWD)$$(git rev-parse HEAD)"
helmContext = --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"}
releaseName = $$(basename $$PWD)-$$(git rev-parse HEAD)

helmInstallOptions = --wait --install --namespace $(namespace)
deleteChart = helm $(helmContext) delete $(releaseName) --purge && kubectl delete pods --namespace $(namespace) $(releaseName)-test

.PHONY: apply
apply:
	@if ! kubectl get namespace $(namespace) >/dev/null 2>&1; then \
		kubectl create namespace $(namespace); \
	fi
	# enable daemonset and test
	helm $(helmContext) upgrade $(helmInstallOptions) -f templates/test/test-hostPath-values.yaml $(releaseName) .;

.PHONY: test
test: test-daemonset test-daemonset-mailhog test-deployment test-deployment-mailhog

.PHONY: test-daemonset
test-daemonset:
	$(deleteChart)

	helm $(helmContext) upgrade $(helmInstallOptions) -f templates/test/test-hostPath-values.yaml $(releaseName) .;
	helm $(helmContext) test $(releaseName)

.PHONY: test-daemonset-mailhog
test-daemonset:
	$(deleteChart)

	helm $(helmContext) upgrade $(helmInstallOptions) -f templates/test/test-hostPath-values.yaml --set mailhog.enabled=true $(releaseName) .;
	helm $(helmContext) test $(releaseName)

.PHONY: test-deployment
test-deployment:
	$(deleteChart)

	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。NodePort を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm $(helmContext) upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=NodePort  $(releaseName) .;

	helm $(helmContext) test $(releaseName)

.PHONY: test-deployment-mailhog
test-deployment:
	$(deleteChart)

	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。NodePort を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm $(helmContext) upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set mailhog.enabled=true --set deployment.podDisruptionBudget.enabled=true --set deployment.service.type=NodePort  $(releaseName) .;

	helm $(helmContext) test $(releaseName)

.PHONY: delete
delete:
	helm $(helmContext) ls -q \
		| xargs -I {} helm $(helmContext) delete --purge $(releaseName);

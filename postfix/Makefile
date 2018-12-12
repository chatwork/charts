namespace = "$$(basename $$PWD)$$(git rev-parse HEAD)"
helmContext = --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"}

helmInstallOptions = --wait --install --namespace $(namespace) --set test.enabled=true --set-file postfix.configMaps.main_cf=templates/test/main.cf
releaseName = $$(basename $$PWD)-$$(git rev-parse HEAD)

.PHONY: apply
apply:
	@if ! kubectl get namespace $(namespace) >/dev/null 2>&1; then \
		kubectl create namespace $(namespace); \
	fi
	# enable daemonset and test
	helm $(helmContext) upgrade $(helmInstallOptions) -f templates/test/test-hostPath-values.yaml $(releaseName) .;

.PHONY: test
test: test-daemonset test-deployment

.PHONY: test-daemonset
test-daemonset:
	helm $(helmContext) test $(releaseName)

.PHONY: test-deployment
test-deployment:
	# 作成済 Chart、 test pod を削除
	helm $(helmContext) delete $(releaseName) --purge
	kubectl delete pods --namespace $(namespace) $(releaseName)-test

	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。NodePort を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
	helm $(helmContext) upgrade $(helmInstallOptions) --set deployment.enabled=true --set daemonset.enabled=false --set deployment.service.type=NodePort  $(releaseName) .;

	helm $(helmContext) test $(releaseName)

.PHONY: delete
delete:
	helm $(helmContext) ls -q \
		| xargs -I {} helm $(helmContext) delete --purge $(releaseName);

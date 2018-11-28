.PHONY: apply
apply:
	@if ! kubectl get namespace "$$(basename $$PWD)$$(git rev-parse HEAD)" >/dev/null 2>&1; then \
		kubectl create namespace "$$(basename $$PWD)$$(git rev-parse HEAD)"; \
	fi
	# kubeadm-dind-cluster 環境で Service を利用する場合、type=LoadBalancer だと 起動しない。NodePort を指定して回避。
	# @see https://github.com/kubernetes-sigs/kubeadm-dind-cluster/issues/74
#	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --wait --install --namespace "$$(basename $$PWD)$$(git rev-parse HEAD)" --set deployment.enabled=true --set daemonset.enabled=false --set deployment.service.type=NodePort --set test.enabled=true $$(basename $$PWD)-$$(git rev-parse HEAD) .;
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --wait --install --namespace "$$(basename $$PWD)$$(git rev-parse HEAD)" --set test.enabled=true $$(basename $$PWD)-$$(git rev-parse HEAD) .;

.PHONY: test
test:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} test $$(basename $$PWD)-$$(git rev-parse HEAD)

.PHONY: delete
delete:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} ls -q \
		| xargs -I {} helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} delete --purge $$(basename $$PWD)-$$(git rev-parse HEAD);

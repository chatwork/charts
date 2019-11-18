.PHONY: apply
apply:
	@if ! kubectl get namespace "$$(basename $$PWD)$$(git rev-parse HEAD)" >/dev/null 2>&1; then \
		kubectl create namespace "$$(basename $$PWD)$$(git rev-parse HEAD)"; \
	fi
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --wait --install --namespace "$$(basename $$PWD)$$(git rev-parse HEAD)" $$(basename $$PWD)-$$(git rev-parse HEAD) .;

.PHONY: test
test:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} test $$(basename $$PWD)-$$(git rev-parse HEAD)

.PHONY: delete
delete:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} ls -q \
		| xargs -I {} helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} delete --purge $$(basename $$PWD)-$$(git rev-parse HEAD);
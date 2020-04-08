NAMESPACE := $$(basename $$PWD)$$(git rev-parse --short HEAD)
RELEASE := $$(basename $$PWD)-$$(git rev-parse --short HEAD)

.PHONY: apply
apply:
	@if ! kubectl get namespace "${NAMESPACE}" >/dev/null 2>&1; then \
		kubectl create namespace "${NAMESPACE}"; \
	fi
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --wait --install --namespace "${NAMESPACE}" "${RELEASE}" .;

.PHONY: test
test:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} test "${RELEASE}"

.PHONY: delete
delete:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} ls -q \
		| xargs -I {} helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} delete --purge "${RELEASE}";

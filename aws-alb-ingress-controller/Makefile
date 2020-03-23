.PHONY: apply
apply:
	@if ! kubectl get namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)" >/dev/null 2>&1; then \
		kubectl create namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)"; \
	fi
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --wait --install --dry-run --namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)" $$(basename $$PWD)-$$(git rev-parse --short HEAD) --set readinessProbe.enable=false --set livenessProbe.enable=false .;

.PHONY: test
test:
	echo "no test"

.PHONY: delete
delete:
	echo "no delete task"

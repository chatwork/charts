.PHONY: apply
apply:
	@if ! kubectl get namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)" >/dev/null 2>&1; then \
		kubectl create namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)"; \
	fi
	@if [ -n "$${CI}" ]; then \
		helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --wait --install --namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)" $$(basename $$PWD)-$$(git rev-parse --short HEAD) --set 'configmaps[0].data.slime=₍Ꙭ̂₎' --set 'configmaps[0].metadata.name=slime' --set 'service.enabled=true' --set 'service.type=ClusterIP' --set 'service.ports.http.internal=8080' --set 'service.ports.http.external=80' --set 'service.ports.http.protocol=TCP' --set 'deployment.enabled=true' --set 'deployment.pod.container[0].image=k8s.gcr.io/pause:latest' --set 'deployment.pod.container[0].name=pause' .; \
	else \
		helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --wait --install --namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)" $$(basename $$PWD)-$$(git rev-parse --short HEAD) .; \
	fi

.PHONY: test
test:
	echo "no test"

.PHONY: delete
delete:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} ls -q \
		| xargs -I {} helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} delete --purge $$(basename $$PWD)-$$(git rev-parse --short HEAD);

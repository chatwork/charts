.PHONY: apply
apply:
	@if ! kubectl get namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)" >/dev/null 2>&1; then \
		kubectl create namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)"; \
	fi
	@if [ -n "$${CI}" ]; then \
		kubectl apply -f ./crd.yaml ; \
		kubectl apply -f https://j.hept.io/contour-kuard-example ; \
		helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --debug --wait --install --namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)" $$(basename $$PWD)-$$(git rev-parse --short HEAD) --set envoy.service.type=ClusterIP .; \
	else \
		helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} upgrade --wait --install --namespace "$$(basename $$PWD)$$(git rev-parse --short HEAD)" $$(basename $$PWD)-$$(git rev-parse --short HEAD) .; \
	fi


.PHONY: test
test:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} test $$(basename $$PWD)-$$(git rev-parse --short HEAD)

.PHONY: delete
delete:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} delete --purge $$(basename $$PWD)-$$(git rev-parse --short HEAD)

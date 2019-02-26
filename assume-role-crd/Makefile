TILLER_NAMESPACE := "$$(basename $$PWD)$$(git rev-parse --short HEAD)"
TILLER_CHART_VERSION := "0.0.4"
NAMESPACE := "$$(basename $$PWD)$$(git rev-parse --short HEAD)"

.PHONY: apply
apply:
	helm repo add chatwork https://chatwork.github.io/charts
	@if ! kubectl get namespace "${NAMESPACE}" >/dev/null 2>&1; then \
		kubectl create namespace "${NAMESPACE}"; \
	fi
	helm upgrade --install --kube-context $${KUBE_CONTEXT:-"dind"} --namespace ${NAMESPACE} --version ${TILLER_CHART_VERSION} tiller-per-ns-${TILLER_NAMESPACE} chatwork/tiller \
		--set 'rbac.tiller.rules[0].apiGroups[0]='"*"'' \
		--set 'rbac.tiller.rules[0].resources[0]='"*"'' \
		--set 'rbac.tiller.rules[0].verbs[0]='"*"''
	sleep 10
	helm init --tiller-namespace ${TILLER_NAMESPACE} --service-account tiller-per-ns-${TILLER_NAMESPACE} --upgrade
	@if [ -n "$${CI}" ]; then \
		helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace kube-system upgrade --wait --install --namespace "${TILLER_NAMESPACE}" arop-for-ci chatwork/assume-role-operator --set image.repository="cwsakamoto/assume-role-operator"; \
		sleep 5; \
		helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace ${TILLER_NAMESPACE} upgrade --wait --install --namespace "${TILLER_NAMESPACE}" --set test.target=$$(basename $$PWD)-$$(git rev-parse --short HEAD) $$(basename $$PWD)-$$(git rev-parse --short HEAD) .; \
	else \
		helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace ${TILLER_NAMESPACE} upgrade --wait --install --namespace "${NAMESPACE}" --set test.target=$$(basename $$PWD)-$$(git rev-parse --short HEAD) $$(basename $$PWD)-$$(git rev-parse --short HEAD) .; \
	fi

.PHONY: test
test:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace ${TILLER_NAMESPACE} test $$(basename $$PWD)-$$(git rev-parse --short HEAD)

.PHONY: delete
delete:
	helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace ${TILLER_NAMESPACE} ls -q \
		| xargs -I {} helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace ${TILLER_NAMESPACE} delete --purge $$(basename $$PWD)-$$(git rev-parse --short HEAD);

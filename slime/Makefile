KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.20.7"}
RELEASE = $$(basename $$PWD)

.PHONY: install
install:
	helm upgrade -i --wait \
		--set 'configmaps[0].data.slime=₍Ꙭ̂₎' \
		--set 'configmaps[0].metadata.name=slime' \
		--set 'service.enabled=true' \
		--set 'service.type=ClusterIP' \
		--set 'service.ports.http.internal=8080' \
		--set 'service.ports.http.external=80' \
		--set 'service.ports.http.protocol=TCP' \
		--set 'deployment.enabled=true' \
		--set 'deployment.pod.container[0].image=k8s.gcr.io/pause:latest' \
		--set 'deployment.pod.container[0].name=pause' \
		$(RELEASE) .

.PHONY: lint
lint: lint-default

.PHONY: lint-default
lint-default:
	@echo "=> Indent check default values.yaml"
	../.circleci/lint-chart.sh $$PWD/templates
	@echo "=> Linting default values.yaml"
	helm lint --strict \
		--set 'configmaps[0].data.slime=₍Ꙭ̂₎' \
		--set 'configmaps[0].metadata.name=slime' \
		--set 'service.enabled=true' \
		--set 'service.type=ClusterIP' \
		--set 'service.ports.http.internal=8080' \
		--set 'service.ports.http.external=80' \
		--set 'service.ports.http.protocol=TCP' \
		--set 'deployment.enabled=true' \
		--set 'deployment.pod.container[0].image=k8s.gcr.io/pause:latest' \
		--set 'deployment.pod.container[0].name=pause'
	@echo "=> Validating default value.yaml"
	helm template \
		--set 'configmaps[0].data.slime=₍Ꙭ̂₎' \
		--set 'configmaps[0].metadata.name=slime' \
		--set 'service.enabled=true' \
		--set 'service.type=ClusterIP' \
		--set 'service.ports.http.internal=8080' \
		--set 'service.ports.http.external=80' \
		--set 'service.ports.http.protocol=TCP' \
		--set 'deployment.enabled=true' \
		--set 'deployment.pod.container[0].image=k8s.gcr.io/pause:latest' \
		--set 'deployment.pod.container[0].name=pause' \
		 . | kubeval --strict --ignore-missing-schemas --additional-schema-locations https://raw.githubusercontent.com/cw-ozaki/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

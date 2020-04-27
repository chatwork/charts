RELEASE = "$$(basename $$PWD)"

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

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

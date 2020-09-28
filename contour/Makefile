RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	kubectl apply -f ./crd.yaml
	kubectl apply -f https://projectcontour.io/examples/kuard.yaml
	helm upgrade -i --wait --set envoy.service.type=ClusterIP $(RELEASE) .

.PHONY: test
test:
	helm test --logs $(RELEASE)

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	kubectl delete -f https://projectcontour.io/examples/kuard.yaml

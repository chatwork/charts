RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm install --wait sample-kafka bitnami/kafka
	helm upgrade -i --wait --set image.repository=cwsakamoto/burrow --set readinessProbe.enable=false --set livenessProbe.enable=false $(RELEASE) .

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	helm uninstall sample-kafka

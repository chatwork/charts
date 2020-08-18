RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm upgrade -i --wait --set readinessProbe.enable=false --set livenessProbe.enable=false $(RELEASE) .

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

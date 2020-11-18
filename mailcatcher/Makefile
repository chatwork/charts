RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm upgrade -i --wait --set service.type=NodePort $(RELEASE) .

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)


RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm upgrade -i --wait $(RELEASE) .

.PHONY: test
test:
	@echo "=> Testing ci/values.yaml"
	helm upgrade -i --wait -f ci/values.yaml $(RELEASE) .
	
.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

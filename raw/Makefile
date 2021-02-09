
RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm upgrade -i --wait -f ci.yaml $(RELEASE) .

.PHONY: test
test:
	@echo "=> Testing ci.yaml"
	helm test --logs $(RELEASE)
	
.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

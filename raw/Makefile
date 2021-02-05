
RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm upgrade -i --wait $(RELEASE) .

.PHONY: test
test:
	@echo "=> Testing ci.yaml"
	helm upgrade -i --wait -f ci.yaml $(RELEASE) .
	kubectl exec -it nginx -- curl -I localhost
	
.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

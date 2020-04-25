RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm upgrade -i --wait --dry-run $(RELEASE) .

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	echo "no delete task"

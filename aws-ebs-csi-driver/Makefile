RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	echo "no install"
	echo "This application cannot be launched without AWS privileges."

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	if helm ls | grep $(RELEASE) > /dev/null; then
		helm uninstall $(RELEASE)
	else
		echo "no uninstall"
	fi

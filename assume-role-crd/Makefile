RELEASE := "$$(basename $$PWD)"

.PHONY: install
install:
	helm repo add chatwork https://chatwork.github.io/charts
	helm upgrade --wait --install --set image.repository="cwsakamoto/assume-role-operator" $(RELEASE)-assume-role-operator chatwork/assume-role-operator
	helm upgrade --wait --install --set test.target=$(RELEASE) $(RELEASE) .

.PHONY: test
test:
	helm test --logs $(RELEASE)

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	helm uninstall $(RELEASE)-assume-role-operator
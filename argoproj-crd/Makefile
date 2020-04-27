RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm repo add argo https://argoproj.github.io/argo-helm
	helm upgrade -i --wait $(RELEASE)-argo-cd argo/argo-cd
	helm upgrade -i --wait -f ci.yaml $(RELEASE) .

.PHONY: test
test:
	echo "no test"

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	helm uninstall $(RELEASE)-argo-cd

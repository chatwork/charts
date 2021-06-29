KUBERNETES_VERSION = $${KUBERNETES_VERSION:-"1.20.7"}
RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	helm upgrade -i --wait \
		--set 'args[0]=--kubelet-insecure-tls' \
		--set 'args[1]=--kubelet-preferred-address-types=InternalIP'
		$(RELEASE) .

.PHONY: lint
lint: lint-default

.PHONY: lint-default
lint-default:
	@echo "=> Validating default value.yaml"
	helm template . | kubeval --additional-schema-locations https://raw.githubusercontent.com/cw-ozaki/kubernetes-json-schema/master/ --kubernetes-version $(KUBERNETES_VERSION) --exit-on-error
	@echo ""

.PHONY: test
test:
	@echo "=> Testing default setting"
	helm test --logs $(RELEASE)

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

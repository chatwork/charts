RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	kubectl apply -f https://raw.githubusercontent.com/chatwork/charts/f21241abccd77cd71e69fb08d3b7a7634ff4dda2/kube-aws-iam-controller/templates/crd.yaml
	helm repo add chatwork https://chatwork.github.io/charts
	helm upgrade -i --wait --set deployment.args[0]="--base-role-arn=arn:aws:iam::1234567890:role/" $(RELEASE)-kube-aws-iam-controller chatwork/kube-aws-iam-controller
	helm upgrade -i --wait --set roleSecretName=$(RELEASE) $(RELEASE) .

.PHONY: test
test:
	helm test --logs $(RELEASE)

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)
	helm uninstall $(RELEASE)-kube-aws-iam-controller

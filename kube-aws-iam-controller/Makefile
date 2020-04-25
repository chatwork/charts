RELEASE = "$$(basename $$PWD)"

.PHONY: install
install:
	kubectl apply -f https://raw.githubusercontent.com/mikkeloscar/kube-aws-iam-controller/v0.1.0/docs/aws_iam_role_crd.yaml
	helm upgrade -i --wait --set deployment.args[0]="--base-role-arn=arn:aws:iam::1234567890:role/" $(RELEASE) .

.PHONY: test
test:
	helm test --logs $(RELEASE)

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE)

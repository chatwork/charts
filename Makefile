PHONY: apply
apply:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make apply";

PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test";

PHONY: ci\:enable\:k8s
ci\:enable\:k8s:
	wget https://cdn.rawgit.com/kubernetes-sigs/kubeadm-dind-cluster/master/fixed/dind-cluster-v1.11.sh;
	chmod +x dind-cluster-v1.11.sh;
	./dind-cluster-v1.11.sh up;
	echo 'export PATH=$$HOME/.kubeadm-dind-cluster:$$PATH' >> $${BASH_ENV:-"/home/circleci/.bashrc"}

PHONY: ci\:enable\:helm
ci\:enable\:helm:
	wget -O - https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-rc.3-linux-amd64.tar.gz | tar zxvf - -O linux-amd64/helm > helm;
	chmod +x helm;
	if [ -n "$${HELM_CLIENT_ONLY}" ]; then \
		./helm init --client-only; \
	else \
		./helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} init --wait; \
	fi
	echo 'export PATH=$$PWD:$$PATH' >> $${BASH_ENV:-"/home/circleci/.bashrc"};

PHONY: ci\:diff
ci\:diff:
	@git diff --name-only $$(echo $$CIRCLE_COMPARE_URL | sed 's:^.*/compare/::g') | xargs -I{} dirname {} | sed 's/[.\/].*$$//' | sed '/^$$/d' | uniq;

PHONY: ci\:changelog
ci\:changelog:
	@if [ -n "${DIR}" ]; then \
		git log --no-merges --pretty=format:"- %s" $$(echo $$CIRCLE_COMPARE_URL | sed 's:^.*/compare/::g') -- ${DIR}; \
	else \
		git log --no-merges --pretty=format:"- %s" $$(echo $$CIRCLE_COMPARE_URL | sed 's:^.*/compare/::g'); \
	fi

PHONY: ci\:notify
ci\:notify:
	docker run -e CHATWORK_TOKEN=$${CHATWORK_TOKEN} \
						 -e ROOM_ID=$${CHATWORK_NOTIFICATION_ROOM_ID} \
						 chatwork/chatwork-notify "[info][title]$${TITLE}[/title]$${BODY}[hr]$${CIRCLE_BUILD_URL}[/info]"

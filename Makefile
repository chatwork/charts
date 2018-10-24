.PHONY: apply
apply:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make apply || exit 255";

.PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test || exit 255" || make ci:dump && exit 1;

.PHONY: ci\:enable\:k8s
ci\:enable\:k8s:
	wget https://cdn.rawgit.com/kubernetes-sigs/kubeadm-dind-cluster/master/fixed/dind-cluster-v1.11.sh;
	chmod +x dind-cluster-v1.11.sh;
	./dind-cluster-v1.11.sh up;
	echo 'export PATH=$$HOME/.kubeadm-dind-cluster:$$PATH' >> $${BASH_ENV:-"/home/circleci/.bashrc"}

.PHONY: ci\:dump
ci\:dump:
	./dind-cluster-v1.11.sh dump | ./dind-cluster-v1.11.sh split-dump;
	echo "\n\n@@@ kubectl-all @@@";
	cat cluster-dump/kubectl-all.txt;
	echo "\n\n@@@ describe-all @@@";
	cat cluster-dump/describe-all.txt;
	ls cluster-dump/pod-*.log | xargs -I{} /bin/sh -c "echo \"\n\n@@@ {} @@@\" && cat {}";


.PHONY: ci\:enable\:helm
ci\:enable\:helm:
	wget -O - https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-rc.3-linux-amd64.tar.gz | tar zxvf - -O linux-amd64/helm > helm;
	chmod +x helm;
	if [ -n "$${HELM_CLIENT_ONLY}" ]; then \
		./helm init --client-only; \
	else \
		./helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} init --wait; \
	fi
	echo 'export PATH=$$PWD:$$PATH' >> $${BASH_ENV:-"/home/circleci/.bashrc"};

.PHONY: ci\:diff\:from
ci\:diff\:from:
		@if [ "$(shell git symbolic-ref --short HEAD)" = "master" ]; then \
			git --no-pager log --merges -n 2 --pretty=format:"%H" | tail -n 1; \
		else \
			echo "HEAD"; \
		fi

.PHONY: ci\:diff\:to
ci\:diff\:to:
		@if [ "$(shell git symbolic-ref --short HEAD)" = "master" ]; then \
			echo "HEAD"; \
		else \
			echo "remotes/origin/master"; \
		fi

.PHONY: ci\:diff
ci\:diff:
	@git --no-pager diff --name-only "$(shell make ci:diff:from)" "$(shell make ci:diff:to)" | sed 's:^.*/compare/::g' | xargs -I{} dirname {} | sed 's/[.\/].*$$//' | sed '/^$$/d' | uniq;

.PHONY: ci\:changelog
ci\:changelog:
	@if [ -n "${DIR}" ]; then \
		git --no-pager log --no-merges --pretty=format:"- %s" "$(shell make ci:diff:from)...$(shell make ci:diff:to)" -- ${DIR}; \
	else \
		git --no-pager log --no-merges --pretty=format:"- %s" "$(shell make ci:diff:from)...$(shell make ci:diff:to)"; \
	fi

.PHONY: ci\:notify
ci\:notify:
	docker run -e CHATWORK_TOKEN=$${CHATWORK_TOKEN} \
						 -e ROOM_ID=$${CHATWORK_NOTIFICATION_ROOM_ID} \
						 chatwork/chatwork-notify "[info][title]$${TITLE}[/title]$${BODY}[hr]$${CIRCLE_BUILD_URL}[/info]"

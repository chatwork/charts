PHONY: apply
apply:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make apply";

PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test";

PHONY: package
package:
	@rm -rf $${DIR:-"dist"} && mkdir -p $${DIR:-"dist"};
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make package";
	@find . -name '*.tgz' | xargs -I{} cp -f {} $${DIR:-"dist"};
	helm repo index $${DIR:-"dist"} --url https://chatwork.github.io/charts;

PHONY: ci\:enable\:k8s
ci\:enable\:k8s:
	wget https://cdn.rawgit.com/kubernetes-sigs/kubeadm-dind-cluster/master/fixed/dind-cluster-v1.8.sh;
	chmod +x dind-cluster-v1.8.sh;
	./dind-cluster-v1.8.sh up;
	echo 'export PATH=$$HOME/.kubeadm-dind-cluster:$$PATH' >> $${BASH_ENV:-"/home/circleci/.bashrc"}

PHONY: ci\:enable\:helm
ci\:enable\:helm:
	wget -O - https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-rc.3-linux-amd64.tar.gz | tar zxvf - -O linux-amd64/helm > helm;
	chmod +x helm;
	echo 'export PATH=$$PWD:$$PATH' >> $${BASH_ENV:-"/home/circleci/.bashrc"};
	./helm --kube-context $${KUBE_CONTEXT:-"dind"} --tiller-namespace $${TILLER_NAMESPACE:-"kube-system"} init --wait;

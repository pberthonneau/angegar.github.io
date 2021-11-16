namespace:
	kubectl apply -f manifests/namespace.yaml

configmap-svc:
	kubectl apply -f manifests/configmap-svc.yaml

pvc:
	kubectl apply -f manifests/mysql-pvc.yaml \
				  -f manifests/wordpress-pvc.yaml

deployment:
	kubectl apply -f manifests/wordpress-deployment.yaml \
	 			  -f manifests/mysql-deployment.yaml


service:
	kubectl apply -f manifests/wordpress-service.yaml \
				  -f manifests/mysql-service.yaml

ingress:
	kubectl apply -f manifests/ingress-tls.yaml 

tunnel:
	kubectl port-forward --namespace demo  svc/wordpress-svc 80:80

build: namespace configmap-svc pvc deployment service ingress
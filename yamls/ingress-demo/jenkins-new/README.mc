kubectl apply -f storage-class.yaml
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

the ingress might not work properly , i am not sure if it works or not , 

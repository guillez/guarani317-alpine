#Activo plugin metallb
minikube addons enable metallb
#Ejecuto plugin
kubectl apply -f metallb.yml                                 
#Creo los volumenes
echo "Creo los volumenes"
kubectl apply -f guarani-claim0-persistentvolumeclaim.yaml
kubectl apply -f postgres-claim0-persistentvolumeclaim.yaml 

#Ejecuto deployment de postgres y apache
echo "Ejecuto deployment de postgres y apache"
kubectl apply -f guarani-deployment.yaml
kubectl apply -f postgres-deployment.yaml   

#Ejecuto servicios de postgres y apache
echo "Ejecuto servicios de postgres y apache"
kubectl apply -f postgres-service.yaml
kubectl apply -f guarani-service.yaml   
#Ejecuto Loadbalancer para acceder al sistema
echo "Ejecuto Loadbalancer para acceder al sistema"
kubectl apply -f service_lb.yml

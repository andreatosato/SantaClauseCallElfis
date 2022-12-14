$ACR_REGISTRY="santaclause.azurecr.io"
$VERSION="0.0.6"

docker login santaclause.azurecr.io --username santaclause --password hVMz7fjVyUIM06F0RRV+sWuKAHZQwj8cwQDv/9933u+ACRDqzPPV

cd ..\src\

docker build -t elfo-one:$VERSION -f .\Sample.ElfoOne\Dockerfile .
docker tag elfo-one:$VERSION $ACR_REGISTRY/elfo-one:$VERSION
docker push $ACR_REGISTRY/elfo-one:$VERSION

docker build -t elfo-two:$VERSION -f .\Sample.ElfoTwo\Dockerfile .
docker tag elfo-two:$VERSION $ACR_REGISTRY/elfo-two:$VERSION
docker push $ACR_REGISTRY/elfo-two:$VERSION

docker build -t aggregator:$VERSION -f .\Sample.Aggregator\Dockerfile .
docker tag aggregator:$VERSION $ACR_REGISTRY/aggregator:$VERSION
docker push $ACR_REGISTRY/aggregator:$VERSION

docker build -t ingress:$VERSION -f ../reverse-proxy-main/samples/KubernetesIngress.Sample/Combined/Dockerfile ../reverse-proxy-main/
docker tag ingress:$VERSION $ACR_REGISTRY/ingress:$VERSION
docker push $ACR_REGISTRY/ingress:$VERSION

cd ..\deploy\
az account set --subscription eab27a5f-08dd-4e9d-bd26-21caf854af94
az aks get-credentials --resource-group santaclause --name santaclause

kubectl apply -f .\k8s\
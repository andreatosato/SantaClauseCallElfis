$ACR_REGISTRY="santaclause.azurecr.io"
$VERSION="0.0.1"

docker login santaclause.azurecr.io --username santaclause --password Byt0L/GrF3CYnSJ8ESWH+5NGm6kPfCnA

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

cd ..\deploy\
az account set --subscription eab27a5f-08dd-4e9d-bd26-21caf854af94
az aks get-credentials --resource-group santaclause --name santaclause

kubectl apply -f .\k8s\
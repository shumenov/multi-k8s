docker build -t shumenov/multi-client:latest -t shumenov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shumenov/multi-server:latest -t shumenov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shumenov/multi-worker:latest -t shumenov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shumenov/multi-client:latest 
docker push shumenov/multi-server:latest 
docker push shumenov/multi-worker:latest 

docker push shumenov/multi-client:$SHA 
docker push shumenov/multi-server:$SHA 
docker push shumenov/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shumenov/multi-server:$SHA
kubectl set image deployments/client-deployment client=shumenov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shumenov/multi-worker:$SHA

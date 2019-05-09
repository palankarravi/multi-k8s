docker build -t palankarravi/multi-client:latest -t palankarravi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t palankarravi/multi-server:latest -t palankarravi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t palankarravi/multi-worker:latest -t palankarravi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push palankarravi/multi-client:latest 
docker push palankarravi/multi-server:latest 
docker push palankarravi/multi-worker:latest 

docker push palankarravi/multi-client:$SHA 
docker push palankarravi/multi-server:$SHA 
docker push palankarravi/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=palankarravi/multi-client:$SHA
kubectl set image deployments/server-deployment server=palankarravi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=palankarravi/multi-worker:$SHA
docker build -t dmelliot/multi-client:latest -t dmelliot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dmelliot/multi-server:latest -t dmelliot/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dmelliot/multi-worker:latest -t dmelliot/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dmelliot/multi-client:latest
docker push dmelliot/multi-server:latest
docker push dmelliot/multi-worker:latest
docker push dmelliot/multi-client:$SHA
docker push dmelliot/multi-server:$SHA
docker push dmelliot/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
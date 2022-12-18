docker build -t yuto358/multi-client:latest -t yuto358/multi-client:$SHA -f ./cilent/Dockerfile.dev ./client
docker build -t yuto358/multi-server:latest -t yuto358/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t yuto358/multi-worker:latest -t yuto358/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push yuto358/multi-client:latest
docker push yuto358/multi-server:latest
docker push yuto358/multi-worker:latest

docker push yuto358/multi-client:$SHA
docker push yuto358/multi-server:$SHA
docker push yuto358/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yuto358/multi-server:$SHA
kubectl set image deployments/client-deployment client=yuto358/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yuto358/multi-worker:$SHA

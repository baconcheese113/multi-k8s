docker build -t yannessaj/multi-client:latest -t yannessaj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yannessaj/multi-server:latest -t yannessaj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yannessaj/multi-worker:latest -t yannessaj/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push yannessaj/multi-client:latest
docker push yannessaj/multi-server:latest
docker push yannessaj/multi-worker:latest

docker push yannessaj/multi-client:$SHA
docker push yannessaj/multi-server:$SHA
docker push yannessaj/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yannessaj/multi-server:$SHA
kubectl set image deployments/client-deployment client=yannessaj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yannessaj/multi-worker:$SHA
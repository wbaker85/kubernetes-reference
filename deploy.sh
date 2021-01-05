docker build -t wbaker85/multi-client:latest -t wbaker85/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wbaker85/multi-server:latest -t wbaker85/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wbaker85/multi-worker:latest -t wbaker85/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wbaker85/multi-client:latest
docker push wbaker85/multi-server:latest
docker push wbaker85/multi-worker:latest

docker push wbaker85/multi-client:$SHA
docker push wbaker85/multi-server:$SHA
docker push wbaker85/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wbaker85/multi-server:$SHA
kubectl set image deployments/client-deployment client=wbaker85/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wbaker85/multi-worker:$SHA

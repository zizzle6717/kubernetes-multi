docker build -t rilizack/multi-client:latest -t rilizack/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t rilizack/multi-server:latest -t rilizack/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t rilizack/multi-worker:latest -t rilizack/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push rilizack/multi-client:latest
docker push rilizack/multi-server:latest
docker push rilizack/multi-worker:latest
docker push rilizack/multi-client:$GIT_SHA
docker push rilizack/multi-server:$GIT_SHA
docker push rilizack/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rilizack/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=rilizack/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=rilizack/multi-worker:$GIT_SHA

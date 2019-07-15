docker build -t ankamreddyganeshkumar/multi-client:latest -t ankamreddyganeshkumar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ankamreddyganeshkumar/multi-server:latest -t ankamreddyganeshkumar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ankamreddyganeshkumar/multi-worker:latest -t ankamreddyganeshkumar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ankamreddyganeshkumar/multi-client:latest
docker push ankamreddyganeshkumar/multi-server:latest
docker push ankamreddyganeshkumar/multi-worker:latest

docker push ankamreddyganeshkumar/multi-client:$SHA
docker push ankamreddyganeshkumar/multi-server:$SHA
docker push ankamreddyganeshkumar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ankamreddyganeshkumar/multi-server:$SHA
kubectl set image deployments/client-deployment client=ankamreddyganeshkumar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ankamreddyganeshkumar/multi-worker:$SHA

alias vas-cons-nats="VAS_CORS_ORIGINS=localhost:5173 VAS_KV_STORE=consul://localhost:8500 VAS_MQ=nats://localhost:4222 vas-runtime"

function docker-help() {
echo -e NATS:
echo -e -----
echo -e docker run -d -p 4222:4222 --restart unless-stopped -ti nats:latest

echo -e CONSUL:
echo -e ------
echo -e docker run -d -p 8500:8500 --restart unless-stopped -p 8600:8600/udp --name=consul consul:1.15.4 agent -server -ui -node=server-1 -bootstrap-expect=1 -client=0.0.0.0
}



#go run perf_deliverclient.go -server=192.168.133.112:7050 -goroutines=50 -size=0 -run=10 -messages=10000
#go run perf_deliverclient.go -server=192.168.133.112:7050 -goroutines=50 -size=0 -run=10 -messages=100000
#go run perf_broadcastclient.go -server=192.168.133.112:7050 -goroutines=50 -size=0 -run=10 -messages=250000
go run perf_broadcastclient.go -server=192.168.133.102:7050 -goroutines=50 -size=4096 -run=1 -messages=1000 -channelID=test
#go run perf_broadcastclient.go -server=192.168.133.112:7050 -goroutines=50 -size=0 -run=10 -messages=500000

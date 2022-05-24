#!/bin/bash
echo "you should die now :3 it'll be take some time"

#@Tomnomnom
go install github.com/tomnomnom/waybackurls@latest


#@ProjectDiscovery

go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest

go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

go install -v github.com/projectdiscovery/notify/cmd/notify@latest

#owasp
go install -v github.com/OWASP/Amass/v3/...@master

#URL and Parameter Discovery:
go install github.com/hakluke/hakrawler@latest

GO111MODULE=on go get -u github.com/jaeles-project/gospider

#paramspider

go install github.com/lc/gau/v2/cmd/gau@latest

#fuzzing Endpoint
go install github.com/OJ/gobuster/v3@latest

go install github.com/ffuf/ffuf@latest
#subDomain Takeover


#automated scanner. ..  

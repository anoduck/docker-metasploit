# docker-metasploit

## Usage:

Start an instance of database:
`docker run -d --name=postgres postgres`

Link metasploit:
`docker run -it --link postgres:db pandrew/metasploit`

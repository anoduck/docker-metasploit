#!/bin/bash
MSFPASS=${MSFPASS:-msf}
if [[ ! -z "$DB_PORT_5432_TCP_ADDR" ]]; then
  # Check if user exists
  USEREXIST="$(psql -h $DB_PORT_5432_TCP_ADDR -p 5432 -U postgres postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='msf'")"
  # If not create it
  if [[ ! $MSFEXIST -eq 1 ]]; then
	 psql -h $DB_PORT_5432_TCP_ADDR -p 5432 -U postgres postgres -c "create role msf login password '$MSFPASS'"
  fi

  DBEXIST="$(psql -h $DB_PORT_5432_TCP_ADDR -p 5432 -U postgres  postgres -l | grep msf)"
  if [[ ! $DBEXIST ]]; then
	 psql -h $DB_PORT_5432_TCP_ADDR -p 5432 -U postgres postgres -c "CREATE DATABASE msf OWNER msf;"
  fi

sh -c "echo 'production:
  adapter: postgresql
  database: msf
  username: msf
  password: $MSFPASS
  host: $DB_PORT_5432_TCP_ADDR
  port: 5432
  pool: 75
  timeout: 5' > /metasploit-framework/config/database.yml"
fi

/metasploit-framework/msfconsole

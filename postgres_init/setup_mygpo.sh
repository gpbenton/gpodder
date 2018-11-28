#"/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    ALTER USER mygpo CREATEDB;  -- required for creating test database
    CREATE DATABASE test_mygpo;
    GRANT ALL PRIVILEGES ON DATABASE mygpo to mygpo;
    GRANT ALL PRIVILEGES ON DATABASE test_mygpo to mygpo;
    ALTER DATABASE mygpo OWNER TO mygpo;
    ALTER DATABASE test_mygpo OWNER TO mygpo;
    ALTER ROLE mygpo SET statement_timeout = 5000;
EOSQL

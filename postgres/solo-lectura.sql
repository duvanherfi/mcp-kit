-- A Postgres role the AI can read with and nothing else.
-- Run it as an admin, changing mi_base and the password.
-- Then connect the MCP with: postgresql://ia_lectura:CLAVE@localhost:5432/mi_base

CREATE ROLE ia_lectura WITH LOGIN PASSWORD 'CAMBIA_ESTA_CLAVE';

GRANT CONNECT ON DATABASE mi_base TO ia_lectura;
GRANT USAGE ON SCHEMA public TO ia_lectura;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ia_lectura;

-- Tables created later are readable too.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO ia_lectura;

-- Even if a write slips through, the session refuses it.
ALTER ROLE ia_lectura SET default_transaction_read_only = on;

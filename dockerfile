FROM postgres:15 AS builder

# Instalar dependências de compilação
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libpq-dev \
    postgresql-server-dev-15

# Compilar e instalar HypoPG
WORKDIR /tmp
RUN git clone --depth 1 https://github.com/HypoPG/hypopg.git && \
    cd hypopg && \
    make USE_PGXS=1 && \
    make USE_PGXS=1 install && \
    cd .. && \
    rm -rf hypopg

# Compilar e instalar index_advisor
RUN git clone --depth 1 https://github.com/supabase/index_advisor.git && \
    cd index_advisor && \
    make USE_PGXS=1 && \
    make USE_PGXS=1 install && \
    cd .. && \
    rm -rf index_advisor

# Imagem final
FROM postgres:15

# Expor a porta padrão do PostgreSQL
EXPOSE 5432

# Copiar arquivos compilados da imagem builder
COPY --from=builder /usr/lib/postgresql/15/lib/ /usr/lib/postgresql/15/lib/
COPY --from=builder /usr/share/postgresql/15/extension/ /usr/share/postgresql/15/extension/

# Criar arquivo de inicialização
RUN echo "CREATE EXTENSION pg_stat_statements;" > /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE EXTENSION hypopg;" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE EXTENSION index_advisor;" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE ROLE anon;" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE ROLE authenticated;" >> /docker-entrypoint-initdb.d/init.sql

# Add args to Postgres entrypoint
ENTRYPOINT ["sh", "-c", "\
  set -e; \
  \
  # Configurar delay de rede se necessário (apenas para desenvolvimento) \
  if [ \"${POSTGRES_DELAY_MS:-0}\" -gt 0 ]; then \
    echo \"Configurando delay de rede de ${POSTGRES_DELAY_MS}ms...\"; \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends iproute2 > /dev/null && \
    tc qdisc add dev eth0 root netem delay \"${POSTGRES_DELAY_MS}ms\" && \
    echo \"Delay de rede configurado com sucesso.\"; \
  fi; \
  \
  # Configurações de produção recomendadas \
  export POSTGRES_INITDB_ARGS=\"--data-checksums\"; \
  \
  # Iniciar PostgreSQL com extensões e configurações otimizadas \
  echo \"Iniciando PostgreSQL com configurações otimizadas...\"; \
  exec docker-entrypoint.sh postgres \
    -c shared_preload_libraries='pg_stat_statements' \
    -c pg_stat_statements.track=all \
    -c max_connections=${POSTGRES_MAX_CONNECTIONS:-100} \
    -c shared_buffers=${POSTGRES_SHARED_BUFFERS:-256MB} \
    -c effective_cache_size=${POSTGRES_EFFECTIVE_CACHE_SIZE:-768MB} \
    -c maintenance_work_mem=${POSTGRES_MAINTENANCE_WORK_MEM:-64MB} \
    -c checkpoint_completion_target=${POSTGRES_CHECKPOINT_COMPLETION_TARGET:-0.9} \
    -c wal_buffers=${POSTGRES_WAL_BUFFERS:-16MB} \
    -c default_statistics_target=${POSTGRES_STATISTICS_TARGET:-100} \
    -c random_page_cost=${POSTGRES_RANDOM_PAGE_COST:-1.1} \
    -c effective_io_concurrency=${POSTGRES_IO_CONCURRENCY:-200} \
    -c work_mem=${POSTGRES_WORK_MEM:-4MB} \
    -c min_wal_size=${POSTGRES_MIN_WAL_SIZE:-1GB} \
    -c max_wal_size=${POSTGRES_MAX_WAL_SIZE:-4GB} \
    -c wal_level=${POSTGRES_WAL_LEVEL:-logical} \
    -c max_worker_processes=${POSTGRES_MAX_WORKER_PROCESSES:-8} \
    -c max_parallel_workers_per_gather=${POSTGRES_MAX_PARALLEL_WORKERS_PER_GATHER:-4} \
    -c max_parallel_workers=${POSTGRES_MAX_PARALLEL_WORKERS:-8} \
    -c max_parallel_maintenance_workers=${POSTGRES_MAX_PARALLEL_MAINTENANCE_WORKERS:-4} \
    -c autovacuum=${POSTGRES_AUTOVACUUM:-on} \
"]
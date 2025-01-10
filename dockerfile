FROM postgres:15-alpine as builder

# Instalar dependências de compilação
RUN apk add --no-cache \
    git \
    build-base \
    postgresql15-dev

# Compilar e instalar HypoPG
RUN git clone --depth 1 https://github.com/HypoPG/hypopg.git /hypopg && \
    cd /hypopg && \
    make install && \
    rm -rf /hypopg

# Compilar e instalar index_advisor
RUN git clone --depth 1 https://github.com/supabase/index_advisor.git /index_advisor && \
    cd /index_advisor && \
    make install && \
    rm -rf /index_advisor

# Imagem final
FROM postgres:15-alpine

# Copiar arquivos compilados da imagem builder
COPY --from=builder /usr/local/lib/postgresql/ /usr/local/lib/postgresql/
COPY --from=builder /usr/local/share/postgresql/extension/ /usr/local/share/postgresql/extension/

# Criar arquivo de inicialização
RUN echo "CREATE EXTENSION pg_stat_statements;" > /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE EXTENSION hypopg;" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE EXTENSION index_advisor;" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE ROLE anon;" >> /docker-entrypoint-initdb.d/init.sql && \
    echo "CREATE ROLE authenticated;" >> /docker-entrypoint-initdb.d/init.sql

# Variável para delay opcional (em ms)
ENV POSTGRES_DELAY_MS=0

# Script de inicialização
COPY <<EOF /docker-entrypoint-initdb.d/00-setup.sh
#!/bin/sh
if [ "\$POSTGRES_DELAY_MS" -gt 0 ]; then
    apk add --no-cache iproute2
    tc qdisc add dev eth0 root netem delay "\${POSTGRES_DELAY_MS}ms"
fi
EOF

RUN chmod +x /docker-entrypoint-initdb.d/00-setup.sh
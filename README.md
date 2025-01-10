[![Docker Pulls](https://img.shields.io/docker/pulls/weltondev/stackauth-db)](https://hub.docker.com/r/weltondev/stackauth-db)
[![Docker Image Size](https://img.shields.io/docker/image-size/weltondev/stackauth-db/latest)](https://hub.docker.com/r/weltondev/stackauth-db)
[![Docker Stars](https://img.shields.io/docker/stars/weltondev/stackauth-db)](https://hub.docker.com/r/weltondev/stackauth-db)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/welton-dev/stackauth-db/main.yml)](https://github.com/welton-dev/stackauth-db/actions)
[![GitHub Release](https://img.shields.io/github/v/release/welton-dev/stackauth-db)](https://github.com/welton-dev/stackauth-db/releases/latest)
[![GitHub License](https://img.shields.io/github/license/welton-dev/stackauth-db)](https://github.com/welton-dev/stackauth-db/blob/main/LICENSE)

# StackAuth DB

Um projeto Docker especializado para PostgreSQL com extensões avançadas para otimização de consultas e gerenciamento de índices.

## 🚀 Tecnologias

Este projeto foi desenvolvido com as seguintes tecnologias:

- PostgreSQL 15
- Docker
- Docker Compose
- GitHub Actions para CI/CD
- Extensões PostgreSQL:
  - HypoPG
  - Index Advisor
  - pg_stat_statements

## 📋 Pré-requisitos

Antes de começar, você precisa ter instalado em sua máquina:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## 🔧 Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/stackauth-db.git
cd stackauth-db
```

2. Configure as variáveis de ambiente:
Crie um arquivo `.env` com as seguintes variáveis:
```env
POSTGRES_USER=seu_usuario
POSTGRES_PASSWORD=sua_senha
```

3. Inicie os containers Docker:
```bash
docker-compose up -d
```

## 🛠️ Funcionalidades

- **Banco de Dados PostgreSQL 15**: Versão estável e robusta do PostgreSQL
- **HypoPG**: Extensão para simulação de índices hipotéticos
- **Index Advisor**: Ferramenta para recomendação de índices
- **pg_stat_statements**: Monitoramento de performance de queries
- **Healthcheck**: Verificação automática da saúde do banco de dados
- **Volumes Persistentes**: Armazenamento persistente dos dados

## 📦 Estrutura do Projeto

```
stackauth-db/
├── .github/
│   └── workflows/    # Configurações do GitHub Actions
├── postgres/         # Configurações do PostgreSQL
├── dockerfile        # Configuração do container PostgreSQL
├── docker-compose.yml # Orquestração dos containers
└── README.md
```

## 🔒 Segurança

- Variáveis sensíveis são gerenciadas através de variáveis de ambiente
- Configuração de roles específicas (anon)
- Healthcheck integrado para garantir disponibilidade

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

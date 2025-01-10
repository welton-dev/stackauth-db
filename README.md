[![Docker Pulls](https://img.shields.io/docker/pulls/weltondev/stackauth-db)](https://hub.docker.com/r/weltondev/stackauth-db)
[![Docker Image Size](https://img.shields.io/docker/image-size/weltondev/stackauth-db/latest)](https://hub.docker.com/r/weltondev/stackauth-db)
[![Docker Stars](https://img.shields.io/docker/stars/weltondev/stackauth-db)](https://hub.docker.com/r/weltondev/stackauth-db)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/welton-dev/stackauth-db/main.yml)](https://github.com/welton-dev/stackauth-db/actions)
[![GitHub Release](https://img.shields.io/github/v/release/welton-dev/stackauth-db)](https://github.com/welton-dev/stackauth-db/releases/latest)
[![GitHub License](https://img.shields.io/github/license/welton-dev/stackauth-db)](https://github.com/welton-dev/stackauth-db/blob/main/LICENSE)

# StackAuth DB

A specialized Docker project for PostgreSQL with advanced extensions for query optimization and index management.

> 🔍 **Source Code**: [GitHub](https://github.com/welton-dev/stackauth-db) | 
> 🐳 **Docker Hub**: [weltondev/stackauth-db](https://hub.docker.com/r/weltondev/stackauth-db)

## 🚀 Technologies

This project was developed with the following technologies:

- PostgreSQL 15
- Docker (Multi-architecture: AMD64, ARM64)
- Docker Compose
- GitHub Actions for CI/CD
- PostgreSQL Extensions:
  - HypoPG
  - Index Advisor
  - pg_stat_statements

## 📋 Prerequisites

Before you begin, you need to have the following installed on your machine:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## 🔧 Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/stackauth-db.git
cd stackauth-db
```

2. Configure environment variables:
Create a `.env` file with the following variables:
```env
POSTGRES_USER=your_username
POSTGRES_PASSWORD=your_password
```

3. Start Docker containers:
```bash
docker-compose up -d
```

## ⚙️ PostgreSQL Configuration

The database can be configured through environment variables in the `docker-compose.yml` file. Below are the main available configurations:

### Memory and Resource Settings
- `POSTGRES_MAX_CONNECTIONS`: Maximum number of simultaneous connections (default: 100)
- `POSTGRES_SHARED_BUFFERS`: Shared memory for cache (default: 256MB)
- `POSTGRES_EFFECTIVE_CACHE_SIZE`: Operating system cache estimate (default: 768MB)
- `POSTGRES_WORK_MEM`: Memory for sorting operations (default: 4MB)
- `POSTGRES_MAINTENANCE_WORK_MEM`: Memory for maintenance operations (default: 64MB)

### WAL (Write-Ahead Log) Settings
- `POSTGRES_WAL_BUFFERS`: WAL buffer size (default: 16MB)
- `POSTGRES_MIN_WAL_SIZE`: Minimum WAL files size (default: 80MB)
- `POSTGRES_MAX_WAL_SIZE`: Maximum WAL files size (default: 1GB)
- `POSTGRES_WAL_LEVEL`: WAL detail level (default: logical)

### Parallelism Settings
- `POSTGRES_MAX_WORKER_PROCESSES`: Maximum number of worker processes (default: 8)
- `POSTGRES_MAX_PARALLEL_WORKERS`: Maximum number of parallel workers (default: 8)
- `POSTGRES_MAX_PARALLEL_WORKERS_PER_GATHER`: Workers per gather operation (default: 2)
- `POSTGRES_MAX_PARALLEL_MAINTENANCE_WORKERS`: Workers for maintenance (default: 2)

### Other Settings
- `POSTGRES_CHECKPOINT_COMPLETION_TARGET`: Checkpoint completion target (default: 0.9)
- `POSTGRES_STATISTICS_TARGET`: Statistics detail level (default: 100)
- `POSTGRES_RANDOM_PAGE_COST`: Estimated random read cost (default: 1.1)
- `POSTGRES_IO_CONCURRENCY`: Number of concurrent I/O operations (default: 200)
- `POSTGRES_AUTOVACUUM`: Enable/disable autovacuum (default: on)

### Configuration Example
```env
POSTGRES_MAX_CONNECTIONS=200
POSTGRES_SHARED_BUFFERS=1GB
POSTGRES_EFFECTIVE_CACHE_SIZE=3GB
POSTGRES_WORK_MEM=16MB
```

## 🛠️ Features

- **PostgreSQL 15 Database**: Stable and robust PostgreSQL version
- **HypoPG**: Extension for hypothetical index simulation
- **Index Advisor**: Tool for index recommendations
- **pg_stat_statements**: Query performance monitoring
- **Healthcheck**: Automatic database health verification
- **Persistent Volumes**: Persistent data storage

## 📦 Project Structure

```
stackauth-db/
├── .github/
│   └── workflows/    # GitHub Actions configurations
├── postgres/         # PostgreSQL configurations
├── dockerfile        # PostgreSQL container configuration
├── docker-compose.yml # Container orchestration
└── README.md
```

## 🔒 Security

- Sensitive variables are managed through environment variables
- Specific role configuration (anon)
- Integrated healthcheck to ensure availability

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is under the MIT license. See the [LICENSE](LICENSE) file for more details.

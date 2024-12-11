all: up

up:
	@echo "Starting Docker containers"
	mkdir -p /home/vsavolai/data/wordpress
	mkdir -p /home/vsavolai/data/mariadb
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@echo "Stop  Docker containers"
	docker-compose -f ./srcs/docker-compose.yml down

build:
	@echo "Building and starting Docker containers"
	mkdir -p /home/vsavolai/data/wordpress
	mkdir -p /home/vsavolai/data/mariadb
	docker-compose -f ./srcs/docker-compose.yml up -d --build

clean: 
	@echo "Cleaning docker containers"
	docker-compose -f ./srcs/docker-compose.yml down -v

fclean: clean
	sudo rm -rf /home/vsavolai/data/wordpress
	sudo rm -rf /home/vsavolai/data/mariadb
	docker system prune -a -f

re: down up
	@echo "Restarting Docker containers"


status:
	@echo "Running containers:"
	docker ps

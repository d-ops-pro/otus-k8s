PROJECT_NAME=default23

.PHONY: healthy
healthy:
	kubectl apply -f ./healthy

.PHONY: users
users:
	# installing PostgreSQL
	helm install users-db -f users/pg_values.yaml bitnami/postgresql

.PHONU: migrate-up
migrate-up:
	kubectl delete --all job
	kubectl apply -f jobs/migrate.yaml

.PHONY: sql-migrate
sql-migrate:
	docker build -t $(PROJECT_NAME)/sql-migrate:latest ./sql-migrate
	docker push $(PROJECT_NAME)/sql-migrate:latest

PROJECT_NAME=default23

.PHONY: healthy
healthy:
	kubectl apply -f ./healthy

.PHONY: test_healthy
test_healthy:
	# Checking readiness
	curl -XGET http://arch.homework/healthy/ready
	# Checking health
	curl -XGET http://arch.homework/healthy/health

.PHONY: users-db
users-db:
	# installing PostgreSQL
	helm install users-db -f users/pg_values.yaml bitnami/postgresql || echo "postgresql already installed"
.PHONY: users
users:
	# Installing the users Chart
	helm install users ./users || echo "users chart already installed"

.PHONY: users_redeploy
users_redeploy:
	kubectl delete --all jobs
	helm uninstall users
	helm install users ./users

.PHONY: sql-migrate
sql-migrate:
	docker build -t $(PROJECT_NAME)/sql-migrate:latest ./sql-migrate
	docker push $(PROJECT_NAME)/sql-migrate:latest

FROM golang:1.16 as builder

RUN apt-get update && apt-get install git gcc g++ && apt-get clean
RUN go get -v github.com/rubenv/sql-migrate/sql-migrate
RUN mv /go/bin/sql-migrate /bin/sql-migrate

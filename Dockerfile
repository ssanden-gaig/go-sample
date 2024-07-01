FROM golang:1.18-buster AS build

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN go build -o /pod-info

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /pod-info /pod-info

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/pod-info"]
# Start from the base image
FROM golang:1.21.5 

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY main.go .

RUN CGO_ENABLED=0 go build -v -o app .

FROM scratch

ENV TERM=xterm-256color

COPY --from=0 /app/app .

CMD ["./app"]
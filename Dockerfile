FROM golang:1.23

WORKDIR /app

COPY go.mod ./ 

RUN go mod tidy
RUN go mod download

COPY . .

RUN go build -o main .
EXPOSE 8080

CMD ["./main"]


FROM golang:1.25-alpine AS builder

WORKDIR /wick

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build ./cmd/wick

FROM alpine

COPY --from=builder /wick/wick /bin/wick

CMD ["/bin/wick"]

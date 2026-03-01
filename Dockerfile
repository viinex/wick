FROM golang:1.25-alpine AS builder

ARG TARGETARCH

WORKDIR /wick

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH:-amd64} go build -o /wick/wick ./cmd/wick

FROM alpine

COPY --from=builder /wick/wick /bin/wick

USER nobody

CMD ["/bin/wick"]

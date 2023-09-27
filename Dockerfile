FROM golang:1.21.1 as builder

WORKDIR /workspace

COPY go.mod go.mod
COPY go.sum go.sum

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -o /go/bin/motiong-cli ./cmd/

FROM alpine

COPY --from=builder /go/bin/motiong-cli /usr/local/bin/motiong-cli

ENTRYPOINT ["/usr/local/bin/motiong-cli"]

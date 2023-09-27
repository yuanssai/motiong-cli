FROM golang:1.21.1 as builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /workspace

COPY go.mod go.mod
COPY go.sum go.sum

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} go build -a -o /go/bin/motiong-cli ./cmd/motiong-cli

RUN chmod +x /go/bin/motiong-cli

FROM alpine

COPY --from=builder /go/bin/motiong-cli /usr/local/bin/motiong-cli

ENTRYPOINT ["/usr/local/bin/motiong-cli"]

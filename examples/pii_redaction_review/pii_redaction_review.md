# PII redaction review

This example redacts personal information from a support message, then recognises and links the remaining named entities using the Azure Text Analytics connector.

## Prerequisites

1. An Azure Text Analytics (Language) resource and its subscription key and endpoint.

2. Create a `Config.toml` file in this directory with the following content.

```toml
subscriptionKey = "<subscription key>"
serviceUrl = "<endpoint>/text/analytics/v3.1"
supportMessage = "<support message>"
```

## Run the example

```bash
bal run
```

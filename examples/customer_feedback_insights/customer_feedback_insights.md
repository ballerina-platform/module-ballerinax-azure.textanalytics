# Customer feedback insights

This example detects the language, scores the sentiment and extracts key phrases for a customer feedback entry using the Azure Text Analytics connector.

## Prerequisites

1. An Azure Text Analytics (Language) resource and its subscription key and endpoint.

2. Create a `Config.toml` file in this directory with the following content.

```toml
subscriptionKey = "<subscription key>"
serviceUrl = "<endpoint>/text/analytics/v3.1"
feedbackText = "<feedback entry>"
```

## Run the example

```bash
bal run
```

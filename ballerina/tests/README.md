# Running Tests

## Prerequisites

The tests run against a local mock service by default and need no credentials. To run them against the live Azure Text Analytics service, create an Azure Language resource and export its subscription key and endpoint.

## Test environments

The suite has two groups:

- `mock_tests` - run against the bundled mock service on `http://localhost:9090`.
- `live_tests` - run against the live service when `IS_LIVE_SERVER=true`. These cover the synchronous analysis operations (language detection, sentiment, key phrases, entity recognition, PII recognition and entity linking). The job operations are mock-only.

Set the following environment variables for live runs:

```bash
export IS_LIVE_SERVER=true
export AZURE_TEXTANALYTICS_KEY=<subscription key>
export AZURE_TEXTANALYTICS_SERVICE_URL=<endpoint>/text/analytics/v3.1
```

## Running the tests

Run the mock tests:

```bash
bal test --groups mock_tests
```

Run the live tests:

```bash
bal test --groups live_tests
```

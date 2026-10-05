# Examples

The `ballerinax/azure.textanalytics` connector provides practical examples illustrating usage in various scenarios.

1. [Customer feedback insights](./customer_feedback_insights/customer_feedback_insights.md) - Detect the language, score the sentiment and extract key phrases from customer feedback.
2. [PII redaction review](./pii_redaction_review/pii_redaction_review.md) - Redact personal information from support messages and link the remaining entities.

## Prerequisites

1. An Azure Cognitive Services Language (Text Analytics) resource with its subscription key and endpoint.

2. Create a `Config.toml` file in the example directory with the `subscriptionKey` and `serviceUrl` values (the endpoint followed by `/text/analytics/v3.1`).

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```

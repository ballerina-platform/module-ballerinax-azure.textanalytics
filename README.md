# Ballerina Azure Text Analytics connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-azure.textanalytics/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-azure.textanalytics/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-azure.textanalytics.svg)](https://github.com/ballerina-platform/module-ballerinax-azure.textanalytics/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/azure.textanalytics.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fazure.textanalytics)

## Overview

[Azure Text Analytics](https://azure.microsoft.com/en-us/services/cognitive-services/text-analytics/) is a suite of natural language processing (NLP) services built with Microsoft machine learning algorithms. It analyzes unstructured text for tasks such as sentiment analysis, key phrase extraction, language detection and entity recognition, with additional support for healthcare and personal information analysis.

The Azure Text Analytics connector lets Ballerina applications call the Text Analytics REST API, version 3.1.

## Setup guide

To use the connector you need an Azure Cognitive Services Language (Text Analytics) resource.

1. Sign in to the [Azure portal](https://portal.azure.com) and create a **Language** resource.

2. Open the resource and select **Keys and Endpoint**.

3. Copy one of the subscription keys and the endpoint. The connector sends the key in the `Ocp-Apim-Subscription-Key` header.

## Quickstart

To use the Azure Text Analytics connector in your Ballerina application, update the `.bal` file as follows.

**Step 1:** Import the connector.

```ballerina
import ballerinax/azure.textanalytics;
```

**Step 2:** Create a `Config.toml` file with your subscription key and endpoint.

```toml
subscriptionKey = "<subscription key>"
serviceUrl = "<endpoint>/text/analytics/v3.1"
```

**Step 3:** Create a client.

```ballerina
configurable string subscriptionKey = ?;
configurable string serviceUrl = ?;

textanalytics:Client textAnalytics = check new ({ocpApimSubscriptionKey: subscriptionKey}, serviceUrl = serviceUrl);
```

**Step 4:** Detect the language of a document.

```ballerina
public function main() returns error? {
    textanalytics:LanguageResult _ = check textAnalytics->detectLanguage({
        documents: [{id: "1", text: "Hello world"}]
    });
}
```

## Examples

The `Azure Text Analytics` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-azure.textanalytics/tree/main/examples/), covering the following use cases:

- [Customer feedback insights](examples/customer_feedback_insights/customer_feedback_insights.md) - Detect the language, score the sentiment and extract key phrases from customer feedback.
- [PII redaction review](examples/pii_redaction_review/pii_redaction_review.md) - Redact personal information from support messages and link the remaining entities.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`azure.textanalytics` package](https://central.ballerina.io/ballerinax/azure.textanalytics/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.

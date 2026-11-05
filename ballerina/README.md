## Overview

[Azure Text Analytics](https://azure.microsoft.com/en-us/services/cognitive-services/text-analytics/) is a suite of natural language processing (NLP) services built with Microsoft machine learning algorithms. It analyzes unstructured text for tasks such as sentiment analysis, key phrase extraction, language detection and entity recognition, with additional support for healthcare and personal information analysis.

The Azure Text Analytics connector lets Ballerina applications call the Text Analytics REST API, version 3.1.

### Key features

- Detect the language of text documents
- Analyze sentiment, including opinion mining at sentence and target level
- Extract key phrases from unstructured text
- Recognize named entities, personal information and linked entities from a knowledge base
- Run long-running analysis and healthcare jobs and track their status

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

- [Customer feedback insights](../examples/customer_feedback_insights/customer_feedback_insights.md) - Detect the language, score the sentiment and extract key phrases from customer feedback.
- [PII redaction review](../examples/pii_redaction_review/pii_redaction_review.md) - Redact personal information from support messages and link the remaining entities.

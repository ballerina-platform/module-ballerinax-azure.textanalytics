_Author_:  Dimuthu Madushan \
_Created_: 2026/10/05 \
_Updated_: 2026/10/05 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Azure Text Analytics.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/azure/textanalytics/v3.1/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Removed the `x-ms-examples` blocks from all operations before flattening. They hold eleven external `$ref`s to example files (`.//examples//*.json`) that are not part of the specification, so the specification is not self-contained. The original `docs/spec/openapi.json` is left unchanged; the edit is made in a working copy, `build/spec/openapi.json`, which is the input to flatten and align.

   Operations affected: `/analyze`, `/analyze/jobs/{jobId}`, `/entities/health/jobs`, `/entities/health/jobs/{jobId}` (GET and DELETE), `/entities/recognition/general`, `/entities/recognition/pii`, `/entities/linking`, `/keyPhrases`, `/languages`, `/sentiment`.

2. Added a `servers` entry to the aligned specification, because the specification declares its host only through `x-ms-parameterized-host` (`{Endpoint}/text/analytics/{ApiVersion}`), which the generator ignores and which would leave `serviceUrl` without a default.

   Updated: `https://westus.api.cognitive.microsoft.com/text/analytics/v3.1`

3. Changed the media type of the `MultiLanguageInput` and `LanguageInput` request bodies from `*/*` to `application/json`. With `*/*` the generator emits an `http:Request` parameter for `submitHealthcareJob`, `recognizeEntities`, `recognizePiiEntities`, `linkEntities`, `extractKeyPhrases`, `detectLanguage` and `analyzeSentiment` instead of a typed payload.

4. Renamed the `$top` and `$skip` parameter names generated for `getAnalysisJob` and `getHealthcareJob` by changing `x-ballerina-name` from `dollarTop` / `dollarSkip` to `top` / `skip`. The wire names stay `$top` and `$skip`.

5. Added a description to the `apim_key` security scheme.

   Updated: `Azure Cognitive Services subscription key supplied in the Ocp-Apim-Subscription-Key header`

6. Replaced the PascalCase operation IDs with intent-revealing camelCase names, persisted in `ai-mappings.json`: `submitAnalysisJob`, `getAnalysisJob`, `submitHealthcareJob`, `getHealthcareJob`, `cancelHealthcareJob`, `recognizeEntities`, `recognizePiiEntities`, `linkEntities`, `extractKeyPhrases`, `detectLanguage` and `analyzeSentiment`.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```

Note: The license year is hardcoded to 2026, change if necessary.

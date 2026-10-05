_Author_:  Dimuthu Madushan \
_Created_: 2026/10/05 \
_Updated_: 2026/10/05 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Azure Text Analytics.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/azure/textanalytics/v3.1/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Removed the `x-ms-examples` blocks from all operations before flattening. They hold eleven external `$ref`s to example files (`.//examples//*.json`) that are not part of the specification, so the specification is not self-contained. The blocks are removed from the original `docs/spec/openapi.json`, which is the input to flatten and align.

   Operations affected: `/analyze`, `/analyze/jobs/{jobId}`, `/entities/health/jobs`, `/entities/health/jobs/{jobId}` (GET and DELETE), `/entities/recognition/general`, `/entities/recognition/pii`, `/entities/linking`, `/keyPhrases`, `/languages`, `/sentiment`.

2. Added `host`, `basePath` and `schemes` to the original specification, because it declares its host only through `x-ms-parameterized-host` (`{Endpoint}/text/analytics/{ApiVersion}`), which the generator ignores and which would leave `serviceUrl` without a default. Flatten converts them into a `servers` entry in the aligned specification.

   Updated: `host: westus.api.cognitive.microsoft.com`, `basePath: /text/analytics/v3.1`, `schemes: [https]` (aligned `servers`: `https://westus.api.cognitive.microsoft.com/text/analytics/v3.1`)

3. Added a top-level `consumes: ["application/json"]` to the original specification, which changes the media type of the `MultiLanguageInput` and `LanguageInput` request bodies from `*/*` to `application/json` in the aligned specification. With `*/*` the generator emits an `http:Request` parameter for `submitHealthcareJob`, `recognizeEntities`, `recognizePiiEntities`, `linkEntities`, `extractKeyPhrases`, `detectLanguage` and `analyzeSentiment` instead of a typed payload.

4. Renamed the `$top` and `$skip` parameter names generated for `getAnalysisJob` and `getHealthcareJob` by changing `x-ballerina-name` from `dollarTop` / `dollarSkip` to `top` / `skip`. The wire names stay `$top` and `$skip`. This is applied to the aligned specification (`docs/spec/aligned_ballerina_openapi.json`) after align and must be re-applied after every re-align: align generates the parameter-level `x-ballerina-name` itself, and an `x-ballerina-name` set on the original parameter is not carried to that level (it lands on the parameter schema and has no effect).

5. Added a description to the `apim_key` security scheme in the original specification.

   Updated: `Azure Cognitive Services subscription key supplied in the Ocp-Apim-Subscription-Key header`

6. Replaced the PascalCase operation IDs with intent-revealing camelCase names, persisted in `ai-mappings.json`: `submitAnalysisJob`, `getAnalysisJob`, `submitHealthcareJob`, `getHealthcareJob`, `cancelHealthcareJob`, `recognizeEntities`, `recognizePiiEntities`, `linkEntities`, `extractKeyPhrases`, `detectLanguage` and `analyzeSentiment`.

7. Made the 202 job-submission responses of `POST /analyze` (`submitAnalysisJob`) and `POST /entities/health/jobs` (`submitHealthcareJob`) return `http:Response` so callers can read the `Operation-Location` header and recover the job ID. Both responses declare only that header and no body, which the generator maps to `error?`, discarding the header. In the original specification, both operations now declare `produces: ["*/*"]` (was `application/json`, `text/json`) and their `202` response gets `schema: {type: file}`; the generator then emits a `*/*` binary response and the methods return `http:Response|error`. The `default` error response is unchanged.

   Updated: `/analyze` and `/entities/health/jobs` POST: `produces: ["*/*"]`, `responses.202.schema: {type: file}`

8. Removed the `enum` constraint from the open-ended (`x-ms-enum` with `modelAsString: true`) properties `HealthcareEntityProperties.category`, `HealthcareRelation.relationType`, `TextAnalyticsError.code`, `InnerError.code` and `TextAnalyticsWarning.code` in the original specification, so they are generated as `string` and values the service adds later still bind. The known values are listed in each property description as `Known values: ...`. Other enums, including the closed `TargetRelationType` and `StringIndexType`, are unchanged. The description of `TextAnalyticsWarning.code` was also corrected from "Error code" to "Warning code".

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```

Note: The license year is hardcoded to 2024, change if necessary.

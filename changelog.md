# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Regenerated the connector from the Text Analytics v3.1 OpenAPI specification. All operations are remote methods with the names `submitAnalysisJob`, `getAnalysisJob`, `submitHealthcareJob`, `getHealthcareJob`, `cancelHealthcareJob`, `recognizeEntities`, `recognizePiiEntities`, `linkEntities`, `extractKeyPhrases`, `detectLanguage` and `analyzeSentiment`.
- The `$top` and `$skip` query parameters are exposed as `top` and `skip`.
- The `serviceUrl` defaults to `https://westus.api.cognitive.microsoft.com/text/analytics/v3.1`.
- `submitAnalysisJob` and `submitHealthcareJob` return `http:Response|error` instead of `error?`, so the job ID can be read from the `Operation-Location` response header.
- `HealthcareEntityProperties.category`, `HealthcareRelation.relationType`, `TextAnalyticsError.code`, `InnerError.code` and `TextAnalyticsWarning.code` are typed as `string` instead of closed unions, so values added by the service bind correctly.

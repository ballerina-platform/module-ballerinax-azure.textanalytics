# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Regenerated the connector from the Text Analytics v3.1 OpenAPI specification. All operations are remote methods with the names `submitAnalysisJob`, `getAnalysisJob`, `submitHealthcareJob`, `getHealthcareJob`, `cancelHealthcareJob`, `recognizeEntities`, `recognizePiiEntities`, `linkEntities`, `extractKeyPhrases`, `detectLanguage` and `analyzeSentiment`.
- The `$top` and `$skip` query parameters are exposed as `top` and `skip`.
- The `serviceUrl` defaults to `https://westus.api.cognitive.microsoft.com/text/analytics/v3.1`.

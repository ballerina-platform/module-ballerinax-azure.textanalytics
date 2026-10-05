// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

listener http:Listener ep0 = new (9090);

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {
    # Cancel healthcare prediction job
    #
    # + jobId - Job ID
    # + return - Cancel job request accepted
    resource function delete entities/health/jobs/[string jobId]() returns http:Accepted {
        return http:ACCEPTED;
    }

    # Get analysis status and results
    #
    # + jobId - Job ID for Analyze
    # + showStats - Include request and document level statistics
    # + top - Maximum number of results per task
    # + skip - Number of elements to offset in the response
    # + return - Analysis job status and metadata
    resource function get analyze/jobs/[string jobId](boolean? showStats, @http:Query {name: "$top"} int top = 20, @http:Query {name: "$skip"} int skip = 0) returns AnalyzeJobState {
        return {
            jobId,
            createdDateTime: "2026-10-05T09:00:00Z",
            lastUpdateDateTime: "2026-10-05T09:00:05Z",
            expirationDateTime: "2026-10-06T09:00:00Z",
            status: "succeeded",
            displayName: "Contoso feedback analysis",
            tasks: {total: 1, completed: 1, failed: 0, inProgress: 0}
        };
    }

    # Get healthcare analysis job status and results
    #
    # + jobId - Job ID
    # + showStats - Include request and document level statistics
    # + top - Maximum number of results per task
    # + skip - Number of elements to offset in the response
    # + return - Healthcare job status and results
    resource function get entities/health/jobs/[string jobId](boolean? showStats, @http:Query {name: "$top"} int top = 20, @http:Query {name: "$skip"} int skip = 0) returns HealthcareJobState {
        return {
            jobId,
            createdDateTime: "2026-10-05T09:00:00Z",
            lastUpdateDateTime: "2026-10-05T09:00:05Z",
            status: "succeeded",
            results: {
                documents: [
                    {
                        id: "1",
                        entities: [],
                        relations: [],
                        warnings: []
                    }
                ],
                errors: [],
                modelVersion: "2021-05-15"
            }
        };
    }

    # Submit analysis job
    #
    # + payload - Collection of documents to analyze and tasks to execute
    # + return - Analysis job accepted
    resource function post analyze(@http:Payload AnalyzeBatchInput payload) returns http:Accepted {
        return http:ACCEPTED;
    }

    # Submit healthcare analysis job
    #
    # + modelVersion - Model version used for scoring
    # + loggingOptOut - Opt out of input text logging
    # + stringIndexType - Method used to interpret string offsets
    # + payload - Collection of documents to analyze
    # + return - Healthcare job accepted
    resource function post entities/health/jobs(@http:Payload MultiLanguageBatchInput payload, @http:Query {name: "model-version"} string? modelVersion, boolean? loggingOptOut, string stringIndexType = "TextElement_v8") returns http:Accepted {
        return http:ACCEPTED;
    }

    # Linked entities from a well known knowledge base
    #
    # + modelVersion - Model version used for scoring
    # + showStats - Include request and document level statistics
    # + loggingOptOut - Opt out of input text logging
    # + stringIndexType - Method used to interpret string offsets
    # + payload - Collection of documents to analyze
    # + return - Linked entities for each document
    resource function post entities/linking(@http:Payload MultiLanguageBatchInput payload, @http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, string stringIndexType = "TextElement_v8") returns EntityLinkingResult {
        return {
            documents: [
                {
                    id: "1",
                    entities: [
                        {
                            name: "Seattle",
                            language: "en",
                            id: "Seattle",
                            dataSource: "Wikipedia",
                            url: "https://en.wikipedia.org/wiki/Seattle",
                            matches: [{text: "Seattle", offset: 26, length: 7, confidenceScore: 0.15}]
                        }
                    ],
                    warnings: []
                }
            ],
            errors: [],
            modelVersion: "2021-06-01"
        };
    }

    # Named Entity Recognition
    #
    # + modelVersion - Model version used for scoring
    # + showStats - Include request and document level statistics
    # + loggingOptOut - Opt out of input text logging
    # + stringIndexType - Method used to interpret string offsets
    # + payload - Collection of documents to analyze
    # + return - Recognized entities for each document
    resource function post entities/recognition/general(@http:Payload MultiLanguageBatchInput payload, @http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, string stringIndexType = "TextElement_v8") returns EntitiesResult {
        return {
            documents: [
                {
                    id: "1",
                    entities: [
                        {text: "Microsoft", category: "Organization", offset: 0, length: 9, confidenceScore: 0.98},
                        {text: "Redmond", category: "Location", subcategory: "GPE", offset: 30, length: 7, confidenceScore: 0.93}
                    ],
                    warnings: []
                }
            ],
            errors: [],
            modelVersion: "2021-06-01"
        };
    }

    # Entities containing personal information
    #
    # + modelVersion - Model version used for scoring
    # + showStats - Include request and document level statistics
    # + loggingOptOut - Opt out of input text logging
    # + domain - PII domain used to limit the entity categories
    # + piiCategories - PII categories to return
    # + payload - Collection of documents to analyze
    # + return - Entities with personal information for each document
    resource function post entities/recognition/pii(@http:Payload MultiLanguageBatchInput payload, @http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, string? domain, string[]? piiCategories, string stringIndexType = "TextElement_v8") returns PiiResult {
        return {
            documents: [
                {
                    id: "1",
                    redactedText: "Call me at ************",
                    entities: [
                        {text: "555-0100-123", category: "PhoneNumber", offset: 11, length: 12, confidenceScore: 0.8}
                    ],
                    warnings: []
                }
            ],
            errors: [],
            modelVersion: "2021-01-15"
        };
    }

    # Key Phrases
    #
    # + modelVersion - Model version used for scoring
    # + showStats - Include request and document level statistics
    # + loggingOptOut - Opt out of input text logging
    # + payload - Collection of documents to analyze
    # + return - Key phrases for each document
    resource function post keyPhrases(@http:Payload MultiLanguageBatchInput payload, @http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut) returns KeyPhraseResult {
        return {
            documents: [
                {id: "1", keyPhrases: ["wonderful hotel", "friendly staff"], warnings: []}
            ],
            errors: [],
            modelVersion: "2021-06-01"
        };
    }

    # Detect Language
    #
    # + modelVersion - Model version used for scoring
    # + showStats - Include request and document level statistics
    # + loggingOptOut - Opt out of input text logging
    # + payload - Collection of documents to analyze for language
    # + return - Detected language for each document
    resource function post languages(@http:Payload LanguageBatchInput payload, @http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut) returns LanguageResult {
        return {
            documents: [
                {
                    id: "1",
                    detectedLanguage: {name: "English", iso6391Name: "en", confidenceScore: 1.0},
                    warnings: []
                }
            ],
            errors: [],
            modelVersion: "2021-01-05"
        };
    }

    # Sentiment
    #
    # + modelVersion - Model version used for scoring
    # + showStats - Include request and document level statistics
    # + loggingOptOut - Opt out of input text logging
    # + opinionMining - Include opinion mining results
    # + stringIndexType - Method used to interpret string offsets
    # + payload - Collection of documents to analyze
    # + return - Sentiment prediction for each document
    resource function post sentiment(@http:Payload MultiLanguageBatchInput payload, @http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, boolean? opinionMining, string stringIndexType = "TextElement_v8") returns SentimentResponse {
        return {
            documents: [
                {
                    id: "1",
                    sentiment: "positive",
                    confidenceScores: {positive: 0.98, neutral: 0.01, negative: 0.01},
                    sentences: [
                        {
                            text: "The food was delicious.",
                            sentiment: "positive",
                            offset: 0,
                            length: 23,
                            confidenceScores: {positive: 0.98, neutral: 0.01, negative: 0.01}
                        }
                    ],
                    warnings: []
                }
            ],
            errors: [],
            modelVersion: "2020-04-01"
        };
    }
}

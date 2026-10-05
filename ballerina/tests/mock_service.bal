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
    # + return - returns can be any of following types 
    # http:Accepted (Cancel Job request has been received)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function delete entities/health/jobs/[string jobId]() returns http:Accepted|ErrorResponseDefault {
        return http:ACCEPTED;
    }

    # Get analysis status and results
    #
    # + jobId - Job ID for Analyze
    # + showStats - (Optional) if set to true, response will contain request and document level statistics
    # + top - (Optional) Set the maximum number of results per task. When both $top and $skip are specified, $skip is applied first
    # + skip - (Optional) Set the number of elements to offset in the response. When both $top and $skip are specified, $skip is applied first
    # + return - returns can be any of following types 
    # http:Ok (Analysis job status and metadata)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function get analyze/jobs/[string jobId](boolean? showStats, @http:Query {name: "$top"} int top = 20, @http:Query {name: "$skip"} int skip = 0) returns AnalyzeJobState|ErrorResponseDefault {
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
    # + top - (Optional) Set the maximum number of results per task. When both $top and $skip are specified, $skip is applied first
    # + skip - (Optional) Set the number of elements to offset in the response. When both $top and $skip are specified, $skip is applied first
    # + showStats - (Optional) if set to true, response will contain request and document level statistics
    # + return - returns can be any of following types 
    # http:Ok (OK)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function get entities/health/jobs/[string jobId](boolean? showStats, @http:Query {name: "$top"} int top = 20, @http:Query {name: "$skip"} int skip = 0) returns HealthcareJobState|ErrorResponseDefault {
        return {
            jobId,
            createdDateTime: "2026-10-05T09:00:00Z",
            lastUpdateDateTime: "2026-10-05T09:00:05Z",
            status: "succeeded",
            results: {
                documents: [
                    {
                        id: "1",
                        entities: [
                            {offset: 0, length: 9, text: "ibuprofen", category: "MedicationName", confidenceScore: 0.99}
                        ],
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
    # + return - returns can be any of following types 
    # http:Accepted (A successful call results with an Operation-Location header used to check the status of the analysis job)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function post analyze(@http:Payload AnalyzeBatchInput payload) returns AnydataAccepted|AnydataDefault {
        return <AnydataAccepted>{
            body: (),
            headers: {Operation\-Location: "http://localhost:9090/analyze/jobs/3f0c9a52-7d1e-4b8a-9c36-5a1d2e7b4f10"}
        };
    }

    # Submit healthcare analysis job
    #
    # + modelVersion - (Optional) This value indicates which model will be used for scoring. If a model-version is not specified, the API should default to the latest, non-preview version. 
    # + stringIndexType - (Optional) Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets
    # + loggingOptOut - (Optional) If set to true, you opt-out of having your text input logged for troubleshooting. By default, Text Analytics logs your input text for 48 hours, solely to allow for troubleshooting issues in providing you with the Text Analytics natural language processing functions. Setting this parameter to true, disables input logging and may limit our ability to remediate issues that occur.  Please see Cognitive Services Compliance and Privacy notes at https://aka.ms/cs-compliance for additional details, and Microsoft Responsible AI principles at https://www.microsoft.com/en-us/ai/responsible-ai
    # + payload - Collection of documents to analyze 
    # + return - returns can be any of following types 
    # http:Accepted (Accepted - call results in a link where the status of the submitted job can be checked via the GET operation)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function post entities/health/jobs(@http:Query {name: "model-version"} string? modelVersion, boolean? loggingOptOut, @http:Payload MultiLanguageBatchInput payload, "TextElement_v8"|"UnicodeCodePoint"|"Utf16CodeUnit" stringIndexType = "TextElement_v8") returns AnydataAccepted|AnydataDefault {
        return <AnydataAccepted>{
            body: (),
            headers: {Operation\-Location: "http://localhost:9090/entities/health/jobs/8b7e4d21-0c5a-4f93-a1d6-2e9b3c6f7a58"}
        };
    }

    # Linked entities from a well known knowledge base
    #
    # + modelVersion - (Optional) This value indicates which model will be used for scoring. If a model-version is not specified, the API should default to the latest, non-preview version. 
    # + showStats - (Optional) if set to true, response will contain request and document level statistics
    # + loggingOptOut - (Optional) If set to true, you opt-out of having your text input logged for troubleshooting. By default, Text Analytics logs your input text for 48 hours, solely to allow for troubleshooting issues in providing you with the Text Analytics natural language processing functions. Setting this parameter to true, disables input logging and may limit our ability to remediate issues that occur.  Please see Cognitive Services Compliance and Privacy notes at https://aka.ms/cs-compliance for additional details, and Microsoft Responsible AI principles at https://www.microsoft.com/en-us/ai/responsible-ai
    # + stringIndexType - (Optional) Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets
    # + payload - Collection of documents to analyze 
    # + return - returns can be any of following types 
    # http:Ok (A successful call results in a list of recognized entities with links to a well known knowledge base returned for each valid document)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function post entities/linking(@http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, @http:Payload MultiLanguageBatchInput payload, "TextElement_v8"|"UnicodeCodePoint"|"Utf16CodeUnit" stringIndexType = "TextElement_v8") returns EntityLinkingResultOk|ErrorResponseDefault {
        return {
            body: {
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
            }
        };
    }

    # Named Entity Recognition
    #
    # + modelVersion - (Optional) This value indicates which model will be used for scoring. If a model-version is not specified, the API should default to the latest, non-preview version. 
    # + showStats - (Optional) if set to true, response will contain request and document level statistics
    # + loggingOptOut - (Optional) If set to true, you opt-out of having your text input logged for troubleshooting. By default, Text Analytics logs your input text for 48 hours, solely to allow for troubleshooting issues in providing you with the Text Analytics natural language processing functions. Setting this parameter to true, disables input logging and may limit our ability to remediate issues that occur.  Please see Cognitive Services Compliance and Privacy notes at https://aka.ms/cs-compliance for additional details, and Microsoft Responsible AI principles at https://www.microsoft.com/en-us/ai/responsible-ai
    # + stringIndexType - (Optional) Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets
    # + payload - Collection of documents to analyze 
    # + return - returns can be any of following types 
    # http:Ok (A successful call results in a list of recognized entities returned for each valid document)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function post entities/recognition/general(@http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, @http:Payload MultiLanguageBatchInput payload, "TextElement_v8"|"UnicodeCodePoint"|"Utf16CodeUnit" stringIndexType = "TextElement_v8") returns EntitiesResultOk|ErrorResponseDefault {
        return {
            body: {
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
            }
        };
    }

    # Entities containing personal information
    #
    # + modelVersion - (Optional) This value indicates which model will be used for scoring. If a model-version is not specified, the API should default to the latest, non-preview version. 
    # + showStats - (Optional) if set to true, response will contain request and document level statistics
    # + loggingOptOut - (Optional) If set to true, you opt-out of having your text input logged for troubleshooting. By default, Text Analytics logs your input text for 48 hours, solely to allow for troubleshooting issues in providing you with the Text Analytics natural language processing functions. Setting this parameter to true, disables input logging and may limit our ability to remediate issues that occur.  Please see Cognitive Services Compliance and Privacy notes at https://aka.ms/cs-compliance for additional details, and Microsoft Responsible AI principles at https://www.microsoft.com/en-us/ai/responsible-ai
    # + domain - (Optional) if specified, will set the PII domain to include only a subset of the entity categories. Possible values include: 'PHI', 'none'
    # + stringIndexType - (Optional) Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets
    # + piiCategories - (Optional) describes the PII categories to return
    # + payload - Collection of documents to analyze 
    # + return - returns can be any of following types 
    # http:Ok (A successful call results in a list of entities containing personal information returned for each valid document)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function post entities/recognition/pii(@http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, string? domain, ("ABARoutingNumber"|"ARNationalIdentityNumber"|"AUBankAccountNumber"|"AUDriversLicenseNumber"|"AUMedicalAccountNumber"|"AUPassportNumber"|"AUTaxFileNumber"|"AUBusinessNumber"|"AUCompanyNumber"|"ATIdentityCard"|"ATTaxIdentificationNumber"|"ATValueAddedTaxNumber"|"AzureDocumentDBAuthKey"|"AzureIAASDatabaseConnectionAndSQLString"|"AzureIoTConnectionString"|"AzurePublishSettingPassword"|"AzureRedisCacheString"|"AzureSAS"|"AzureServiceBusString"|"AzureStorageAccountKey"|"AzureStorageAccountGeneric"|"BENationalNumber"|"BENationalNumberV2"|"BEValueAddedTaxNumber"|"BRCPFNumber"|"BRLegalEntityNumber"|"BRNationalIDRG"|"BGUniformCivilNumber"|"CABankAccountNumber"|"CADriversLicenseNumber"|"CAHealthServiceNumber"|"CAPassportNumber"|"CAPersonalHealthIdentification"|"CASocialInsuranceNumber"|"CLIdentityCardNumber"|"CNResidentIdentityCardNumber"|"CreditCardNumber"|"HRIdentityCardNumber"|"HRNationalIDNumber"|"HRPersonalIdentificationNumber"|"HRPersonalIdentificationOIBNumberV2"|"CYIdentityCard"|"CYTaxIdentificationNumber"|"CZPersonalIdentityNumber"|"CZPersonalIdentityV2"|"DKPersonalIdentificationNumber"|"DKPersonalIdentificationV2"|"DrugEnforcementAgencyNumber"|"EEPersonalIdentificationCode"|"EUDebitCardNumber"|"EUDriversLicenseNumber"|"EUGPSCoordinates"|"EUNationalIdentificationNumber"|"EUPassportNumber"|"EUSocialSecurityNumber"|"EUTaxIdentificationNumber"|"FIEuropeanHealthNumber"|"FINationalID"|"FINationalIDV2"|"FIPassportNumber"|"FRDriversLicenseNumber"|"FRHealthInsuranceNumber"|"FRNationalID"|"FRPassportNumber"|"FRSocialSecurityNumber"|"FRTaxIdentificationNumber"|"FRValueAddedTaxNumber"|"DEDriversLicenseNumber"|"DEPassportNumber"|"DEIdentityCardNumber"|"DETaxIdentificationNumber"|"DEValueAddedNumber"|"GRNationalIDCard"|"GRNationalIDV2"|"GRTaxIdentificationNumber"|"HKIdentityCardNumber"|"HUValueAddedNumber"|"HUPersonalIdentificationNumber"|"HUTaxIdentificationNumber"|"INPermanentAccount"|"INUniqueIdentificationNumber"|"IDIdentityCardNumber"|"InternationalBankingAccountNumber"|"IEPersonalPublicServiceNumber"|"IEPersonalPublicServiceNumberV2"|"ILBankAccountNumber"|"ILNationalID"|"ITDriversLicenseNumber"|"ITFiscalCode"|"ITValueAddedTaxNumber"|"JPBankAccountNumber"|"JPDriversLicenseNumber"|"JPPassportNumber"|"JPResidentRegistrationNumber"|"JPSocialInsuranceNumber"|"JPMyNumberCorporate"|"JPMyNumberPersonal"|"JPResidenceCardNumber"|"LVPersonalCode"|"LTPersonalCode"|"LUNationalIdentificationNumberNatural"|"LUNationalIdentificationNumberNonNatural"|"MYIdentityCardNumber"|"MTIdentityCardNumber"|"MTTaxIDNumber"|"NLCitizensServiceNumber"|"NLCitizensServiceNumberV2"|"NLTaxIdentificationNumber"|"NLValueAddedTaxNumber"|"NZBankAccountNumber"|"NZDriversLicenseNumber"|"NZInlandRevenueNumber"|"NZMinistryOfHealthNumber"|"NZSocialWelfareNumber"|"NOIdentityNumber"|"PHUnifiedMultiPurposeIDNumber"|"PLIdentityCard"|"PLNationalID"|"PLNationalIDV2"|"PLPassportNumber"|"PLTaxIdentificationNumber"|"PLREGONNumber"|"PTCitizenCardNumber"|"PTCitizenCardNumberV2"|"PTTaxIdentificationNumber"|"ROPersonalNumericalCode"|"RUPassportNumberDomestic"|"RUPassportNumberInternational"|"SANationalID"|"SGNationalRegistrationIdentityCardNumber"|"SKPersonalNumber"|"SITaxIdentificationNumber"|"SIUniqueMasterCitizenNumber"|"ZAIdentificationNumber"|"KRResidentRegistrationNumber"|"ESDNI"|"ESSocialSecurityNumber"|"ESTaxIdentificationNumber"|"SQLServerConnectionString"|"SENationalID"|"SENationalIDV2"|"SEPassportNumber"|"SETaxIdentificationNumber"|"SWIFTCode"|"CHSocialSecurityNumber"|"TWNationalID"|"TWPassportNumber"|"TWResidentCertificate"|"THPopulationIdentificationCode"|"TRNationalIdentificationNumber"|"UKDriversLicenseNumber"|"UKElectoralRollNumber"|"UKNationalHealthNumber"|"UKNationalInsuranceNumber"|"UKUniqueTaxpayerNumber"|"USUKPassportNumber"|"USBankAccountNumber"|"USDriversLicenseNumber"|"USIndividualTaxpayerIdentification"|"USSocialSecurityNumber"|"UAPassportNumberDomestic"|"UAPassportNumberInternational"|"Organization"|"Email"|"URL"|"Age"|"PhoneNumber"|"IPAddress"|"Date"|"Person"|"Address"|"All"|"Default")[]? piiCategories, @http:Payload MultiLanguageBatchInput payload, "TextElement_v8"|"UnicodeCodePoint"|"Utf16CodeUnit" stringIndexType = "TextElement_v8") returns PiiResultOk|ErrorResponseDefault {
        return {
            body: {
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
            }
        };
    }

    # Key Phrases
    #
    # + modelVersion - (Optional) This value indicates which model will be used for scoring. If a model-version is not specified, the API should default to the latest, non-preview version. 
    # + showStats - (Optional) if set to true, response will contain request and document level statistics
    # + loggingOptOut - (Optional) If set to true, you opt-out of having your text input logged for troubleshooting. By default, Text Analytics logs your input text for 48 hours, solely to allow for troubleshooting issues in providing you with the Text Analytics natural language processing functions. Setting this parameter to true, disables input logging and may limit our ability to remediate issues that occur.  Please see Cognitive Services Compliance and Privacy notes at https://aka.ms/cs-compliance for additional details, and Microsoft Responsible AI principles at https://www.microsoft.com/en-us/ai/responsible-ai
    # + payload - Collection of documents to analyze 
    # + return - returns can be any of following types 
    # http:Ok (A successful response results in 0 or more key phrases identified in each valid document)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function post keyPhrases(@http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, @http:Payload MultiLanguageBatchInput payload) returns KeyPhraseResultOk|ErrorResponseDefault {
        return {
            body: {
                documents: [
                    {id: "1", keyPhrases: ["wonderful hotel", "friendly staff"], warnings: []}
                ],
                errors: [],
                modelVersion: "2021-06-01"
            }
        };
    }

    # Detect Language
    #
    # + modelVersion - (Optional) This value indicates which model will be used for scoring. If a model-version is not specified, the API should default to the latest, non-preview version. 
    # + showStats - (Optional) if set to true, response will contain request and document level statistics
    # + loggingOptOut - (Optional) If set to true, you opt-out of having your text input logged for troubleshooting. By default, Text Analytics logs your input text for 48 hours, solely to allow for troubleshooting issues in providing you with the Text Analytics natural language processing functions. Setting this parameter to true, disables input logging and may limit our ability to remediate issues that occur.  Please see Cognitive Services Compliance and Privacy notes at https://aka.ms/cs-compliance for additional details, and Microsoft Responsible AI principles at https://www.microsoft.com/en-us/ai/responsible-ai
    # + payload - Collection of documents to analyze for language endpoint 
    # + return - returns can be any of following types 
    # http:Ok (A successful call results in the detected language with the highest probability for each valid document)
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function post languages(@http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, @http:Payload LanguageBatchInput payload) returns LanguageResultOk|ErrorResponseDefault {
        return {
            body: {
                documents: [
                    {
                        id: "1",
                        detectedLanguage: {name: "English", iso6391Name: "en", confidenceScore: 1.0},
                        warnings: []
                    }
                ],
                errors: [],
                modelVersion: "2021-01-05"
            }
        };
    }

    # Sentiment
    #
    # + modelVersion - (Optional) This value indicates which model will be used for scoring. If a model-version is not specified, the API should default to the latest, non-preview version. 
    # + showStats - (Optional) if set to true, response will contain request and document level statistics
    # + loggingOptOut - (Optional) If set to true, you opt-out of having your text input logged for troubleshooting. By default, Text Analytics logs your input text for 48 hours, solely to allow for troubleshooting issues in providing you with the Text Analytics natural language processing functions. Setting this parameter to true, disables input logging and may limit our ability to remediate issues that occur.  Please see Cognitive Services Compliance and Privacy notes at https://aka.ms/cs-compliance for additional details, and Microsoft Responsible AI principles at https://www.microsoft.com/en-us/ai/responsible-ai
    # + opinionMining - (Optional) if set to true, response will contain not only sentiment prediction but also opinion mining (aspect-based sentiment analysis) results
    # + stringIndexType - (Optional) Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets
    # + payload - Collection of documents to analyze 
    # + return - returns can be any of following types 
    # http:Ok (A successful call results in a document sentiment prediction, as well as sentiment scores for each sentiment class (Positive, Negative, and Neutral))
    # http:DefaultStatusCodeResponse (Unexpected error)
    resource function post sentiment(@http:Query {name: "model-version"} string? modelVersion, boolean? showStats, boolean? loggingOptOut, boolean? opinionMining, @http:Payload MultiLanguageBatchInput payload, "TextElement_v8"|"UnicodeCodePoint"|"Utf16CodeUnit" stringIndexType = "TextElement_v8") returns SentimentResponseOk|ErrorResponseDefault {
        return {
            body: {
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
            }
        };
    }
}

// Service-mode response types. `bal openapi --mode client` collapses 4XX/5XX
// to `error` and never emits these, so they are defined here for the mock only.
public type AnydataAccepted record {|
    *http:Accepted;
    anydata body;
    record {|string Operation\-Location?;|} headers;
|};

public type AnydataDefault record {|
    *http:DefaultStatusCodeResponse;
    anydata body;
|};

public type EntitiesResultOk record {|
    *http:Ok;
    EntitiesResult body;
|};

public type EntityLinkingResultOk record {|
    *http:Ok;
    EntityLinkingResult body;
|};

public type ErrorResponseDefault record {|
    *http:DefaultStatusCodeResponse;
    ErrorResponse body;
|};

public type KeyPhraseResultOk record {|
    *http:Ok;
    KeyPhraseResult body;
|};

public type LanguageResultOk record {|
    *http:Ok;
    LanguageResult body;
|};

public type PiiResultOk record {|
    *http:Ok;
    PiiResult body;
|};

public type SentimentResponseOk record {|
    *http:Ok;
    SentimentResponse body;
|};

public type ErrorResponse record {
    TextAnalyticsError 'error;
};

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


import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? os:getEnv("AZURE_TEXTANALYTICS_SERVICE_URL") : "http://localhost:9090";
final string subscriptionKey = isLiveServer ? os:getEnv("AZURE_TEXTANALYTICS_KEY") : "test_key";

final Client textAnalytics = check new ({ocpApimSubscriptionKey: subscriptionKey}, {httpVersion: "1.1"}, serviceUrl);

final MultiLanguageBatchInput multiLanguageInput = {
    documents: [{id: "1", language: "en", text: "Microsoft was founded by Bill Gates in Albuquerque."}]
};

@test:Config {groups: ["live_tests", "mock_tests"]}
function testRecognizeEntities() returns error? {
    EntitiesResult response = check textAnalytics->recognizeEntities(multiLanguageInput);
    test:assertTrue(response.documents.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testRecognizePiiEntities() returns error? {
    PiiResult response = check textAnalytics->recognizePiiEntities(multiLanguageInput);
    test:assertTrue(response.documents.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testLinkEntities() returns error? {
    EntityLinkingResult response = check textAnalytics->linkEntities(multiLanguageInput);
    test:assertTrue(response.documents.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testExtractKeyPhrases() returns error? {
    KeyPhraseResult response = check textAnalytics->extractKeyPhrases(multiLanguageInput);
    test:assertTrue(response.documents.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testDetectLanguage() returns error? {
    LanguageResult response = check textAnalytics->detectLanguage({documents: [{id: "1", text: "Hello world"}]});
    test:assertTrue(response.documents.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testAnalyzeSentiment() returns error? {
    SentimentResponse response = check textAnalytics->analyzeSentiment(multiLanguageInput);
    test:assertTrue(response.documents.length() > 0);
}

@test:Config {groups: ["mock_tests"]}
function testSubmitAnalysisJob() returns error? {
    error? response = textAnalytics->submitAnalysisJob({
        displayName: "Contoso analysis",
        analysisInput: multiLanguageInput,
        tasks: {keyPhraseExtractionTasks: [{}]}
    });
    test:assertTrue(response is ());
}

@test:Config {groups: ["mock_tests"]}
function testGetAnalysisJob() returns error? {
    AnalyzeJobState response = check textAnalytics->getAnalysisJob("job-1");
    test:assertEquals(response.status, "succeeded");
}

@test:Config {groups: ["mock_tests"]}
function testSubmitHealthcareJob() returns error? {
    error? response = textAnalytics->submitHealthcareJob(multiLanguageInput);
    test:assertTrue(response is ());
}

@test:Config {groups: ["mock_tests"]}
function testGetHealthcareJob() returns error? {
    HealthcareJobState response = check textAnalytics->getHealthcareJob("job-1");
    test:assertEquals(response.status, "succeeded");
}

@test:Config {groups: ["mock_tests"]}
function testCancelHealthcareJob() returns error? {
    error? response = textAnalytics->cancelHealthcareJob("job-1");
    test:assertTrue(response is ());
}

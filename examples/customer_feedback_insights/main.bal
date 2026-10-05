import ballerina/io;
import ballerinax/azure.textanalytics;

configurable string subscriptionKey = ?;
configurable string serviceUrl = ?;
configurable string feedbackText = "The staff were friendly and the room was spotless, but check-in took far too long.";

public function main() returns error? {
    textanalytics:Client analytics = check new ({ocpApimSubscriptionKey: subscriptionKey}, serviceUrl = serviceUrl);

    textanalytics:MultiLanguageInput[] documents = [{id: "1", language: "en", text: feedbackText}];
    textanalytics:LanguageInput[] languageDocuments = [{id: "1", text: feedbackText}];

    // Step 1: confirm the language of each feedback entry.
    textanalytics:LanguageResult languages = check analytics->detectLanguage({documents: languageDocuments});
    foreach textanalytics:DocumentLanguage doc in languages.documents {
        io:println(string `Feedback ${doc.id} language: ${doc.detectedLanguage.name}`);
    }

    // Step 2: score the sentiment of each entry.
    textanalytics:SentimentResponse sentiment = check analytics->analyzeSentiment({documents});
    foreach textanalytics:DocumentSentiment doc in sentiment.documents {
        io:println(string `Feedback ${doc.id} sentiment: ${doc.sentiment}`);
    }

    // Step 3: extract the topics customers talk about.
    textanalytics:KeyPhraseResult phrases = check analytics->extractKeyPhrases({documents});
    foreach textanalytics:DocumentKeyPhrases doc in phrases.documents {
        io:println(string `Feedback ${doc.id} key phrases: ${doc.keyPhrases.toString()}`);
    }
}

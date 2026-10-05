import ballerina/io;
import ballerinax/azure.textanalytics;

configurable string subscriptionKey = ?;
configurable string serviceUrl = ?;
configurable string supportMessage = "Hi, I am Jane Doe. Please call me on 425-555-0100 about my Contoso order in Seattle.";

public function main() returns error? {
    textanalytics:Client analytics = check new ({ocpApimSubscriptionKey: subscriptionKey}, serviceUrl = serviceUrl);

    textanalytics:MultiLanguageInput[] documents = [{id: "1", language: "en", text: supportMessage}];

    // Step 1: find and redact personal information.
    textanalytics:PiiResult pii = check analytics->recognizePiiEntities({documents});
    foreach textanalytics:PiiDocumentEntities doc in pii.documents {
        io:println(string `Message ${doc.id} redacted: ${doc.redactedText}`);
        foreach textanalytics:Entity entity in doc.entities {
            io:println(string `  ${entity.category}: ${entity.text}`);
        }
    }

    // Step 2: recognise the remaining named entities (organisations, places).
    textanalytics:EntitiesResult entities = check analytics->recognizeEntities({documents});
    foreach textanalytics:DocumentEntities doc in entities.documents {
        foreach textanalytics:Entity entity in doc.entities {
            io:println(string `Message ${doc.id} entity ${entity.text} (${entity.category})`);
        }
    }

    // Step 3: link entities to a knowledge base for the support team.
    textanalytics:EntityLinkingResult linked = check analytics->linkEntities({documents});
    foreach textanalytics:DocumentLinkedEntities doc in linked.documents {
        foreach textanalytics:LinkedEntity entity in doc.entities {
            io:println(string `Message ${doc.id} linked ${entity.name}: ${entity.url}`);
        }
    }
}

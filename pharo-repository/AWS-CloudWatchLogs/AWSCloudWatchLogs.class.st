Class {
	#name : #AWSCloudWatchLogs,
	#superclass : #AWSService,
	#category : #'AWS-CloudWatchLogs'
}

{ #category : #'as yet unclassified' }
AWSCloudWatchLogs >> createRequest: aRequestBody url: url method: method [ 
		
	| datetimeString hostUrl request |
	datetimeString := DateAndTime amzDatePrintString.
	hostUrl := self awsConfig endpoint.
	
	request := ZnRequest empty.
	request method: method.
	request url: url.

	request entity:(ZnEntity with: aRequestBody type: (ZnMimeType textPlain)). 
	request headers at:'host' put: hostUrl.
	request headers at:'x-amz-content-sha256' put: (SHA256 new hashMessage: aRequestBody) hex.
	request headers at:'x-amz-date' put: datetimeString.
	request setAuthorization: ( SignatureV4 creatAuthorization: request andConfig: self awsConfig andDateTime: datetimeString andOption: nil ) .
	^ request
]

{ #category : #'as yet unclassified' }
AWSCloudWatchLogs >> defaultConfigClass [
	^ AWSCloudWatchLogsConfig
]

{ #category : #'as yet unclassified' }
AWSCloudWatchLogs >> publishMessage: aString logGroup: logGroupName logStream: logStreamName [
	| url request requestBody |
	url := '/' asZnUrl.
	url := url 
		? (#Action -> #PutLogEvents)
		"& (#TargetArn -> arn)"
		"& (#Message -> aString)".
	requestBody := '{}'.
	request := self createRequest: requestBody url: url method: #POST .
	^ self client request: request andOption: nil.
]

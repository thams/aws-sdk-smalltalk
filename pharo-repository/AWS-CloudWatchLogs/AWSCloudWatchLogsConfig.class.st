Class {
	#name : #AWSCloudWatchLogsConfig,
	#superclass : #AWSConfig,
	#classInstVars : [
		'default'
	],
	#category : #'AWS-CloudWatchLogs'
}

{ #category : #accessing }
AWSCloudWatchLogsConfig class >> default [
	default ifNil: [ default := self defaultCloudWatchLogsSetting ].
	^default
]

{ #category : #accessing }
AWSCloudWatchLogsConfig class >> defaultCloudWatchLogsSetting [
	| aws |
	aws := self new.
	aws serviceName: 'cloudwatch'.
	aws regionName: 'us-east-1'.
	^ aws
]

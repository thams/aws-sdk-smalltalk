Class {
	#name : #AWSConfig,
	#superclass : #Object,
	#instVars : [
		'settingsDict'
	],
	#category : #'AWS-Core'
}

{ #category : #'instance creation' }
AWSConfig class >> default [
	self subclassResponsibility
]

{ #category : #accessing }
AWSConfig >> accessKeyId [
	| fl |
	^ self
		at: #accessKeyId
		ifAbsentPut: [ | result |
			result := OSPlatform current environment
				at: 'AWS_ACCESS_KEY_ID'
				ifAbsent: [ fl := FileLocator home / '.ssh/api-keys/aws_access_key_id'.
					fl exists
						ifTrue: [ fl contents trim ]
						ifFalse: [  ] ].
			result ]
]

{ #category : #accessing }
AWSConfig >> accessKeyId: anObject [
	^self  at: #accessKeyId put: anObject
]

{ #category : #accessing }
AWSConfig >> apiVersion [
	^self  at: #apiVersion ifAbsent: []
]

{ #category : #accessing }
AWSConfig >> apiVersion: anObject [
	^self at: #apiVersion put: anObject
]

{ #category : #accessing }
AWSConfig >> at: key [
	^self settingsDict at: key
]

{ #category : #accessing }
AWSConfig >> at: key ifAbsent: aBlock [
	^self settingsDict at: key ifAbsent: aBlock
]

{ #category : #accessing }
AWSConfig >> at: key ifAbsentPut: aBlock [
	^self settingsDict at: key ifAbsentPut: aBlock
]

{ #category : #accessing }
AWSConfig >> at: key put: value [
	^self settingsDict at: key put: value
]

{ #category : #defaults }
AWSConfig >> defaultRegionName [
	"AWS Regions Asia Pacific (Tokyo)"
	^ 'ap-northeast-1'.
]

{ #category : #defaults }
AWSConfig >> defaultServiceName [
	^ ''
]

{ #category : #accessing }
AWSConfig >> endpoint [
	^self  at: #endpoint ifAbsent: [ self endpoint: self hostUrl ]
]

{ #category : #accessing }
AWSConfig >> endpoint: anObject [
	^self  at: #endpoint put: anObject
]

{ #category : #accessing }
AWSConfig >> hostUrl [
	^self at: #hostUrl ifAbsent: [ self hostUrl: self serviceName asLowercase,'.', self regionName, '.amazonaws.com'. ]
]

{ #category : #accessing }
AWSConfig >> hostUrl: anObject [
	self settingsDict removeKey: #endpoint ifAbsent: [  ].
	^ self at: #hostUrl put: anObject
]

{ #category : #accessing }
AWSConfig >> regionName [
	"Note: uses defaultRegionName if none set"
	^ self
		at: #regionName
		ifAbsentPut: [ | result |
			result := OSPlatform current environment
				at: 'AWS_REGION_NAME'
				ifAbsent: [ | fl |
					fl := FileLocator home / '.ssh/api-keys/aws_region_name'.
					fl exists
						ifTrue: [ fl contents trim ]
						ifFalse: [ self defaultRegionName ] ].
			result ]
]

{ #category : #accessing }
AWSConfig >> regionName: anObject [
	self settingsDict removeKey: #hostUrl ifAbsent: [  ].
	self settingsDict removeKey: #endpoint ifAbsent: [  ].
	^ self at: #regionName put: anObject
]

{ #category : #accessing }
AWSConfig >> secretKey [
	| fl |
	^ self
		at: #secretKey
		ifAbsentPut: [ | result |
			result := OSPlatform current environment
				at: 'AWS_SECRET_KEY'
				ifAbsent: [ fl := FileLocator home / '.ssh/api-keys/aws_secret_key'.
					fl exists
						ifTrue: [ fl contents trim ]
						ifFalse: [  ] ].
			result ]
]

{ #category : #accessing }
AWSConfig >> secretKey: anObject [
	^self  at: #secretKey put: anObject
]

{ #category : #accessing }
AWSConfig >> serviceName [
	^self  at: #serviceName ifAbsent: [ self defaultServiceName ]
]

{ #category : #accessing }
AWSConfig >> serviceName: anObject [
	^self  at: #serviceName put: anObject
]

{ #category : #accessing }
AWSConfig >> sessionToken [
	^self  at: #sessionToken ifAbsent: []
]

{ #category : #accessing }
AWSConfig >> sessionToken: anObject [
	^self  at: #sessionToken put: anObject
]

{ #category : #accessing }
AWSConfig >> settingsDict [
	^ settingsDict ifNil: [settingsDict := IdentityDictionary new]
]

{ #category : #accessing }
AWSConfig >> useSSL [

	^self at: #useSSL ifAbsent: [ self useSSL: true ]
]

{ #category : #accessing }
AWSConfig >> useSSL: anObject [

	^self  at: #useSSL put: anObject
]

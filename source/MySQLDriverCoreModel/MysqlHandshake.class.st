Class {
	#name : #MysqlHandshake,
	#superclass : #MysqlPacket,
	#instVars : [
		'protocolVer',
		'serverVer',
		'threadId',
		'scrambleBuff',
		'serverCap',
		'serverLang',
		'scrambleBuffMore',
		'serverStatus'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Parsing }
MysqlHandshake >> parse [ 
	protocolVer := inStream next.
	serverVer := (inStream upTo: 0) asString.
	threadId := inStream next + (inStream next bitShift: 8) + 
		(inStream next bitShift: 16) + (inStream next bitShift: 24).
	scrambleBuff := inStream next: 8.
	inStream skip: 1.	"always 0"
	serverCap := inStream next + (inStream next bitShift: 8).
	serverLang := inStream next.
	serverStatus := inStream next + (inStream next bitShift: 8).
	inStream skip: 13.	"filler"
	self supportsProtocol41 ifFalse: [ ^ self ].
	scrambleBuffMore := inStream next: 12.
	inStream skip: 1	"always 0"

]

{ #category : #Accessing }
MysqlHandshake >> scrambleBuff [
	
	^ scrambleBuff
	
	"self supports41 
		ifTrue: [^ scrambleBuff, scrambleBuffMore]
		ifFalse: [^ scrambleBuff]."
]

{ #category : #Accessing }
MysqlHandshake >> scrambleBuffMore [
	^scrambleBuffMore 
]

{ #category : #Accessing }
MysqlHandshake >> serverCaps [
	^ serverCap
]

{ #category : #Accessing }
MysqlHandshake >> serverLang [
	^ serverLang
]

{ #category : #Accessing }
MysqlHandshake >> serverStatus [
	^ serverStatus
]

{ #category : #Accessing }
MysqlHandshake >> serverVer [
	^ serverVer
]

{ #category : #Testing }
MysqlHandshake >> supportsProtocol41 [
	^ (serverCap bitAnd: CapProtocol41) = CapProtocol41
]

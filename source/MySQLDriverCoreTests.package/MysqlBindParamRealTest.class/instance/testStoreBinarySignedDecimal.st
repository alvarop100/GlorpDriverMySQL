Tests
testStoreBinarySignedDecimal
	theParam bindValue: -12345.678901s6.
	ByteArray
		streamContents: [ :strm | 
			theParam storeBinaryOn: strm.
			self assert: strm contents asString equals: '12345.678901' ]
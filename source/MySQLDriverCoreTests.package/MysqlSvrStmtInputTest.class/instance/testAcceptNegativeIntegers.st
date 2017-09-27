Tests
testAcceptNegativeIntegers
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#integers)
		do: [ :conn | 
			prep := conn
				prepare:
					'select * from testIntegers 
			where 
				tinyintValue = ? and smallintValue = ? and
				mediumintValue = ? and intValue = ? and
				bigintValue = ? 
			order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := MysqlBindParam
				listOfSize: prep prepareOkay numParams
				forDescriptors: prep paramDescriptors.
			params first bindValue: -101.
			(params at: 2) bindValue: -301.
			(params at: 3) bindValue: -40001.
			(params at: 4) bindValue: -100001.
			(params at: 5) bindValue: -6000000001.
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 1.
			self assert: (resp rows first atIndex: 2) equals: -101.
			self assert: (resp rows first atIndex: 3) equals: -301.
			self assert: (resp rows first atIndex: 4) equals: -40001.
			self assert: (resp rows first atIndex: 5) equals: -100001.
			self assert: (resp rows first atIndex: 6) equals: -6000000001 ]
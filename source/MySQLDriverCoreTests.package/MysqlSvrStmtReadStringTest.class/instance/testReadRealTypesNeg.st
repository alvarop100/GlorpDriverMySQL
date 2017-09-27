Tests
testReadRealTypesNeg
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#reals)
		do: [ :conn | 
			prep := conn prepare: 'select * from testReals order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 3.
			self assert: ((resp rows third atIndex: 2) asNumber closeTo: -1.1).
			self
				assert: ((resp rows third atIndex: 3) asNumber closeTo: -11.11).
			self
				assert: ((resp rows third atIndex: 4) asNumber closeTo: -222.222).
			self
				assert: (resp rows third atIndex: 5)
				equals: (-3333333333 / 1000000 asScaledDecimal: 6) asString.
			self
				assert: (resp rows third atIndex: 6)
				equals: (-4444444444 / 1000000 asScaledDecimal: 6) asString ]
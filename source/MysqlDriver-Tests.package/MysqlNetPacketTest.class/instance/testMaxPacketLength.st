as yet unclassified
testMaxPacketLength
	| pkt |

	pkt := MysqlNetPacket new.
	self assert: (pkt maxLength = 16rFFFFFF)
	
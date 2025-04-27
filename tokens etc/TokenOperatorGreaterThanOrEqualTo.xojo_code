#tag Class
Protected Class TokenOperatorGreaterThanOrEqualTo
Inherits TokenOperator
	#tag Method, Flags = &h0
		Function asInstruction() As Instruction
		  return new InstructionOperatorGreaterThanOrEqualTo()
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function associativity() As String
		  return kLeft
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  return ">="
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function precedence() As Integer
		  return 5
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

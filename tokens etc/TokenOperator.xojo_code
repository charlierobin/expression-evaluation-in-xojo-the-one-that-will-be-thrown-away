#tag Class
Protected Class TokenOperator
Inherits Token
	#tag Method, Flags = &h0
		Function associativity() As String
		  raise new RuntimeException( "Override" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // prevent direct instantiation
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function precedence() As Integer
		  raise new RuntimeException( "Override" )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kLeft, Type = String, Dynamic = False, Default = \"Left", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kRight, Type = String, Dynamic = False, Default = \"Right", Scope = Protected
	#tag EndConstant


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

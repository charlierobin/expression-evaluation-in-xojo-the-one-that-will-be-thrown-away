#tag Class
Protected Class InstructionOperandString
Inherits InstructionOperand
	#tag Method, Flags = &h0
		Sub Constructor(value as String)
		  self.value = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  return self.value
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function resolveValue(context as Context) As Variant
		  #pragma unused context
		  
		  return self.value
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private value As String
	#tag EndProperty


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

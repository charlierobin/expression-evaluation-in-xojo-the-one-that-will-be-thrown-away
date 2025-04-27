#tag Class
Protected Class InstructionOperandVariableLookUp
Inherits InstructionOperand
	#tag Method, Flags = &h0
		Sub Constructor(name as String)
		  self.name = name
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  return self.name
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function resolveValue(context as Context) As Variant
		  if not context.hasVariable( self.name ) then
		    
		    raise new RuntimeException( "Variable not found: " + self.name )
		    
		  end if
		  
		  return context.getVariableValue( self.name )
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private name As String
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

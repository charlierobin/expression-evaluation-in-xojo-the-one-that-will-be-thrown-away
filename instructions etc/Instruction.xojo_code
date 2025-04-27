#tag Class
Protected Class Instruction
	#tag Method, Flags = &h1
		Protected Function className() As String
		  var t as Introspection.TypeInfo = Introspection.GetType( self )
		  
		  var baseName as String = t.BaseType.Name
		  
		  return t.Name.TrimLeft( baseName )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // prevent direct instantiation
		  
		  // instantiate subclasses of InstructionOperand and InstructionOperator only
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  return self.className
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function resolveValue(context as Context) As Variant
		  #pragma unused context
		  
		  raise new RuntimeException( "Override" )
		  
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

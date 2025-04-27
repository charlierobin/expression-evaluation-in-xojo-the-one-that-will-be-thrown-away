#tag Class
Private Class Context
	#tag Method, Flags = &h0
		Sub assertStackHasAtLeast(number as Integer)
		  if self.stack.Count < number then
		    
		    raise new RuntimeException( "Not enough values on stack" )
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getVariableValue(path as String) As Variant
		  if not self.hasVariable( path ) then
		    
		    raise new RuntimeException( "Variable not found: " + path )
		    
		  end if
		  
		  return App.variables.Value( path )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasVariable(path as String) As Boolean
		  return App.variables.HasKey( path )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		stack() As Variant
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

#tag Class
Protected Class InstructionOperandList
Inherits InstructionOperand
	#tag Method, Flags = &h0
		Sub Constructor(vals() as InstructionOperandSubClause)
		  self.values = vals
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  var s as String = "[ "
		  
		  for each val as InstructionOperandSubClause in self.values
		    
		    s = s + val.debugString() + ", "
		    
		  next
		  
		  s = s.TrimRight( ", " )
		  
		  s = s + " ]"
		  
		  return s
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function resolveValue(context as Context) As Variant
		  var listValues() as Variant
		  
		  for each subClause as InstructionOperandSubClause in self.values
		    
		    var r as Variant = subClause.resolveValue( context )
		    
		    listValues.Add( r )
		    
		  next
		  
		  return listValues
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private values() As InstructionOperandSubClause
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

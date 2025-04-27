#tag Class
Protected Class TokenOperandList
Inherits TokenOperandContainsSubClauses
	#tag Method, Flags = &h0
		Function asInstruction() As Instruction
		  var vals() as InstructionOperandSubClause
		  
		  for each value as TokenOperandSubClause in self.values
		    
		    vals.Add( InstructionOperandSubClause( value.asInstruction() ) )
		    
		  next
		  
		  return new InstructionOperandList( vals )
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(args() as Tokens)
		  for each arg as Tokens in args
		    
		    self.values.Add( new TokenOperandSubClause( arg ) )
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  var s as String = ""
		  
		  for each value as TokenOperandSubClause in self.values
		    
		    s = s + value.debugString() + ", "
		    
		  next
		  
		  s = s.TrimRight( ", " )
		  
		  return "[ " + s + " ]"
		  
		  
		  // + self.values.Count.ToString() + ": "
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSubClauses() As TokenOperandSubClause()
		  return self.values
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		values() As TokenOperandSubClause
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

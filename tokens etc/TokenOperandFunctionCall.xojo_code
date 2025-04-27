#tag Class
Protected Class TokenOperandFunctionCall
Inherits TokenOperandContainsSubClauses
	#tag Method, Flags = &h0
		Function asInstruction() As Instruction
		  var args() as InstructionOperandSubClause
		  
		  for each arg as TokenOperandSubClause in self.arguments
		    
		    args.Add( InstructionOperandSubClause( arg.asInstruction() ) )
		    
		  next
		  
		  return new InstructionOperandFunctionCall( self.name, args )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(name as String, args() as Tokens)
		  self.name = name
		  
		  for each arg as Tokens in args
		    
		    self.arguments.Add( new TokenOperandSubClause( arg ) )
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  var s as String = ""
		  
		  for each arg as TokenOperandSubClause in self.arguments
		    
		    s = s + arg.debugString()
		    
		  next
		  
		  return self.name + "(" + self.arguments.Count.ToString() + ": " + s + ")"
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSubClauses() As TokenOperandSubClause()
		  return self.arguments
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		arguments() As TokenOperandSubClause
	#tag EndProperty

	#tag Property, Flags = &h21
		Private name As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="name"
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

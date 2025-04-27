#tag Class
Private Class Tokens
	#tag Method, Flags = &h0
		Sub add(t as Token)
		  self.tokens.Add( t )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function asInstructions() As Instructions
		  var instructions as Instructions = new Instructions()
		  
		  for each t as Token in self.tokens
		    
		    instructions.add( t.asInstruction() )
		    
		  next
		  
		  return instructions
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function at(i as Integer) As Token
		  if i >-1 and i < self.tokens.Count then
		    
		    return self.tokens( i )
		    
		  end if
		  
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function count() As Integer
		  return self.tokens.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  var s as String = ""
		  
		  for each t as Token in self.tokens
		    
		    s = s + t.debugString() + " "
		    
		  next
		  
		  return s.Trim()
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getNext() As Token
		  var token as Token = self.tokens( 0 )
		  
		  self.tokens.RemoveAt( 0 )
		  
		  return token
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function peek() As Token
		  if self.tokens.Count > 0 then
		    
		    return self.tokens( 0 )
		    
		  end if
		  
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeNext()
		  self.tokens.RemoveAt( 0 )
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private tokens() As Token
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

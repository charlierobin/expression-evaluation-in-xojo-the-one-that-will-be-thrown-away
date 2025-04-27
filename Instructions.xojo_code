#tag Class
Private Class Instructions
	#tag Method, Flags = &h0
		Sub add(i as Instruction)
		  self.instructions.Add( i )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function at(i as Integer) As Instruction
		  if i >-1 and i < self.instructions.Count then
		    
		    return self.instructions( i )
		    
		  end if
		  
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function count() As Integer
		  return self.instructions.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  var s as String = ""
		  
		  for each i as Instruction in self.instructions
		    
		    s = s + i.debugString() + " "
		    
		  next
		  
		  return s.Trim()
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getNext() As Instruction
		  var instruction as Instruction = self.instructions( 0 )
		  
		  self.instructions.RemoveAt( 0 )
		  
		  return instruction
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function peek() As Instruction
		  if self.instructions.Count > 0 then
		    
		    return self.instructions( 0 )
		    
		  end if
		  
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeNext()
		  self.instructions.RemoveAt( 0 )
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private instructions() As Instruction
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

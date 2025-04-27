#tag Class
Protected Class InstructionOperandFunctionCall
Inherits InstructionOperand
	#tag Method, Flags = &h0
		Sub Constructor(name as String, args() as InstructionOperandSubClause)
		  self.name = name
		  
		  self.arguments = args
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString() As String
		  var s as String = ""
		  
		  for each arg as InstructionOperandSubClause in self.arguments
		    
		    s = s + arg.debugString()
		    
		  next
		  
		  return self.name + "(" + self.arguments.Count.ToString() + ": " + s + ")"
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function flat(values() as Variant) As Variant()
		  var newArray() as Variant
		  
		  for each v as Variant in values
		    
		    if v.IsArray then
		      
		      var vArrayFlat() as Variant = self.flat( v )
		      
		      for each subV as Variant in vArrayFlat 
		        
		        newArray.Add( subV )
		        
		      next
		      
		    else
		      
		      newArray.Add( v )
		      
		    end if
		    
		  next
		  
		  return newArray
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function f_average(values() as Variant) As Variant
		  values = self.flat( values )
		  
		  var total as Variant = 0
		  
		  for each value as Variant in values
		    
		    total = total + value
		    
		  next
		  
		  var average as Variant = total / values.Count
		  
		  return average
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function f_sum(values() as Variant) As Variant
		  values = self.flat( values )
		  
		  var total as Variant = 0
		  
		  for each value as Variant in values
		    
		    total = total + value
		    
		  next
		  
		  return total
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function resolveValue(context as Context) As Variant
		  #pragma unused context
		  
		  // TODO handle all functions through context/callbacks/delegates to host app?
		  
		  var paramValues() as Variant
		  
		  for each subClause as InstructionOperandSubClause in self.arguments
		    
		    var r as Variant = subClause.resolveValue( context )
		    
		    paramValues.Add( r )
		    
		  next
		  
		  var result as Variant = nil
		  
		  select case self.name
		    
		  case "average"
		    
		    result = self.f_average( paramValues )
		    
		  case "sum"
		    
		    result = self.f_sum( paramValues )
		    
		  else
		    
		    raise new RuntimeException( "Unknown function: " + self.name )
		    
		  end select
		  
		  return result
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private arguments() As InstructionOperandSubClause
	#tag EndProperty

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

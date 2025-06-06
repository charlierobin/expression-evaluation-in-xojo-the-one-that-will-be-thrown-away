#tag Class
Protected Class Class1
	#tag Method, Flags = &h0
		Sub Constructor()
		  self.started = DateTime.Now()
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub done()
		  var finished as DateTime = DateTime.Now()
		  
		  var interval as DateInterval = finished - self.started
		  
		  var elapsed as Integer = interval.Nanoseconds
		  
		  System.DebugLog( elapsed.ToString() )
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private started As DateTime
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

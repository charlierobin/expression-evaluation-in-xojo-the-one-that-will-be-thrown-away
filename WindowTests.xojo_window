#tag DesktopWindow
Begin DesktopWindow WindowTests
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   562
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1316732927
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Untitled"
   Type            =   0
   Visible         =   True
   Width           =   974
   Begin DesktopListBox ListBoxResults
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   ""
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   522
      Index           =   -2147483648
      InitialValue    =   "Expression	Result"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   934
      _ScrollWidth    =   -1
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  self.cached = new Dictionary()
		  
		  // random tests
		  
		  self.evaluateAndDebug( "AVERAGE([1,2,3],SUM(-1,[100,1000,2000],10))" )
		  self.evaluateAndDebug( "AVERAGE([1,2,3,[1,2,3]],100)" )
		  self.evaluateAndDebug( "1+2+sum(100)+sum([7,7,7],100)" )
		  self.evaluateAndDebug( "1 + sum(1,-2,3) + 4 + ((((10*10))))" )
		  self.evaluateAndDebug( "VAT + -LIFE" )
		  self.evaluateAndDebug( "NAME + "" "" + ""Robin""" )
		  self.evaluateAndDebug( "3 + 4 * 2 / 1 - 5 ^ 2 ^ 3" )
		  self.evaluateAndDebug( "1 + 2 / (3 * 4)" )
		  self.evaluateAndDebug( "1 + VAT" )
		  self.evaluateAndDebug( "1 + AVERAGE(AVERAGE(LIFE,2,3),2,3)" )
		  self.evaluateAndDebug( "1 + 2 / -(3 * 4)" )
		  
		  // basic
		  
		  self.evaluateAndDebug( "100" )                 // 100
		  self.evaluateAndDebug( "-1" )                  // -1
		  self.evaluateAndDebug( "+2" )                  // 2
		  self.evaluateAndDebug( "1 + 2" )               // 3
		  self.evaluateAndDebug( "(1 - 2)" )             // -1
		  self.evaluateAndDebug( "1 * 2" )               // 2
		  self.evaluateAndDebug( "1 / 2" )               // 0.5
		  self.evaluateAndDebug( "(1 % 2)" )             // 1
		  self.evaluateAndDebug( "1 ^ 2" )               // 1
		  self.evaluateAndDebug( "(20)" )                // 20
		  self.evaluateAndDebug( "(-2)" )                // -2
		  self.evaluateAndDebug( "(((192)))" )           // 192
		  self.evaluateAndDebug( "[1,2,3]" )             // [1,2,3]
		  self.evaluateAndDebug( "[1,2,[1,2,3]]" )       // nothing: nested lists not handled TODO
		  
		  // unary 
		  
		  self.evaluateAndDebug( "----1" )               // 1
		  self.evaluateAndDebug( "+++2" )                // 2
		  self.evaluateAndDebug( "-+-+-2" )              // -2
		  self.evaluateAndDebug( "+(--2)" )              // 2
		  self.evaluateAndDebug( "+(-(+(-(+1))))" )      // 1
		  self.evaluateAndDebug( "3 + -2" )              // 1
		  self.evaluateAndDebug( "3 * -2" )              // -6
		  self.evaluateAndDebug( "-3 / 2" )              // -1.5
		  self.evaluateAndDebug( "2 ^ -2" )              // 0.25
		  self.evaluateAndDebug( "-3 ^ 2" )              // 9
		  
		  // associativity  
		  
		  self.evaluateAndDebug( "1 + 2 + 3 + 4" )       // 10
		  self.evaluateAndDebug( "1 - 2 - 3 - 4" )       // -8
		  self.evaluateAndDebug( "1 * 2 * 3 * 4" )       // 24
		  self.evaluateAndDebug( "4 / 2 / 2" )           // 1
		  self.evaluateAndDebug( "4 % 3 % 2" )           // 1
		  self.evaluateAndDebug( "2 ^ 3 ^ 2" )           // 512
		  
		  // precedence
		  
		  self.evaluateAndDebug( "1 + 2 - 3" )           // 0
		  self.evaluateAndDebug( "1 + 2 * 3" )           // 7
		  self.evaluateAndDebug( "1 / 2 - 3" )           // -2.5
		  self.evaluateAndDebug( "3 * 4 % 5" )           // 2
		  self.evaluateAndDebug( "2 * (3 + 4)" )         // 14
		  self.evaluateAndDebug( "3 - (3 + 4)" )         // -4
		  self.evaluateAndDebug( "(10 - 4) / 2" )        // 3
		  self.evaluateAndDebug( "13 % 2 ^ 4" )          // 13
		  self.evaluateAndDebug( "2 ^ (2 * 5)" )         // 1024
		  self.evaluateAndDebug( "2 ^ 3 * 3 + 1" )       // 25
		  
		  // errors - various exceptions raised
		  
		  self.evaluateAndDebug( "1 2" )
		  self.evaluateAndDebug( "1 +" )
		  self.evaluateAndDebug( "2 * %" )
		  self.evaluateAndDebug( "^" )
		  
		  self.evaluateAndDebug( "(1 + 2" )
		  self.evaluateAndDebug( ")21" )
		  self.evaluateAndDebug( "()21" )
		  self.evaluateAndDebug( "(2)21" )
		  
		  // tests
		  
		  self.evaluateAndDebug( "100 > 10" )         // True
		  self.evaluateAndDebug( "100> 1000" )        // False
		  self.evaluateAndDebug( "100 ==100" )        // True
		  self.evaluateAndDebug( "100!=10" )          // True
		  self.evaluateAndDebug( "100 <> 100" )       // False
		  self.evaluateAndDebug( "10<=100" )          // True
		  self.evaluateAndDebug( "100>= 100" )        // True
		  
		  // comparisons
		  
		  self.evaluateAndDebug( "LIFE + (100 > 10)" )
		  self.evaluateAndDebug( "100 > 10+LIFE" )
		  self.evaluateAndDebug( "(100 > 10) == 100 >= 10" )
		  self.evaluateAndDebug( "(100 > 10) == (100 >= 10)" )
		  self.evaluateAndDebug( "LIFE > VAT" )
		  self.evaluateAndDebug( "LIFE < VAT" )
		  self.evaluateAndDebug( "LIFE != VAT" )
		  self.evaluateAndDebug( "LIFE == 600" )
		  self.evaluateAndDebug( "600 == LIFE" )
		  self.evaluateAndDebug( "600/3-LIFE == 100" )
		  
		  
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub evaluateAndDebug(expression as String)
		  try
		    
		    self.ListBoxResults.AddRow( expression )
		    
		    var result as Variant = Evaluation.evaluate( expression )
		    
		    // ... or ...
		    
		    // var data as Dictionary = Evaluation.evaluate_timed( expression )
		    
		    // var result as Variant = data.Value( "result" )
		    
		    // ---------------
		    
		    // other values in "data" Dictionary:
		    
		    // instructions ... the final "compiled" RPN instructions that were evaluated
		    // result ... the result (Variant)
		    // compile ... time taken to compile from infix string of type "1+2" to RPN Instructions (1 2 +) (in Nanoseconds)
		    // evaluate ... time taken to evaluate
		    // totalComputed ... total of "compile" and "evaluate" added together
		    // totalActual ... timed with timer, more than "totalComputed" from debugging overhead etc
		    
		    // ---------------
		    
		    // TODO eventually: what comes back is not just the result, but an object with data about what the intermediate nested bracketed expressions, function parameters,
		    // list values etc were at each stage (some kind of tree structure maybe even resmebling AST?) allowing host app to show this to user to help them understand
		    // how expression is being compiled and executed
		    
		    // TODO: also ... replace all the semi-botched Variant handling with a Value class, with ValueNumber, ValueString, ValueBoolean, ValueList subclasses?
		    
		    self.ListBoxResults.CellTextAt( self.ListBoxResults.LastAddedRowIndex, 1 ) = self.systemDebugResult( result )
		    
		  catch e as RuntimeException
		    
		    self.ListBoxResults.CellTextAt( self.ListBoxResults.LastAddedRowIndex, 1 ) = e.Message
		    
		  end try
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub evaluateAndDebugWithSimpleCaching(expression as String)
		  try
		    
		    self.ListBoxResults.AddRow( expression )
		    
		    var t as Class1 = new Class1()
		    
		    var result as Variant = nil
		    
		    if self.cached.HasKey( expression ) then
		      
		      var instructions as Instructions = self.cached.Value( expression ) 
		      
		      result = Evaluation.evaluate( instructions )
		      
		    else
		      
		      var instructions as Instructions = Evaluation.compile( expression )
		      
		      self.cached.Value( expression ) = instructions
		      
		      result = Evaluation.evaluate( instructions )
		      
		    end if
		    
		    t.done()
		    
		    self.ListBoxResults.CellTextAt( self.ListBoxResults.LastAddedRowIndex, 1 ) = self.systemDebugResult( result )
		    
		  catch e as RuntimeException
		    
		    self.ListBoxResults.CellTextAt( self.ListBoxResults.LastAddedRowIndex, 1 ) = e.Message
		    
		  end try
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function systemDebugResult(result as Variant) As String
		  // TODO at the moment, this only handles top level array item, no recursion for nested arrays!
		  
		  var resultAsString as String = ""
		  
		  if result.IsArray then
		    
		    var s as String = "[ "
		    
		    var arr() as Variant = result
		    
		    for i as integer = 0 to arr.LastIndex
		      
		      var value as Variant = arr( i )
		      
		      var valueAsString as String = self.systemDebugValue( value )
		      
		      if value.Type = Variant.TypeString then
		        
		        s = s + """" + valueAsString + """"
		        
		      else
		        
		        s = s + valueAsString
		        
		      end if
		      
		      s = s + ", "
		      
		    next
		    
		    s = s.TrimRight( ", " )
		    
		    s = s + " ]"
		    
		    resultAsString = s
		    
		  else
		    
		    resultAsString = self.systemDebugValue( result )
		    
		  end if
		  
		  return resultAsString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function systemDebugValue(value as Variant) As String
		  var s as String = ""
		  
		  if value.Type = Variant.TypeString then
		    
		    s = value
		    
		  elseif value.Type = Variant.TypeBoolean then
		    
		    s = value.StringValue
		    
		  else
		    
		    var r as String = str( value, "-############.#########" )
		    
		    r = r.TrimRight( "." )
		    
		    s = r
		    
		  end if
		  
		  return s
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private cached As Dictionary
	#tag EndProperty


#tag EndWindowCode

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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior

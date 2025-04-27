#tag Module
Protected Module Evaluation
	#tag Method, Flags = &h21
		Private Sub checkBalancedBrackets(tokens as Tokens)
		  var count as Integer = 0
		  
		  // var first as Boolean = true
		  
		  for i as Integer = 0 to tokens.count() - 1
		    
		    var t as Token = tokens.at( i )
		    
		    if t isA TokenBracketOpen then
		      
		      count = count + 1
		      
		    elseif t isA TokenBracketClose then
		      
		      count = count - 1
		      
		    end if
		    
		    if count < 0 then
		      
		      raise new RuntimeException( "Too many close brackets/close bracket before open?" )
		      
		    end if
		    
		  next
		  
		  if count <> 0 then
		    
		    raise new RuntimeException( "Open brackets not balanced with close brackets" )
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function compile(expression as String) As Instructions
		  // TODO preserve all of these steps in "result" class, for return together with final instructions/result?
		  
		  var tokens as Tokens = Evaluation.tokenise( expression )
		  
		  tokens = Evaluation.parseUnaryMinusOperators( tokens )
		  
		  // System.DebugLog( tokens.debugString() )
		  
		  Evaluation.checkBalancedBrackets( tokens )
		  
		  tokens = Evaluation.parseSymbolsFunctionsBrackets( tokens )
		  
		  // System.DebugLog( tokens.debugString() )
		  
		  tokens = Evaluation.parseInfixToRPN( tokens )
		  
		  // System.DebugLog( tokens.debugString() )
		  
		  var instructions as Instructions = tokens.asInstructions()
		  
		  return instructions
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function compile_timed(expression as String) As Dictionary
		  var start as DateTime = DateTime.Now()
		  
		  var instructions as Instructions = Evaluation.compile( expression )
		  
		  var finished as DateTime = DateTime.Now()
		  
		  var interval as DateInterval = finished - start
		  
		  var elapsed as Integer = interval.Nanoseconds
		  
		  return new Dictionary( "instructions" : instructions, "compile" : elapsed )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function evaluate(instructions as Instructions) As Variant
		  var context as Context = new Context()
		  
		  for i as Integer = 0 to instructions.count() - 1
		    
		    var instruction as Instruction = instructions.at( i )
		    
		    if instruction isA InstructionOperand then
		      
		      var operand as InstructionOperand = InstructionOperand( instruction )
		      
		      var value as Variant = operand.resolveValue( context )
		      
		      context.stack.Add( value )
		      
		    elseif instruction isA InstructionOperator then
		      
		      var operator as InstructionOperator = InstructionOperator( instruction )
		      
		      var value as Variant = operator.resolveValue( context )
		      
		      context.stack.Add( value )
		      
		    else
		      
		      raise new RuntimeException( "Unknown instruction: " + instruction.debugString() )
		      
		    end if
		    
		  next
		  
		  if context.stack.Count = 0 then
		    
		    raise new RuntimeException( "No result on stack" )
		    
		  elseif context.stack.Count > 1 then
		    
		    raise new RuntimeException( "Stack should only have one result on it at end of program" )
		    
		  end if
		  
		  return context.stack( 0 )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function evaluate(expression as String) As Variant
		  var instructions as Instructions = Evaluation.compile( expression )
		  
		  var result as Variant = Evaluation.evaluate( instructions )
		  
		  return result
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function evaluate_timed(instructions as Instructions) As Dictionary
		  var start as DateTime = DateTime.Now()
		  
		  var result as Variant = Evaluation.evaluate( instructions )
		  
		  var finished as DateTime = DateTime.Now()
		  
		  var interval as DateInterval = finished - start
		  
		  var elapsed as Integer = interval.Nanoseconds
		  
		  return new Dictionary( "result" : result, "evaluate" : elapsed )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function evaluate_timed(expression as String) As Dictionary
		  var start as DateTime = DateTime.Now()
		  
		  
		  var data_compile as Dictionary = Evaluation.compile_timed( expression )
		  
		  var instructions as Instructions = data_compile.Value( "instructions" )
		  
		  var compileTime as Integer = data_compile.Value( "compile" )
		  
		  
		  var data_evaluate as Dictionary = Evaluation.evaluate_timed( instructions )
		  
		  var result as Variant = data_evaluate.Value( "result" )
		  
		  var evaluateTime as Integer = data_evaluate.Value( "evaluate" )
		  
		  
		  var finished as DateTime = DateTime.Now()
		  
		  var interval as DateInterval = finished - start
		  
		  var elapsed as Integer = interval.Nanoseconds
		  
		  
		  return new Dictionary( "instructions" : instructions, "result" : result, "compile" : compileTime, "evaluate" : evaluateTime, "totalComputed" : compileTime + evaluateTime, "totalActual" : elapsed )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function parseInfixToRPN(tokens as Tokens) As Tokens
		  var rpnTokens as Tokens = new Tokens()
		  
		  var stack() as TokenOperator
		  
		  while tokens.count() > 0
		    
		    var t as Token = tokens.getNext()
		    
		    select case t
		      
		    case isA TokenOperand
		      
		      if t isA TokenOperandSubClause then
		        
		        var subClause as TokenOperandSubClause = TokenOperandSubClause( t )
		        
		        subClause.tokens = Evaluation.parseInfixToRPN( subClause.tokens )
		        
		      elseif t isA TokenOperandContainsSubClauses then
		        
		        var subClausesContainer as TokenOperandContainsSubClauses = TokenOperandContainsSubClauses( t )
		        
		        for each subClause as TokenOperandSubClause in subClausesContainer.getSubClauses()
		          
		          subClause.tokens = Evaluation.parseInfixToRPN( subClause.tokens )
		          
		        next
		        
		      end if
		      
		      rpnTokens.Add( t )
		      
		    case isA TokenOperator
		      
		      var tOp as TokenOperator = TokenOperator( t )
		      
		      
		      // if stack.Count() > 0 then
		      
		      
		      
		      var onStack as TokenOperator = if ( stack.Count() > 0, stack( stack.LastIndex ), nil )
		      
		      
		      
		      
		      while stack.Count > 0 and ( tOp.precedence() < onStack.precedence() or ( tOp.precedence() = onStack.precedence() and tOp.associativity() = "Left" ) )
		        
		        rpnTokens.Add( stack( stack.LastIndex ) )
		        
		        stack.RemoveAt( stack.LastIndex )
		        
		        
		        
		        onStack = if ( stack.Count() > 0, stack( stack.LastIndex ), nil )
		        
		        
		        
		        
		        
		        
		      wend
		      
		      
		      
		      // end if
		      
		      
		      
		      stack.Add( tOp )
		      
		    else
		      
		      raise new RuntimeException()
		      
		    end select
		    
		  wend
		  
		  while stack.Count > 0
		    
		    var t as TokenOperator = stack( stack.LastIndex )
		    
		    stack.RemoveAt( stack.LastIndex )
		    
		    rpnTokens.Add( t )
		    
		  wend
		  
		  return rpnTokens
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function parseSymbolsFunctionsBrackets(tokens as Tokens) As Tokens
		  var p as Pair = Evaluation.parseSymbolsFunctionsBracketsSub( tokens )
		  
		  tokens = p.Left
		  
		  return tokens
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function parseSymbolsFunctionsBracketsSub(tokens as Tokens) As Pair
		  var newTokens as Tokens = new Tokens()
		  
		  var returnContinue as Boolean = false
		  
		  while tokens.count() > 0
		    
		    var t as Token = tokens.getNext()
		    
		    var peek as Token = tokens.peek()
		    
		    select case t
		      
		    case isA TokenSymbol
		      
		      var symbol as TokenSymbol = TokenSymbol( t )
		      
		      if peek isA TokenNormalBracketOpen then
		        
		        tokens.removeNext()
		        
		        var arguments() as Tokens
		        
		        peek = tokens.peek()
		        
		        if peek isA TokenNormalBracketClose then
		          
		          tokens.removeNext()
		          
		        else
		          
		          var p as Pair = Evaluation.parseSymbolsFunctionsBracketsSub( tokens )
		          
		          var subTokens as Tokens = p.Left
		          
		          arguments.Add( subTokens )
		          
		          var cont as Boolean = p.Right
		          
		          while cont
		            
		            p = Evaluation.parseSymbolsFunctionsBracketsSub( tokens )
		            
		            subTokens = p.Left
		            
		            arguments.Add( subTokens )
		            
		            cont = p.Right
		            
		          wend
		          
		        end if
		        
		        newTokens.add( new TokenOperandFunctionCall( symbol.name, arguments ) )
		        
		      else
		        
		        newTokens.add( new TokenOperandVariableLookUp( symbol.name ) )
		        
		      end if
		      
		      
		      
		      
		    case isA TokenNormalBracketOpen
		      
		      
		      
		      var p as Pair = Evaluation.parseSymbolsFunctionsBracketsSub( tokens )
		      
		      var subTokens as Tokens = p.Left
		      
		      newTokens.add( new TokenOperandSubClause( subTokens ) )
		      
		      
		      
		      
		    case isA TokenSquareBracketOpen
		      
		      
		      
		      
		      
		      var values() as Tokens
		      
		      peek = tokens.peek()
		      
		      if peek isA TokenSquareBracketClose then
		        
		        tokens.removeNext()
		        
		      else
		        
		        var p as Pair = Evaluation.parseSymbolsFunctionsBracketsSub( tokens )
		        
		        var subTokens as Tokens = p.Left
		        
		        values.Add( subTokens )
		        
		        var cont as Boolean = p.Right
		        
		        while cont
		          
		          p = Evaluation.parseSymbolsFunctionsBracketsSub( tokens )
		          
		          subTokens = p.Left
		          
		          values.Add( subTokens )
		          
		          cont = p.Right
		          
		        wend
		        
		      end if
		      
		      newTokens.add( new TokenOperandList(values ) )
		      
		      
		      
		      
		      
		      
		    case isA TokenComma
		      
		      returnContinue = true
		      
		      exit
		      
		    case isA TokenBracketClose
		      
		      // handles both square and "normal" brackets
		      
		      exit
		      
		    else
		      
		      newTokens.add( t )
		      
		    end select
		    
		  wend
		  
		  return new Pair( newTokens, returnContinue )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function parseUnaryMinusOperators(tokens as Tokens) As Tokens
		  var newTokens as Tokens = new Tokens()
		  
		  var t as Token = nil
		  
		  var prev as Token = nil
		  var peekNext as Token = nil
		  
		  for i as Integer = 0 to tokens.count() - 1
		    
		    t = tokens.at( i )
		    
		    prev = tokens.at( i - 1 )
		    peekNext = tokens.at( i + 1 )
		    
		    // -1 + 2 + 3             nothing to left, literal to right
		    // -(1+2) + 3             nothing to left, bracket to right
		    // -a(1,2,3) + 3          nothing to left, symbol to right
		    
		    // 1 + -2 + 3             operator to left, literal to right
		    // 1 + -a(1,2,3) + 3      operator to left, symbol to right
		    
		    // 1 + a(-1,2,3) + 3      open bracket to left, literal to right
		    // 1 + a(1,-2,3) + 4      comma to left, literal to right
		    
		    // [-7,
		    
		    if t isA TokenOperatorHasUnaryEquivalent then
		      
		      if prev is nil then
		        
		        if peekNext isA TokenSquareBracketOpen then raise new RuntimeException( "Cannot negate a list" )
		        
		        t = transformUnary( t )
		        
		      elseif prev isA TokenOperator then
		        
		        if peekNext isA TokenSquareBracketOpen then raise new RuntimeException( "Cannot negate a list" )
		        
		        t = transformUnary( t )
		        
		      elseif prev isA TokenBracketOpen then
		        
		        if peekNext isA TokenSquareBracketOpen then raise new RuntimeException( "Cannot negate a list" )
		        
		        t = transformUnary( t )
		        
		      elseif prev isA TokenComma then
		        
		        if peekNext isA TokenSquareBracketOpen then raise new RuntimeException( "Cannot negate a list" )
		        
		        t = transformUnary( t )
		        
		      else
		        
		        // nothing
		        
		      end if
		      
		    end if
		    
		    newTokens.Add( t )
		    
		  next
		  
		  return newTokens
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function tokenise(expression as String) As Tokens
		  var tokens as Tokens = new Tokens()
		  
		  while expression.Length() > 0
		    
		    var c as String = expression.Left( 1 )
		    expression = expression.Middle( 1 )
		    
		    select case c
		      
		    case " ", kTab
		      
		      // skip whitespaces
		      
		    case "+"
		      
		      tokens.add( new TokenOperatorPlus() )
		      
		    case "-"
		      
		      tokens.add( new TokenOperatorMinus() )
		      
		    case "/"
		      
		      tokens.add( new TokenOperatorDivide() )
		      
		    case "%"
		      
		      tokens.add( new TokenOperatorModulo() )
		      
		    case "*"
		      
		      tokens.add( new TokenOperatorMultiply() )
		      
		    case "^"
		      
		      tokens.add( new TokenOperatorPower() )
		      
		    case "="
		      
		      var peek as String = expression.Left( 1 )
		      
		      if peek = "=" then
		        
		        expression = expression.Middle( 1 )
		        
		        tokens.add( new TokenOperatorEqualTo() )
		        
		      end if
		      
		    case "!"
		      
		      var peek as String = expression.Left( 1 )
		      
		      if peek = "=" then
		        
		        expression = expression.Middle( 1 )
		        
		        tokens.add( new TokenOperatorNotEqualTo() )
		        
		      end if
		      
		    case ">"
		      
		      var peek as String = expression.Left( 1 )
		      
		      if peek = "=" then
		        
		        expression = expression.Middle( 1 )
		        
		        tokens.add( new TokenOperatorGreaterThanOrEqualTo() )
		        
		      else
		        
		        tokens.add( new TokenOperatorGreaterThan() )
		        
		      end if
		      
		    case "<"
		      
		      var peek as String = expression.Left( 1 )
		      
		      if peek = "=" then
		        
		        expression = expression.Middle( 1 )
		        
		        tokens.add( new TokenOperatorLessThanOrEqualTo() )
		        
		      elseif peek = ">" then
		        
		        expression = expression.Middle( 1 )
		        
		        tokens.add( new TokenOperatorNotEqualTo() )
		        
		      else
		        
		        tokens.add( new TokenOperatorLessThan() )
		        
		      end if
		      
		    case ","
		      
		      tokens.add( new TokenComma() )
		      
		    case "("
		      
		      tokens.add( new TokenNormalBracketOpen() )
		      
		    case ")"
		      
		      tokens.add( new TokenNormalBracketClose() )
		      
		    case "["
		      
		      tokens.add( new TokenSquareBracketOpen() )
		      
		    case "]"
		      
		      tokens.add( new TokenSquareBracketClose() )
		      
		    case "0" to "9"
		      
		      var b as String = c
		      
		      var peek as String = expression.Left( 1 )
		      
		      while ( peek >= "0" and peek <= "9" ) or peek = "."
		        
		        c = expression.Left( 1 )
		        expression = expression.Middle( 1 )
		        
		        b = b + c
		        
		        peek = expression.Left( 1 )
		        
		      wend
		      
		      tokens.Add( new TokenOperandNumber( b ) )
		      
		    case "A" to "Z"
		      
		      var b as String = c
		      
		      var peek as String = expression.Left( 1 )
		      
		      while ( peek >= "A" and peek <= "Z" ) or ( peek >= "0" and peek <= "9" )
		        
		        c = expression.Left( 1 )
		        expression = expression.Middle( 1 )
		        
		        b = b + c
		        
		        peek = expression.Left( 1 )
		        
		      wend
		      
		      tokens.Add( new TokenSymbol( b ) )
		      
		    case kQuote
		      
		      var b as String = ""
		      
		      c = expression.Left( 1 )
		      expression = expression.Middle( 1 )
		      
		      while c <> kQuote
		        
		        b = b + c
		        
		        c = expression.Left( 1 )
		        expression = expression.Middle( 1 )
		        
		      wend
		      
		      tokens.Add( new TokenOperandString( b ) )
		      
		    else
		      
		      raise new RuntimeException( "Error at: " + c + " in " + expression )
		      
		    end select
		    
		  wend
		  
		  return tokens
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function transformUnary(t as Token) As TokenOperator
		  var newT as TokenOperator = nil
		  
		  if t isA TokenOperatorMinus then 
		    
		    newT = new TokenOperatorUnaryMinus() 
		    
		  else 
		    
		    newT = new TokenOperatorUnaryPlus()
		    
		  end if
		  
		  return newT
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kQuote, Type = String, Dynamic = False, Default = \"\"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTab, Type = String, Dynamic = False, Default = \"\t", Scope = Private
	#tag EndConstant


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
End Module
#tag EndModule

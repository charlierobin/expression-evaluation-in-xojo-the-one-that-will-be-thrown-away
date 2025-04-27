# expression evaluation in xojo: the one that will be thrown away
 
The experiment intended for experimentation and then throwing away…

I'm working on a couple of apps which need to be able to tokenise, parse and evaluate Excel-type formulas/expressions.

So this was my first pass at the problem. Hence there's plenty that will likely change, and plenty of TODOs scattered everywhere…

## tokenisation

Since tokenisation and parsing related matters are not really my forte, I’ve handled as much as possible by breaking things up into various "passes":

`var tokens as Tokens = Evaluation.tokenise( expression )`

The first tokenisation is just straightforwards looking at what's next in the string, and adding the appropriate Token class to a list. There's no attempt at semantic analysis or processing. (And the tokenisation doesn't use RegEx, which is just silly, but it just didn't occur to me.)

## parsing passes

## 1: parseUnaryMinusOperators

`tokens = Evaluation.parseUnaryMinusOperators( tokens )`

This passes over the list of tokens, identifying which minus/plus tokens are likely unary, and substituting them in the list of tokens.

## 2: checkBalancedBrackets

`Evaluation.checkBalancedBrackets( tokens )`

Does a simple pass counting open and close brackets (both `()` and `[]`), checking that they match

## 3: parseSymbolsFunctionsBrackets

`tokens = Evaluation.parseSymbolsFunctionsBrackets( tokens )`

Go through the tokens identifying (1) bracketed sub-expressions, (2) function parameters, (3) lists, replacing tokens (`TokenSymbol`, `TokenBracket`, `TokenComma` etc) with `TokenOperand` subclasses: `TokenOperandSubClause`, `TokenOperandFunctionCall`, `TokenVariableLookUp`, `TokenOperandList`, which all use `TokenOperandSubClause` to re-organise into a tree-like structure.

At this stage everthing is still infix.

## 4: parseInfixToRPN

`tokens = Evaluation.parseInfixToRPN( tokens )`

Now go over the tokens, coverting to RPN (postfix) via the shunting yard algorithm. `TokenOperandFunctionCall`, `TokenOperandList` and `TokenOperandSubClause` are all handled recursively.

## execution / evaluation

List of tokens are converted to equivalent list of Instruction subclasses: `InstructionOperands` and `InstructionOperators` from `TokenOperands`/`TokenOperators`. Recursive creation of `InstructionOperandSubClauses` from `TokenOperandSubClause`. (Likewise for `TokenOperandFunctionCall` and `TokenOperandList`.)

`var instructions as Instructions = tokens.asInstructions()`

The resulting list of `Instructions` is what can then be executed/evaluated. (And also cached, so if an expression/formula string remains unchanged, it does not need to be re-compiled if re-executed.)

`var result as Variant = Evaluation.evaluate( instructions )`

At the moment result comes back as Variant, and all evaluation is done with Xojo's inbuilt types. Which means there's lots of vry ugly Variant handling scattered everywhere. I'll likely eventually change this to use my own `Value` class.

Also, I want the result to come back with lots of other extra information: mainly what all the nested `InstructionOperandSubClauses`, `TokenOperandFunctionCall` and `TokenOperandList` evaluated to, so the host app can display all of this in the (sort of AST) structure of the formula to the user, allowing them to understand what they've written (and helping them debug if neccesary).






; extends
("\\" @expression.lamda (#set! conceal "λ"))
((variable) @variable.builtin (#eq? @variable.builtin "undefined" ) (#set! conceal "⊥"))

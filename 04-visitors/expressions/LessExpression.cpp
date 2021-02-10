#include "LessExpression.h"

LessExpression::LessExpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int LessExpression::eval() const {
    return first->eval() + second->eval();
}

void LessExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}

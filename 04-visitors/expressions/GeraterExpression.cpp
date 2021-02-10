#include "GreaterExpression.h"

GreaterExpression::Greaterxpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int GreaterExpression::eval() const {
    return first->eval() + second->eval();
}

void GreaterExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}

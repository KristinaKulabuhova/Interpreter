#include "EqExpression.h"

EqExpression::EqExpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int EqExpression::eval() const {
    return first->eval() + second->eval();
}

void EqExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}

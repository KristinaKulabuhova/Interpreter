#include "OrExpression.h"

OrExpression::OrExpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int OrExpression::eval() const {
    return first->eval() + second->eval();
}

void OrExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}

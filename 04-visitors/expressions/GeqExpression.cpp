#include "GeqExpression.h"

GeqExpression::GeqExpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int GeqExpression::eval() const {
    return first->eval() + second->eval();
}

void GeqExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}

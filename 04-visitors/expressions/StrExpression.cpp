#include "StrExpression.h"

StrExpression::StrExpression(std::string name): name_(name) {}

int StrExpression::eval() const {
    return first->eval() + second->eval();
}

void StrExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}

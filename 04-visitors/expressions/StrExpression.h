#pragma once
#include "Expression.h"

class StrExpression: public Expression {
 public:
    std::string name_;
    StrExpression(std::string name);
    int eval() const override;
    void Accept(Visitor* visitor) override;
};
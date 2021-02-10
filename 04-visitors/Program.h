#pragma once

#include "assignments/AssignmentList.h"
#include "expressions/Expression.h"

class Program {
 public:
    Program(std::string name, std::vector<VariableDeclBlock*> Var, StatementBlock* StatBlock);
    std::string name_;
    std::vector<VariableDeclBlock*> Var_;
    StatementBlock* StatBlock_;
};
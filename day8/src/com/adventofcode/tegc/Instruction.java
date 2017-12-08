package com.adventofcode.tegc;

class Instruction {
    public String reg;
    public Operation op;
    public Integer amount;
    public Condition cond;
    public String condReg;
    public Integer condAmount;

    Instruction(String[] instr) {
        this.reg = instr[0];
        this.op = Operation.valueOf(instr[1].toUpperCase());
        this.amount = Integer.parseInt(instr[2]);
        this.cond = condFromString(instr[5]);
        this.condReg = instr[4];
        this.condAmount = Integer.parseInt(instr[6]);
    }

    private static Condition condFromString(String condStr) {
        switch (condStr) {
            case ">":  return Condition.GT;
            case "<":  return Condition.LT;
            case "==": return Condition.EQ;
            case ">=": return Condition.GTEQ;
            case "<=": return Condition.LTEQ;
            case "!=": return Condition.NEQ;
        }

        System.err.println("Could not parse condition: " + condStr);
        throw new NullPointerException();
    }

    boolean cond(Integer regValue) {
        switch (this.cond) {
            case GT:   return regValue >  this.condAmount;
            case LT:   return regValue <  this.condAmount;
            case EQ:   return regValue == this.condAmount;
            case GTEQ: return regValue >= this.condAmount;
            case LTEQ: return regValue <= this.condAmount;
            case NEQ:  return regValue != this.condAmount;
        }

        System.err.println("Unreachable!");
        throw new NullPointerException();
    }

    Integer apply(Integer regValue) {
        switch (this.op) {
            case INC: regValue += this.amount; break;
            case DEC: regValue -= this.amount; break;
        }

        return regValue;
    }
}

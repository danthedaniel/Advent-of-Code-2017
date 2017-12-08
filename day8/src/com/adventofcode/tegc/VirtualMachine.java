package com.adventofcode.tegc;

import java.util.ArrayList;
import java.util.HashMap;

class VirtualMachine {
    private HashMap reg = new HashMap<String, Integer>();
    private ArrayList instr = new ArrayList<Instruction>();

    VirtualMachine(HashMap<String, Integer> reg, ArrayList<Instruction> instr) {
        this.reg = reg;
        this.instr = instr;
    }

    /**
     * Read through all registers and find the highest register value.
     * @return The highest register value.
     */
    Integer highestRegValue() {
        Integer max = Integer.MIN_VALUE;

        for (Object value : this.reg.values()) {
            Integer reg = (Integer) value;
            if (reg > max)
                max = reg;
        }

        return max;
    }

    /**
     * Execute the VM's instructions.
     */
    void run() {
        this.instr.forEach(i -> execInstr((Instruction) i));
    }

    void execInstr(Instruction i) {
        Integer regValue = (Integer) this.reg.get(i.reg);
        Integer condReg = (Integer) this.reg.get(i.condReg);

        if (i.cond(condReg)) {
            this.reg.put(i.reg, i.apply(regValue));
        }
    }
}

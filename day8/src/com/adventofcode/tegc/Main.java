package com.adventofcode.tegc;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class Main {
    private static HashMap reg = new HashMap<String, Integer>();
    private static ArrayList instr = new ArrayList<Instruction>();

    public static void main(String[] args) {
        try {
            setUp("input");
            VirtualMachine vm = new VirtualMachine(reg, instr);
            vm.run();
            System.out.println("Part 1:" + vm.highestRegValue());
        } catch (IOException e) {
            System.err.println("Error occurred while reading file.");
        }
    }

    private static void setUp(String filename) throws IOException {
        FileReader fr = new FileReader(filename);
        BufferedReader br = new BufferedReader(fr);
        String line;

        while ((line = br.readLine()) != null) {
            String[] pieces = line.split(" ");
            reg.put(pieces[0], 0);
            reg.put(pieces[4], 0);
            instr.add(new Instruction(pieces));
        }
    }
}

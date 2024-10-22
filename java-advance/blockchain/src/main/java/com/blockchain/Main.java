package com.blockchain;

import org.apache.commons.codec.digest.DigestUtils;

class Block {
    private int index;
    private String data;
    private String previousHash;
    private String hash;

    public Block(int index, long timestamp, String data, String previousHash, String hash) {
        this.index = index;
        this.data = data;
        this.previousHash = previousHash;
        this.hash = hash;
    }

    public int getIndex() {
        return index;
    }

    public String getData() {
        return data;
    }

    public String getPreviousHash() {
        return previousHash;
    }

    public String getHash() {
        return hash;
    }
}

public class Main {
    public static void main(String[] args) {
        String data = DigestUtils.md5Hex("Hello world!");
        System.out.println("Hello world!" + data);
    }
}
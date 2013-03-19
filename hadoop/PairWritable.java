package com.taobao.ad.rcc.hadoop;
import java.io.*;
import org.apache.hadoop.io.*;

public class PairWritable implements WritableComparable<PairWritable> {
    private LongWritable first;
    private ByteWritable second;
    public PairWritable() {
        set(new LongWritable(), new ByteWritable());
    }
    public PairWritable(long first, byte second) {
        set(new LongWritable(first), new ByteWritable(second));
    }
    public PairWritable(LongWritable first, ByteWritable second) {
        set(first, second);
    }
    public void set(LongWritable first, ByteWritable second) {
        this.first = first;
        this.second = second;
    }

    public void set(long first, byte second) {
        this.first.set(first);
        this.second.set(second);
    }

    public LongWritable getFirst() {
        return first;
    }
    public ByteWritable getSecond() {
        return second;
    }

    @Override
    public void write(DataOutput out) throws IOException {
        first.write(out);
        second.write(out);
    }

    @Override
    public void readFields(DataInput in) throws IOException {
        first.readFields(in);
        second.readFields(in);
    }
    @Override
    public int hashCode() {
        return first.hashCode() * 163 + second.hashCode();
    }
    @Override
    public boolean equals(Object o) {
        if (o instanceof PairWritable) {
            PairWritable tp = (PairWritable) o;
            return first.equals(tp.first) && second.equals(tp.second);
        }
        return false;
    }
    @Override
    public String toString() {
        return first + "\t" + second;
    }

    @Override
    public int compareTo(PairWritable tp) {
        int cmp = first.compareTo(tp.first);
        if (cmp != 0) {
            return cmp;
        }
        return second.compareTo(tp.second);
    }
}

// -*- tab-width: 8; -*-
package com.taobao.ad.rcc.hadoop;

import java.io.IOException;
import java.net.URI;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.SequenceFile;
import org.apache.hadoop.io.*;
import java.util.*;
import com.google.protobuf.AbstractMessage.Builder;
import com.google.protobuf.Message;
import java.lang.reflect.Method;
import com.google.protobuf.TextFormatNew;

// usage:
// java -cp target/rcc2-0.1-jar-with-dependencies.jar com.taobao.ad.rcc.hadoop.SeqReader "com.taobao.ad.rcc.proto.Rcc2\$TairProfile" n-r-00000
public class SeqReader {
    public static void main(String[] args) throws Exception {
        if (args.length != 2) {
            System.err.println("SeqReader proto_class input");
            return;
        }
        Configuration config = new Configuration();
        Class<?> cls = Class.forName(args[0]);
        //Class<?> cls = Class.forName("com.taobao.ad.rcc.proto.Rcc2$TairProfile");
        Method m = cls.getDeclaredMethod("newBuilder", (Class[])null);
        Builder builder = (Builder) m.invoke(null, null);
        Class<?> bcls = builder.getClass();
        Path path = new Path(args[1]);
        SequenceFile.Reader reader = new SequenceFile.Reader(FileSystem.get(config), path, config);
        
        try {
            Writable key = (Writable) reader.getKeyClass().newInstance();
            BytesWritable value = (BytesWritable) reader.getValueClass().newInstance();
            System.out.println("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>");
            System.out.println("<pairs>");
            
            while (reader.next(key, value)) {
                builder.clear().mergeFrom(value.getBytes(), 0, value.getLength()).build();
                String text = TextFormatNew.printToString(builder.build());
                String k = null;
                if (key instanceof Text) {
                    k = ((Text)key).toString();
                }
                else if (key instanceof BytesWritable) {
                    k = new String(((BytesWritable)key).getBytes(), 0, ((BytesWritable)key).getLength());
                }
                else if (key instanceof LongWritable) {
                    k =  String.valueOf(((LongWritable)key).get());
                }
                if (k == null) {
                    continue;
                }
                System.out.println("<pair>");
                System.out.println("<key>");
                System.out.println(k);
                System.out.println("</key>");
                System.out.println("<value>");
                System.out.println(text.trim());
                System.out.println("</value>");
                System.out.println("</pair>");
            }
            System.out.println("</pairs>");
        }
        finally {
            IOUtils.closeStream(reader);
        }        
    }
}

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
import java.io.*;

import com.google.protobuf.AbstractMessage.Builder;
import com.google.protobuf.Message;
import java.lang.reflect.Method;
import com.google.protobuf.TextFormatNew;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;

// usage:
// java -cp target/rcc2-0.1-jar-with-dependencies.jar com.taobao.ad.rcc.hadoop.SeqReader "com.taobao.ad.rcc.proto.Rcc2\$TairProfile"
// org.apache.hadoop.io.BytesWritable input.xml output.seq

public class SeqWriter {
    public static void main(String[] args) throws Exception {
        if (args.length != 4) {
            System.err.println("USAGE: SeqWriter Proto_Class out_key_class input.xml output.seq");
            return;
        }
        Configuration config = new Configuration();
        Class<?> cls = Class.forName(args[0]);
        //Class<?> cls = Class.forName("com.taobao.ad.rcc.proto.Rcc2$TairProfile");
        Method m = cls.getDeclaredMethod("newBuilder", (Class[])null);
        Builder builder = (Builder) m.invoke(null, null);
        Class<?> bcls = builder.getClass();

        Class<?> keyClass = Class.forName(args[1]);
        Path path = new Path(args[3]);
        
        Writable key = (Writable)keyClass.newInstance();
        BytesWritable value = new BytesWritable();
        SequenceFile.Writer writer = null;
        try {
            writer = SequenceFile.createWriter(FileSystem.get(config), config, path,
                                               key.getClass(), value.getClass());
            File XmlFile = new File(args[2]);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(XmlFile);
            doc.getDocumentElement().normalize();
            Element root = doc.getDocumentElement();
            NodeList pairs = root.getChildNodes();
            byte [] tmp;
            if (pairs != null) {
                for (int i=0; i < pairs.getLength(); i++) {
                    Node pair = pairs.item(i);
                    String k = null;
                    String v = null;

                    if (pair.getNodeType() == Node.ELEMENT_NODE) {
                        for (Node n = pair.getFirstChild(); n != null; n = n.getNextSibling()) {
                            if (n.getNodeType() == Node.ELEMENT_NODE) {
                                if (n.getNodeName().equals("key")) {
                                    k = n.getFirstChild().getNodeValue().trim();
                                }
                                else if (n.getNodeName().equals("value")) {
                                    v = n.getFirstChild().getNodeValue();
                                    TextFormatNew.merge(v, builder.clear());
                                }
                            }
                            if (k == null || v == null) {
                                continue;
                            }
                            if (key instanceof BytesWritable) {
                                tmp = k.getBytes();
                                ((BytesWritable)key).set(tmp, 0, tmp.length);
                            }
                            else if (key instanceof LongWritable){
                                ((LongWritable)key).set(Long.parseLong(k));
                            }
                            tmp = builder.build().toByteArray();
                            value.set(tmp, 0, tmp.length);
                            writer.append(key, value);
                        }
                    }
                }
            }
        }
        finally {
            IOUtils.closeStream(writer);
        }
        
    }

}

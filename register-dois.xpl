<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">
    <p:documentation>Generates a Python script from the proceedings to register DOIs and deposit articles with Zenodo. N.B. the resulting Python requires zenodo-client to run: see https://github.com/cthoyt/zenodo-client for details. Tested with XML Calabash 3.0.2.</p:documentation>
    <p:input port="source"/>    <!-- proceedings XML -->
    <p:output port="result"/>
    <p:option name="date" required="true"/> <!-- conference date in ISO format -->
    
    <p:xinclude fixup-xml-base="true"/> <!-- preserve base URIs so we can tell the Zenodo upload where to find the article XML -->
    
    <p:xslt parameters='map{"pubdate":xs:date($date)}'>
        <p:documentation>Transform the proceedings into a batch Zenodo upload, one per paper.</p:documentation>
        <p:with-input port="stylesheet" href="generate-python.xsl"/>
    </p:xslt>
    
    <p:store href="zenodo-test.py"/>
    
    <!-- TODO: execute the Python script and store JSON returned-->
    <!-- TODO: update proceedings XML with DOIs and re-load -->
</p:declare-step>
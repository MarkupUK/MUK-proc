<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" omit-xml-declaration="true"/>
    
    <xsl:param name="pubdate" as="xs:date"/>
    <xsl:variable name="year" select="year-from-date($pubdate)"/>
    
    <xsl:template match="/">
        <xsl:text>from zenodo_client import Creator, Metadata, ensure_zenodo</xsl:text>
        <xsl:apply-templates select="/*:book/*:article"/>    
    </xsl:template>
    
    <xsl:template match="*:book/*:article">
# Define the metadata that will be used on initial upload
data = Metadata(
title='<xsl:value-of select="(*:title, *:info/*:title)[1]"/>',
upload_type='publication',
publication_type='conferencepaper',
publication_date='<xsl:value-of select="$pubdate"/>',
conference_title='Markup UK <xsl:value-of select="$year"/>',
conference_url='https://markupuk.org/',
conference_acronym='MUK<xsl:value-of select="$year"/>',
conference_place='London',
imprint_publisher='Markup UK Conferences Limited',
description='''<xsl:apply-templates select="*:info/*:abstract"/>''',
<xsl:apply-templates select="*:info/*:keywordset"/>        
prereserve_doi='true',
creators=[
<xsl:apply-templates select="*:info/*:author"/>
],
)
res = ensure_zenodo(
key='<xsl:apply-templates select="*:info/*:author[1]" mode="generate-id"/>',  # this is a unique key you pick that will be used to store
# the numeric deposition ID on your local system's cache
data=data,
paths=[
'<xsl:value-of select="replace(@xml:base, '^file:[/]+', '') => replace('%20', ' ')"/>',
],
sandbox=True,  # remove this when you're ready to upload to real Zenodo
)
from pprint import pprint

pprint(res.json())
    </xsl:template>
    
    <xsl:template match="*:info/*:author">
        Creator(
        name='<xsl:apply-templates select="*:personname"/>',
        affiliation='<xsl:value-of select="*:affiliation/*:orgname"/>'
        ),
    </xsl:template>
    
    <xsl:template match="*:personname[*:surname and *:firstname]">
        <xsl:value-of select="*:surname, *:firstname" separator=", "/>    
    </xsl:template>
    
    <xsl:template match="*:personname[not(*:surname or *:firstname)]">
        <xsl:variable name="names" select="tokenize(.)"/>
        <xsl:value-of select="$names[last()]"/>
        <xsl:text>, </xsl:text>
        <xsl:sequence select="$names[position() lt last()]"/>
    </xsl:template>
    
    <xsl:template match="*:info/*:author" mode="generate-id">
        <xsl:variable name="name">
            <xsl:choose>
                <xsl:when test="*:firstname and *:surname">
                    <xsl:sequence select="concat(*:personname/*:surname, *:personname/*:firstname)"/>
                </xsl:when>
                <xsl:otherwise><xsl:sequence select="replace(*:personname, '\s+', '')"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat($name, $year)"/>
    </xsl:template>
    
    <xsl:template match="*:para">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="*:itemizedlist">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="*:listitem">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="*:orderedlist">
        <ol><xsl:apply-templates/></ol>
    </xsl:template>
    
    <xsl:template match="*:keywordset">
        <xsl:text>keywords=[</xsl:text>
        <xsl:apply-templates select="*:keyword"/>
        <xsl:text>],</xsl:text>        
    </xsl:template>
    
    <xsl:template match="*:keyword">
        <xsl:text>'</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>'</xsl:text>
        <xsl:if test="following-sibling::*:keyword">, </xsl:if>
    </xsl:template>
    
    <xsl:template match="*:footnote"/>
        
    
    
</xsl:stylesheet>
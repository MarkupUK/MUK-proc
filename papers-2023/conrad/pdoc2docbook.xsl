<!-- ==========================================================================
                                                                    dawkc 79
                                                                    . ..
    Module:   pdoc2docbook.xsl
              conversion to muk2023 doctype
  
    Date:     working
            
    Version:  working
                                                                     . ...
    Purpose:  

    Developers:
  
              kwc   Kurt Conrad     conrad@scriptorium.com
                                    conrad@sagebrushgroup.com
            
  Revisions Pending:
      
  Revisions:
      
      2023.05.28  kwc   - Created 17:30
      
=========================================================================== -->

<x:stylesheet version="3.0"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:sg="http://sagebrushgroup.com"
  xmlns:sp ="http://scriptorium.com"
  xmlns:x ="http://www.w3.org/1999/XSL/Transform"
  xmlns:xp="http://www.jenitennison.com/xslt/xspec"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xl="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="sg sp x xp xs">


  <!-- ####### ################################################################
  .   #  
  . . #       Input         
  .   # 
  . -->
  
  <x:strip-space elements="*"/>


  <!-- ####### ################################################################
  .   #  
  . . #       Output         
  .   # 
  . -->

  <x:output indent="no" method="xml"/>

  <!--<x:output
    doctype-public="-//SG//DTD prodoc//EN"
    doctype-system="prodoc.dtd"
    indent="yes"
    method="xml"/>-->


  <!-- ####### ################################################################
  .   #  
  . . #       Global variables         
  .   # 
  . -->
  <!-- ========= ==============================================================
  . . |
  . . |         Sources & templates 
  . -->
  <!-- ............... ..................... ..................................
  . . :               $source               - primary source tree
  -->
  
  <x:variable name="sourceFile" select="'muk23paper.pdoc'"/>
  <!--<x:variable name="sourceFile" select="'hello.xml'"/>-->
  <x:variable name="source" select="document($sourceFile)"/>
  
  <!--<x:variable name="source" select="/"/>-->
  
  <!-- ............... ..................... ..................................
  . . :               $target               - primary target tree tree
  . -->

  <x:variable name="target" select="''"/>


  <!-- ####### ################################################################
  . . #  
  . . #       Identity transform         
  .   # 
  . -->
  
  <x:template match="@*">
    <!--<x:copy/>-->
  </x:template>
  
  <x:template match="node()">
    <x:copy>
      <x:apply-templates select="@*| node()"/>
    </x:copy>
  </x:template>
  
  
    
  <!--  ######################################################################
  .    ########################################################################
  . . ##
  . . ##    Root node 
  .   ##
  . -->

  <x:template match="/">
    <x:message select="concat('. Processing $sourceFile=',$sourceFile)"/>
    <!--<x:message select="concat('.            $node=',$sourceFile/*/name())"/>-->
    
    <x:apply-templates select="$source/*"/>
    <!--<x:sequence select="sg:x('x')"/>-->
  </x:template>
  
  <!--##
  .   ##
  .    ########################################################################
  .     ################################################################### -->


  <!-- ####### ################################################################
  . . #  
  . . #       Templates         
  .   # 
  . -->
  <!-- ========= ==============================================================
  . . |
  . . |         skip, skip, skip 
  . -->
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             */@display='none' 
  . -->
  <x:template match="*[@display='none']"/>
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             */@include='no' 
  . -->
  <x:template match="*[@include='no']"/>
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             meta, xinclude 
  . -->
  <x:template match="meta| xinclude"/>
    
  <!-- ========= ==============================================================
  . . |
  . . |         divs 
  . -->
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             div                     -> section 
  . -->
  <x:template match="div">
    <section><x:apply-templates select="@*|node()"/></section>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             prodoc                  -> article 
  . -->
  <x:template match="prodoc">
    <x:message select="concat('got ','here')"/>
    <article 
      xmlns:xl="http://www.w3.org/1999/xlink"
      version="5.0" xml:lang="en">
      <x:apply-templates select="@*|node()"/>
    </article>
    <x:message select="concat('and ','here')"/>
  </x:template>  
  <!-- ========= ==============================================================
  . . |
  . . |         heads 
  . -->
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             h                       -> title 
  . -->
  <x:template match="h">
    <title><x:apply-templates select="@*|node()"/></title>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             header                  -> info 
  . -->
  <x:template match="header">
    <info>
      <x:apply-templates select="@*|node()"/>
      <author>
        <personname>Kurt Conrad</personname>
        <email>conrad@SagebrushGroup.com</email>
        <uri>http://@SagebrushGroup.com</uri>
        <personblurb>
          <x:apply-templates select="id('personblurb')"/>
        </personblurb>
        <affiliation><jobtitle>Principle researcher &amp; Test subject</jobtitle><orgname>The Sagebrush Group</orgname></affiliation>
      </author>
      <keywordset>
        <x:apply-templates select="id('keywordset')" mode="keyword"/>
      </keywordset>
      <abstract>
        <x:apply-templates select="id('info.abstract')"/>
      </abstract>
    </info>
  </x:template>  
  <!-- ========= ==============================================================
  . . |
  . . |         blocks 
  . -->
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             *[@docbook="image"]     -> imagedata 
  . -->
  <x:template match="*[@docbook='image']" priority="10">
    <x:variable name="fname" select="concat('img/',name(),'.',@id,'.png')"/>
    <x:variable name="width">
      <x:choose>
        <x:when test="exists(@dbwidth)"><x:value-of select="@dbwidth"/></x:when>
        <x:when test="exists(@width)"><x:value-of select="@width"/></x:when>
        <x:otherwise>100%</x:otherwise>
      </x:choose>
    </x:variable>
    <!--<titleabbrev><x:sequence select="$fname"/> -\- <x:sequence select="$width"/></titleabbrev>-->
    <mediaobject>
      <alt><x:value-of select="@alt"/></alt>
      <imageobject>
        <imagedata align="center" fileref="{$fname}" width="{$width}"/>
      </imageobject>
    </mediaobject>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             bbody                   -> tgroup 
  . -->
  <x:template match="bbody| branches| branch">
    <tgroup><x:apply-templates select="@*|node()"/></tgroup>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             block, div.table, div.row      -> unwrap 
  . -->
  <x:template match="block| div.table| div.row">
    <x:apply-templates select="@*|node()"/>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             block[id=keywordset]/p                       -> para 
  . -->
  <x:template match="block[@id='keywordset']/p"  mode="keyword">
    <keyword><x:apply-templates select="@*|node()"/></keyword>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             codeblock               -> ?
  . -->
  <x:template match="codeblock">
    <!--<literallayout><x:apply-templates select="@*|node()"/></literallayout>-->
    <literallayout><computeroutput><x:apply-templates select="@*|node()"/></computeroutput></literallayout>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             figure                  -  
  . -->
  <x:template match="figure">
    <figure>
      <x:apply-templates select="@*|node()"/>
    </figure>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             figure/img              -  
  . -->
  <x:template match="figure/img">
    <mediaobject>
      <alt><x:value-of select="@alt"/></alt>
      <imageobject>
        <imagedata fileref="{@src}"/>
      </imageobject>
    </mediaobject>
  </x:template>
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             figure/subh             -  
  . -->
  <x:template match="figure/subh">
    <title><x:apply-templates select="@*|node()"/></title>
  </x:template>  
    <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             figure/table              -  
  . -->
  <x:template match="figure/table">
    <informaltable><x:apply-templates select="@*|node()"/></informaltable>
  </x:template>
  <x:template match=" figure//tbody|
                      figure//td|
                      figure//th|
                      figure//thead|
                      figure//tr">
    <x:element name="{local-name()}">
      <x:apply-templates select="@*|node()"/>
    </x:element>
  </x:template>
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             kfam                    -> table.kfam
  . -->
  <x:template match="kfam">
    <!--<table role="kfam" alt="{@alt}"><tbody><x:apply-templates select="@*|node()"/></tbody></table>-->
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             kfamRow                 -> row.kfam
  . -->
  <x:template match="kfamRow">
    <!--<row role="kfam"><x:apply-templates select="@*|node()"/></row>-->
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             kfamCell                -> entry.kfam
  . -->
  <x:template match="kfamCell">
    <!--<entry role="kfam"><x:apply-templates select="@*|node()"/></entry>-->
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             li                      -> listitem 
  . -->
  <x:template match="li">
    <listitem><x:apply-templates select="@*|node()"/></listitem>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             nav                     - skip 
  . -->
  <x:template match="nav">
    
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             ol                      -> orderedlist 
  . -->
  <x:template match="ol">
    <orderedlist><x:apply-templates select="@*|node()"/></orderedlist>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             p                       -> para 
  . -->
  <x:template match="p"><para><x:apply-templates select="node()"/></para></x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             p[sp]                   -> para, ol 
  . -->
  <x:template match="p[sp]">
    <para><x:apply-templates select="sp[1]/(@*|node())"/></para>
    <itemizedlist>
      <x:for-each select="sp[position() > 1]">
        <listitem>
          <para><x:apply-templates select="@*|node()"/></para>
        </listitem>  
      </x:for-each>
    </itemizedlist>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             qblock                  -> blockquote 
  . -->
  <x:template match="qblock">
    <blockquote>
      <attribution><x:apply-templates select="caption/node()"/></attribution>
      <x:apply-templates select="p"/></blockquote>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             subh                    -> subtitle 
  . -->
  <x:template match="subh">
    <subtitle><x:apply-templates select="@*|node()"/></subtitle>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             ul                      -> itemizedlist 
  . -->
  <x:template match="ul">
    <itemizedlist><x:apply-templates select="@*|node()"/></itemizedlist>
  </x:template>  

  <!-- ========= ==============================================================
  . . |
  . . |         spans 
  . -->
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             a                       -> xref 
  . -->
  <x:template match="a">
    <link xl:href="{@href}"><x:apply-templates select="@*|node()"/></link>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             agent, et al.           - names spans -> phrase/@role 
  . -->
  <x:template match="agent| aka| artifact| behavior| bot| c| data| from| gov|
                    ind| info| issue| k| ka| ku| kwc| l| lyric| mgmt| mka|
                    mksense| oxcmd| pa| rel| sense| span| sys| to| v">
    <phrase role="{name()}"><x:apply-templates select="@*|node()"/></phrase>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             b                       -> emphasis 
  . -->
  <x:template match="b"><emphasis role="bold"><x:value-of select="."/></emphasis></x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             dir                     -> computeroutput 
  . -->
  <x:template match="dir">
    <computeroutput role="{name()}"><x:apply-templates select="@*|node()"/></computeroutput>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             fdown, etc.             - ▼  ◀  ◀ ▶  ▶  ▲ 
  . -->
  <x:template match="fdown">    <x:text>▼</x:text>    </x:template>  
  <x:template match="fleft">    <x:text>◀</x:text>    </x:template>  
  <x:template match="flright">  <x:text>◀ ▶</x:text>  </x:template>  
  <x:template match="fright">   <x:text>▶</x:text>    </x:template>  
  <x:template match=" fup">     <x:text>▲</x:text>    </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             file                    -> filename 
  . -->
  <x:template match="file">
    <filename><x:apply-templates select="@*|node()"/></filename>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             gloss                   - ? 
  . -->
  <x:template match="gloss">
    <phrase role="gloss">
      <emphasis role="bold"><x:apply-templates select="text/node()"/></emphasis>
      <emphasis role="treatment"><x:apply-templates select="treatment/node()"/></emphasis>
    </phrase>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             i                       -> emphasis
  . -->
  <x:template match="i">
    <emphasis><x:apply-templates select="@*|node()"/></emphasis>
  </x:template>  
    <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             img                     -> imagedata 
  . -->
    <x:template match="img">
      <x:variable name="img" select="@src"/>
      <inlinemediaobject>
        <alt><x:value-of select="@alt"/></alt>
        <imageobject>
          <imagedata fileref="{$img}" width="{@width}"/>
        </imageobject>
      </inlinemediaobject>
    </x:template>  
    <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             org                     -> orgname 
  . -->
  <x:template match="org">
    <orgname><x:apply-templates select="@*|node()"/></orgname>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             oxml                    -> emphasis 
  . -->
  <x:template match="oxml">
    <orgname><x:text>oXml</x:text></orgname>
  </x:template>  
  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             q                       -> quote 
  . -->
  <x:template match="q">
    <quote><x:apply-templates select="@*|node()"/></quote>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             strong                  -> emphasis 
  . -->
  <x:template match="strong">
    <emphasis role="strong"><x:apply-templates select="@*|node()"/></emphasis>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             title                   -> citetitle 
  . -->
  <x:template match="title">
    <citetitle><x:apply-templates select="@*|node()"/></citetitle>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             u                       -> emphasis 
  . -->
  <x:template match="u">
    <emphasis role="underline"><x:apply-templates select="@*|node()"/></emphasis>
  </x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             xa                      -> computeroutput 
  . -->
  <x:template match="xa"><computeroutput role="{name()}"><x:sequence select="concat('@',.)"/></computeroutput></x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             xet                     -> computeroutput 
  . -->
  <x:template match="xet"><computeroutput role="{name()}"><x:sequence select="concat('&lt;/',.,'&gt;')"/></computeroutput></x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             xpath                   -> computeroutput 
  . -->
  <x:template match="xpath"><computeroutput role="{name()}"><x:apply-templates select="@*|node()"/></computeroutput></x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             xpe                     -> computeroutput 
  . -->
  <x:template match="xpe"><computeroutput role="{name()}"><x:sequence select="concat('%',.,';')"/></computeroutput></x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             xst                     -> computeroutput 
  . -->
  <x:template match="xst"><computeroutput role="{name()}"><x:sequence select="concat('&lt;',.,'&gt;')"/></computeroutput></x:template>  
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             xsol                    -> computeroutput 
  . -->
  <x:template match="xsol"><computeroutput role="{name()}"><x:sequence select="concat('&lt;',.,'/&gt;')"/></computeroutput></x:template>  
  
  

  <!-- ####### ################################################################
  . . #  
  . . #       Functions         
  .   # 
  . -->
  <!-- ========= ==============================================================
  . . |
  . . |         grouping 
  . -->
  <!-- ~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  . . :             x($)                    - 
  . -->
  
  <x:function name="sg:x">
    <x:param name="x"/>
  </x:function>

</x:stylesheet>

<!--      | | |       |       |             | |                     |          | ruler
                      module name           - description                          |
                        $name
dawk cut    1 2 3 4 5 6 7 8 9 
12345678901234567890123456789012345678901234567890123456789012345678901234567890
         1| | |    2  |      3|        4    | |  5         6        |7         8
-->

<!-- ==========================================================================
                                                              dawkIns ....
              dawk Summary            
                                               
    SPath:    D:\kc\prog\semAuth\muk23\                  
    SFile:    pdoc2docbook.xsl                
    Gen:      2023-05-29 22:07         
    GenBy:    D:\kc\xt\bin\dawk.awk           
    Target:   D:\kc\xt\bin\scratch\dawk_tgt.txt           
    fileType: xml
    chopCol:  79

    Module:   pdoc2docbook.xsl
              conversion to muk2023 doctype
  
    Date:     working
            
    Version:  working
 
    Contents:

    39        Input
    48        Output
    63        Global variables
    67   
    68          Sources & templates
    71                $source               - primary source tree
    81                $target               - primary target tree tree
    88   
    89        Identity transform
   107   
   108      Root node
   127   
   128        Templates
   132   
   133          skip, skip, skip
   136              */@include='no'
   140              meta, xinclude
   145   
   146          divs
   149              div                     -> section
   155              prodoc                  -> article
   167   
   168          heads
   171              h                       -> title
   177              header                  -> info
   200   
   201          blocks
   204              *[@docbook="image"]     -> imagedata
   216              bbody                   -> tgroup
   222              block, div.table, div.row      -> unwrap
   228              block[id=keywordset]/p                       -> para
   234              codeblock               -> ?
   241              figure                  -
   249              figure/subh             -
   255              img                     -> imagedata
   261              p[img]                  -
   273              kfam                    -> table.kfam
   280              kfamRow                 -> row.kfam
   286              kfamCell                -> entry.kfam
   292              li                      -> listitem
   298              nav                     - skip
   304              ol                      -> orderedlist
   310              p                       -> para
   316              p[sp]                   -> para, ol
   329              qblock                  -> blockquote
   337              subh                    -> subtitle
   343              ul                      -> itemizedlist
   350   
   351          spans
   354              a                       -> xref
   360              agent, et al            - names spans -> phrase/@role
   368              b                       -> emphasis
   374              dir                     -> computeroutput
   380              fdown, etc              - ▼  ◀  ◀ ▶  ▶  ▲
   388              gloss                   - ?
   397              i                       -> emphasis
   403              org                     -> orgname
   409              oxml                    -> emphasis
   416              q                       -> quote
   422              strong                  -> emphasis
   428              title                   -> citetitle
   434              u                       -> emphasis
   440              xa                      -> emphasis
   446              xpath                   -> emphasis
   452              xpe                     -> emphasis
   458              xsol                    -> emphasis
   467   
   468        Functions
   472   
   473          grouping
   476              x($)                    -
   589   
   590      TOMB
   593   
   594      END  xsltTp.xsl

# 2023.05.29 22:07 # D:\kc\prog\semAuth\muk23\ # pdoc2docbook.xsl #
                                                              dawkIns .....
=========================================================================== -->
<!-- ==========================================================================
. . 
. .         TOMB
=========================================================================== -->
<!-- ==========================================================================
. . 
. .         END  xsltTp.xsl
.    ====================================================================== -->

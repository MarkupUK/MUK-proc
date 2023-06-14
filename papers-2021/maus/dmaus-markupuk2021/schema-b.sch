<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="ex" uri="http://example.com/ns"/>
  <sch:let name="allowedTypes" value="tokenize('foo bar', ' ')"/>
  <sch:pattern id="pattern-b">
    <sch:rule context="ex:element[@type = $allowedTypes]">
      <sch:assert test="false()"/>
    </sch:rule>
  </sch:pattern>
</sch:schema>
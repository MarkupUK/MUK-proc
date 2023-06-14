<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:title>Example of Multi-Lingual Schema</sch:title>
    <sch:pattern>
        <sch:rule context="dog">
            <sch:assert test="bone" diagnostics="bone-en bone-de"/>
        </sch:rule>
    </sch:pattern>
    <sch:diagnostics>
        <sch:diagnostic xml:lang="en" id="bone-en">A dog should have a bone.</sch:diagnostic>
        <sch:diagnostic xml:lang="de" id="bone-de">Ein Hund sollte ein Bein haben.</sch:diagnostic>
    </sch:diagnostics>
</sch:schema>
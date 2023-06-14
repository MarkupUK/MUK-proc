<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:title>Improved Example of Multi-Lingual Schema</sch:title>
    <sch:pattern>
        <sch:rule context="dog">
            <sch:assert test="bone" diagnostics="bone"/>
        </sch:rule>
    </sch:pattern>
    <sch:diagnostics>
        <sch:diagnostic id="bone">
            <sch:message xml:lang="en">A dog should have a bone.</sch:message>
            <sch:message xml:lang="de">Ein Hund sollte ein Bein haben.</sch:message>
        </sch:diagnostic>
    </sch:diagnostics>
</sch:schema>
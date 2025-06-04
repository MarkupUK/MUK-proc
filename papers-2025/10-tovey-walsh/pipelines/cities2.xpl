<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                name="main" version="3.1">
  <p:import href="https://xmlcalabash.com/ext/library/selenium.xpl"/>
  <p:output port="result"/>
  <p:option name="uri"/>

  <cx:selenium>
    <p:with-option name="arguments" select="('--headless')"/>
    <p:with-input>
      <p:inline content-type="text/plain">script version 0.2 .
      page "{$uri}" .

      find $button by id = "more" .
      click $button .
      pause PT0.5S .

      output to result .
      </p:inline>
    </p:with-input>
  </cx:selenium>
</p:declare-step>

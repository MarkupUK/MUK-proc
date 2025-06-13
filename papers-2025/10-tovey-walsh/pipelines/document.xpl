<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                name="main" version="3.1">
  <p:output port="result"/>
  <p:option name="uri"/>

  <p:load href="{$uri}"/>

</p:declare-step>
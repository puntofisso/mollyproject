<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xsl:version="1.0">
  <xsl:template match="/">
      <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="body">
    <xsl:copy>
      <xsl:apply-templates select="text() | node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="img | a | ul | ol | li | em | strong | u | b | i | dl | dt | dd | table | thead | tbody | tfoot | tr | th | td | p | br | div | span | abbr | acronym | address | bda | blockquote | caption | cite | code | col | colgroup | del | dfn | hr | ins | kbd | pre | q | s | samp | small | big | strike | sub | sup | tt | var">
    <xsl:copy>
      <xsl:apply-templates select="text() | node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <!-- Add a prefix to @id attributes -->
  <xsl:template match="@id">
    <xsl:attribute name="id">{{ id_prefix }}-<xsl:value-of select="."/></xsl:attribute>
  </xsl:template>

  <!-- Add a prefix to @class attributes -->
  <xsl:template match="@class">
    <xsl:attribute name="class">
      <xsl:for-each select="tokenize('.', '\s+')">{{ class_prefix }}-<xsl:value-of select="."/></xsl:for-each>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="@href">
    <xsl:if test="starts-with(string(), 'http://') | starts-with(string(), 'https://')">
      <xsl:copy/>
    </xsl:if>
  </xsl:template>

  <!-- Attributes we believe are safe -->
  <xsl:template match="@src | @title | @alt | @width | @height | @dir | @lang | @xml:lang">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="@*"/>

  <!-- We want to suppress the contents of these -->
  <xsl:template match="script | object | style | applet"/>

  <!-- All other nodes, drop the tag but keep the contents -->
  <xsl:template match="node()">
    <xsl:apply-templates select="text() | node() | @*"/>
  </xsl:template>

</xsl:stylesheet>

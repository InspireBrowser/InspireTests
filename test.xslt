<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="UTF-8" indent="yes" media-type="text/html"/>
	<xsl:template match="javascript">
		<script type="text/javascript">
			$(window).load(function() {
				if(!window.IVideo) {
					return alert("Test must be run within Inspire Browser with Advanced API enabled")
				}
				<xsl:value-of select="/test/javascript/@onload"/>
			});
			$(window).unload(function() {
				<xsl:value-of select="/test/javascript/@onunload"/>
			});

			<xsl:value-of select="." disable-output-escaping="yes"/>
		</script>
	</xsl:template>
	<xsl:template match="css">
		<style>
			<xsl:value-of select="." disable-output-escaping="yes"/>
		</style>
	</xsl:template>
	<xsl:template match="html">
		<xsl:value-of select="." disable-output-escaping="yes"/>
	</xsl:template>

	<xsl:template match="description|name">
	</xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="UTF-8" indent="yes" media-type="text/html"/>
	<xsl:template match="/">
		<article>
			<xsl:if test="count(*/property) > 0">
				<section class="properties">
					<h2>Properties</h2>
					<ul class="properties">
						<xsl:apply-templates select="*/property"/>
					</ul>
				</section>
			</xsl:if>

			<xsl:if test="count(*/function) > 0">
				<section class="functions">
					<h2>Functions</h2>
					<ul class="functions">
						<xsl:apply-templates select="*/function"/>
					</ul>
				</section>
			</xsl:if>

			<xsl:if test="count(*/subsystem) > 0">
				<section class="subsystems">
					<h2>Subsystems</h2>
					<ul class="subsystems">
						<xsl:apply-templates select="*/subsystem"/>
					</ul>
				</section>
			</xsl:if>

			<xsl:if test="count(*/test) > 0">
				<section class="tests">
					<h2>Tests</h2>
					<ul class="tests">
						<xsl:apply-templates select="*/test"/>
					</ul>
				</section>
			</xsl:if>
		</article>
		<aside id="recently_viewed">
			<h2>Recently Viewed</h2>
		</aside>
	</xsl:template>
	
	<xsl:template match="subsystem|property|function">
		<li>
			<a>
				<xsl:attribute name="href">?path=<xsl:value-of select="$path"/>/<xsl:value-of select="name"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
		</li>
	</xsl:template>
	
	<xsl:template match="test">
		<li>
			<a>
				<xsl:attribute name="href">?test=<xsl:value-of select="$path"/>/<xsl:value-of select="id"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="/">
        <recettes>
            <xsl:for-each select="//objet[@type = 'recette']">
                <recette>
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    <nom><xsl:value-of select="info[@nom='nom']/@value"/></nom>
                    <resume><xsl:copy-of select="info[@nom='résumé']/*"/></resume>
                    <date-publication><xsl:value-of select="info[@nom='date_publication']/@value"/></date-publication>
                    <difficulte><xsl:value-of select="info[@nom='difficulté']/@value"/></difficulte>
                    <xsl:for-each select="info[@nom='ingrédient']">
                        <ref-ingredient>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="@value"/>
                            </xsl:attribute>
                            <xsl:attribute name="quantite">
                                <xsl:value-of select="@quantite"/>
                            </xsl:attribute>
                        </ref-ingredient>
                    </xsl:for-each>
                    <temps-preparation><xsl:value-of select="info[@nom='Préparation']/@value"/></temps-preparation>
                    <temps-cuisson><xsl:value-of select="info[@nom='Cuisson']/@value"/></temps-cuisson>
                    <temps-repos><xsl:value-of select="info[@nom='Repos']/@value"/></temps-repos>
                    <nb-personnes><xsl:value-of 
                        select="info[@nom='nbre_personnes']/@value"/></nb-personnes>
                    <description>
                        <xsl:copy-of select="info[@nom='Préparation']/*"/></description>
                    <note></note>
                </recette>
            </xsl:for-each>
            <xsl:for-each select="//objet[@type = 'auteur']">
                <auteur>
                    <nom >
                        <xsl:value-of select="info[@nom='prenom']/@value"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="info[@nom='nom']/@value"/>
                    </nom>
                    <pays><xsl:value-of select="info[@nom='pays']/@value"/></pays>
                    <sexe><xsl:value-of select="info[@nom='sexe']/@value"/></sexe>
                    <xsl:for-each select="info[@nom='recette']">
                        <ref-recette>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="@value"/>
                            </xsl:attribute>
                        </ref-recette>
                    </xsl:for-each>
                </auteur>
            </xsl:for-each>
        </recettes>
    </xsl:template>
</xsl:stylesheet>
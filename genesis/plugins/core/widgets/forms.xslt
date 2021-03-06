<xsl:template match="formbox">
        <div id="{@id}" style="width: {x:css(@width, 'auto')}; height: {x:css(@height, 'auto')}; overflow: hidden">
            <input id="{@id}-url" type="hidden" name="__url" value="/handle/form/submit/{@id}"/>
            <xsl:apply-templates />
            <formline>
                <xsl:if test="not(@hideok = 'True')">
                    <xsl:choose>
                        <xsl:when test="@mp != ''">
                            <button text="OK" onclick="form" action="OK" form="{@id}" design="primary" mp="True" />
                        </xsl:when>
                        <xsl:otherwise>
                            <button text="OK" onclick="form" action="OK" form="{@id}" design="primary" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <xsl:if test="not(@hidecancel = 'True')">
                    <button text="Cancel" onclick="form" action="Cancel" form="{@id}"/>
                </xsl:if>
                <xsl:if test="@miscbtn">
                    <button text="{@miscbtn}" id="{@miscbtnid}"/>
                </xsl:if>
            </formline>
        </div>
</xsl:template>

<xsl:template match="simpleform">
    <div id="{@id}" style="display:inline-block">
        <input id="{@id}-url" type="hidden" name="__url" value="/handle/form/submit/{@id}"/>
        <xsl:apply-templates />
    </div>
</xsl:template>

<xsl:template match="dialogbox">
<div>
    <div id="{@id}" class="modal fade">
        <input id="{@id}-url" type="hidden" name="__url" value="/handle/dialog/submit/{@id}"/>
        <div class="modal-body">
            <xsl:apply-templates />
        </div>

        <div class="modal-footer">
            <xsl:if test="not(@hideok = 'True')">
                <xsl:choose>
                    <xsl:when test="@mp != ''">
                        <xsl:choose>
                            <xsl:when test="@yesno != ''">
                                <button text="Yes" onclick="form" action="OK" form="{@id}" design="primary" mp="True" />
                            </xsl:when>
                            <xsl:otherwise>
                                <button text="OK" onclick="form" action="OK" form="{@id}" design="primary" mp="True" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="@yesno != ''">
                                <button text="Yes" onclick="form" action="OK" form="{@id}" design="primary" />
                            </xsl:when>
                            <xsl:otherwise>
                                <button text="OK" onclick="form" action="OK" form="{@id}" design="primary" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="not(@hidecancel = 'True')">
                <xsl:choose>
                    <xsl:when test="@yesno != ''">
                        <button text="No" onclick="form" action="Cancel" form="{@id}"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <button text="Cancel" onclick="form" action="Cancel" form="{@id}"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="@miscbtn">
                <button text="{@miscbtn}" id="{@miscbtnid}"/>
            </xsl:if>
        </div>
    </div>
    <script>
        Genesis.UI.showAsModal('<xsl:value-of select="@id"/>');
    </script>
</div>
</xsl:template>

<xsl:template match="confirmbox">
<div>
    <div id="{@id}" class="modal fade">
        <input id="{@id}-url" type="hidden" name="__url" value="/handle/dialog/submit/{@id}"/>
        <div class="modal-body">
            <label text="{@text}" />
        </div>

        <div class="modal-footer">
            <xsl:if test="not(@hidecancel = 'True')">
                <button text="Cancel" onclick="form" action="Cancel" form="{@id}"/>
            </xsl:if>
            <button text="No" onclick="form" action="Reject" form="{@id}" design="primary" />
            <button text="Yes" onclick="form" action="Confirm" form="{@id}" design="primary" />
        </div>
    </div>
    <script>
        Genesis.UI.showAsModal('<xsl:value-of select="@id"/>');
    </script>
</div>
</xsl:template>

<xsl:template match="inputbox">
<div>
    <div id="{@id}" class="modal fade">
        <input id="{@id}-url" type="hidden" name="__url" value="/handle/dialog/submit/{@id}"/>
        <div class="modal-header">
            <h3><xsl:value-of select="@text" /></h3>
        </div>
        <div class="modal-body">
            <xsl:if test="not(@extra)">
                <textinput size="30" password="{@password}" name="value" value="{@value}"/>
            </xsl:if>
            <xsl:if test="@extra = 'area'">
                <textinputarea id="{@id}-inner" name="value" nodecode="True" value="{x:b64(@value)}" width="{x:attr(@width,400)}" height="{x:attr(@height,400)}"/>
            </xsl:if>
            <xsl:if test="@extra = 'code'">
                <codeinputarea id="{@id}-inner" name="value" nodecode="True" value="{x:b64(@value)}" width="{x:attr(@width,800)}" height="{x:attr(@height,600)}"/>
            </xsl:if>
        </div>
        <div class="modal-footer">
            <xsl:if test="not(@hideok = 'True')">
                <button text="OK" onclick="form" action="OK" form="{@id}" design="primary" />
            </xsl:if>
            <xsl:if test="not(@hidecancel = 'True')">
                <button text="Cancel" onclick="form" action="Cancel" form="{@id}"/>
            </xsl:if>
        </div>
    </div>
    <script>
        Genesis.UI.showAsModal('<xsl:value-of select="@id"/>');
        <xsl:if test="not(@extra)">
            $('#<xsl:value-of select="@id"/> input[type!=hidden]')[0].focus();
        </xsl:if>
        <xsl:if test="@extra = 'area'">
            $('#<xsl:value-of select="@id"/> textarea')[0].focus();
        </xsl:if>
    </script>
</div>
</xsl:template>

<xsl:template match="uploadbox">
<div>
    <div id="{@id}" class="modal fade">
        <input id="{@id}-url" type="hidden" name="__url" value="/handle/dialog/submit/{@id}"/>
        <div class="modal-header">
            <h3><xsl:value-of select="@text" /></h3>
        </div>
        <div class="modal-body">
            <xsl:if test="@location != ''">
                <formline text="Uploading to">
                    <label text="{@location}" />
                </formline> 
            </xsl:if>
            <formline>
                <fileinput id="file" multiple="{@multiple}" />
            </formline>
        </div>

        <div class="modal-footer">
            <xsl:if test="not(@hideok = 'True')">
                <button text="Upload" onclick="form" action="OK" form="{@id}" design="primary" mp="True" />
            </xsl:if>
            <xsl:if test="not(@hidecancel = 'True')">
                <button text="Cancel" onclick="form" action="Cancel" form="{@id}" />
            </xsl:if>
            <xsl:if test="@miscbtn">
                <button text="{@miscbtn}" id="{@miscbtnid}"/>
            </xsl:if>
        </div>
    </div>
    <script>
        Genesis.UI.showAsModal('<xsl:value-of select="@id"/>');
    </script>
</div>
</xsl:template>

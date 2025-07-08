<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" version="3.4.15-Madeira" minScale="1e+08">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <customproperties>
    <property key="WMSBackgroundLayer" value="false"/>
    <property key="WMSPublishDataSourceUrl" value="false"/>
    <property key="embeddedWidgets/count" value="0"/>
    <property key="identify/format" value="Value"/>
  </customproperties>
  <pipe>
    <rasterrenderer classificationMin="0.1" classificationMax="1" band="1" type="singlebandpseudocolor" opacity="0.8" alphaBand="-1">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader colorRampType="INTERPOLATED" classificationMode="1" clip="0">
          <colorramp name="[source]" type="gradient">
            <prop v="26,150,65,255" k="color1"/>
            <prop v="215,25,28,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.25;166,217,106,255:0.5;255,255,192,255:0.75;253,174,97,255" k="stops"/>
          </colorramp>
          <item label="0.1" alpha="255" value="0.1" color="#1a9641"/>
          <item label="0.325" alpha="255" value="0.325" color="#a6d96a"/>
          <item label="0.55" alpha="255" value="0.55" color="#ffffc0"/>
          <item label="0.775" alpha="255" value="0.775" color="#fdae61"/>
          <item label="1" alpha="255" value="1" color="#d7191c"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0"/>
    <huesaturation grayscaleMode="0" colorizeGreen="128" colorizeBlue="128" saturation="0" colorizeStrength="100" colorizeOn="0" colorizeRed="255"/>
    <rasterresampler maxOversampling="2"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>

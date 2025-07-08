<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis minScale="1e+08" maxScale="0" styleCategories="AllStyleCategories" version="3.4.15-Madeira" hasScaleBasedVisibilityFlag="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <customproperties>
    <property value="false" key="WMSBackgroundLayer"/>
    <property value="false" key="WMSPublishDataSourceUrl"/>
    <property value="0" key="embeddedWidgets/count"/>
    <property value="Value" key="identify/format"/>
  </customproperties>
  <pipe>
    <rasterrenderer type="paletted" alphaBand="-1" band="4" opacity="1">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <colorPalette>
        <paletteEntry value="-1" alpha="255" label="-1" color="#3786cf"/>
        <paletteEntry value="0" alpha="255" label="0" color="#2dd2e7"/>
        <paletteEntry value="1" alpha="255" label="1" color="#8999e8"/>
        <paletteEntry value="2" alpha="255" label="2" color="#db5ce9"/>
        <paletteEntry value="3" alpha="255" label="3" color="#61e16a"/>
        <paletteEntry value="4" alpha="255" label="4" color="#65d13b"/>
        <paletteEntry value="5" alpha="255" label="5" color="#dc578c"/>
        <paletteEntry value="6" alpha="255" label="6" color="#76e0c7"/>
        <paletteEntry value="7" alpha="255" label="7" color="#d9dc1f"/>
        <paletteEntry value="8" alpha="255" label="8" color="#9340d7"/>
        <paletteEntry value="9" alpha="255" label="9" color="#da8a65"/>
        <paletteEntry value="10" alpha="255" label="10" color="#e63941"/>
        <paletteEntry value="11" alpha="255" label="11" color="#78d9a1"/>
        <paletteEntry value="12" alpha="255" label="12" color="#9bcd45"/>
        <paletteEntry value="13" alpha="255" label="13" color="#856ee0"/>
        <paletteEntry value="14" alpha="255" label="14" color="#d04fb0"/>
        <paletteEntry value="15" alpha="255" label="15" color="#d7a032"/>
      </colorPalette>
      <colorramp name="[source]" type="randomcolors"/>
    </rasterrenderer>
    <brightnesscontrast contrast="0" brightness="0"/>
    <huesaturation colorizeOn="0" colorizeStrength="100" colorizeRed="255" grayscaleMode="0" colorizeGreen="128" saturation="0" colorizeBlue="128"/>
    <rasterresampler maxOversampling="2"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>

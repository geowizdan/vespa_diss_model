<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" hasScaleBasedVisibilityFlag="0" version="3.4.15-Madeira" minScale="1e+08" styleCategories="AllStyleCategories">
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
    <rasterrenderer opacity="1" alphaBand="-1" band="4" type="paletted">
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
        <paletteEntry value="-1" color="#3786cf" alpha="255" label="Unmanaged"/>
        <paletteEntry value="0" color="#2dd2e7" alpha="255" label="Agriculture"/>
        <paletteEntry value="1" color="#8999e8" alpha="255" label="Agriculture"/>
        <paletteEntry value="2" color="#db5ce9" alpha="255" label="Agriculture"/>
        <paletteEntry value="3" color="#61e16a" alpha="255" label="Agriculture"/>
        <paletteEntry value="4" color="#65d13b" alpha="255" label="Agriculture"/>
        <paletteEntry value="5" color="#dc578c" alpha="255" label="Agriculture"/>
        <paletteEntry value="6" color="#76e0c7" alpha="255" label="Agriculture"/>
        <paletteEntry value="7" color="#d9dc1f" alpha="255" label="Forest"/>
        <paletteEntry value="8" color="#9340d7" alpha="255" label="Forest"/>
        <paletteEntry value="9" color="#da8a65" alpha="255" label="Forest"/>
        <paletteEntry value="10" color="#e63941" alpha="255" label="Forest"/>
        <paletteEntry value="11" color="#78d9a1" alpha="255" label="Forest"/>
        <paletteEntry value="12" color="#9bcd45" alpha="255" label="Forest"/>
        <paletteEntry value="13" color="#856ee0" alpha="255" label="Agriculture"/>
        <paletteEntry value="14" color="#d04fb0" alpha="255" label="Agriculture"/>
        <paletteEntry value="15" color="#d7a032" alpha="255" label="Urban"/>
      </colorPalette>
      <colorramp name="[source]" type="randomcolors"/>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0"/>
    <huesaturation grayscaleMode="0" colorizeOn="0" colorizeBlue="128" saturation="0" colorizeRed="255" colorizeStrength="100" colorizeGreen="128"/>
    <rasterresampler maxOversampling="2"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>

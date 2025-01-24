import { Controller } from "@hotwired/stimulus"
import "leaflet"
import "leaflet-providers"
import "@geoman-io/leaflet-geoman-free"

// Connects to data-controller="map"
export default class extends Controller {

  static targets = ["shape", "output"]
  static values = { shape: String }

  connect(){
    var map = L.map('map').setView([45.81, -0.78], 10);

    map.pm.setLang("fr");
    map.pm.setGlobalOptions({ pinning: true, snappable: true });

    map.pm.addControls({  
      position: 'topleft',  
      drawCircleMarker: false,
      rotateMode: false,
    });

    L.tileLayer('https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png', {
      maxZoom: 20,
      attribution: '&copy; OpenStreetMap France | &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    var geojsonFeature = this.shapeTarget.value;
    console.log(geojsonFeature);

    L.geoJSON(geojsonFeature).addTo(map);

    map.on("pm:create", (e) => {
      var fg = map.pm.getGeomanDrawLayers(true);
      console.log(e);
      console.log(fg.toGeoJSON());
      this.outputTarget.textContent = JSON.stringify(fg.toGeoJSON());
    });
  }

  disconnect(){
    this.map.remove()
  }
}

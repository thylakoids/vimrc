Measurement
===========

TODO:
* measurementData structure



Retrieve Measurement
--------------------

``` js
//viewer.js
this.measurementApi.retrieveMeasurements(PatientID, [
  currentTimepointId,
]);

//handleStructureReport.js
const part10SRArrayBuffer = await dicomWeb.retrieveInstance(options);
const displaySets = getAllDisplaySets(studies);
const measurementsData = parseDicomStructuredReport(
  part10SRArrayBuffer,
  displaySets
);
return measurementsData;

//MeasurementApi.js
this.addMeasurement(toolType, measurement);
```

Stow Measurement
------------------
``` js
//MeasureMentApi.js
storeFn(measurementData, filter, server)

//dataExchange.js
await stowSRFromMeasurements(measurementData, serverUrl)

//handleStructureReport.js
const { dataset } = parseMeasurementsData(measurements);
```

dcmjs
-----
``` js
Object.keys(dcmjs.adapters.Cornerstone)
[
  'Length',
  'Freehand',
  'Bidirectional',
  'EllipticalRoi',
  'ArrowAnnotate',
  'MeasurementReport',
  'Segmentation'
]
```


Chapter 4 – DICOM Objects
=========================
[DICOM Standard Browser](https://dicom.innolitics.com/ciods)

The DICOM Data Model
------------------

All DICOM Objects must include the SOP Common Module and modules from the four
main IE’s: Patient, Study, Series and Image (Image and Instance are the same in
DICOM. Once there were only images but then objects that are not images has
been defined and the name thus changed from Image to Instance in order to
represent an instance of a SOP class). All DICOM Images, that is DICOM
Instances that Are Images, must include the Image Module.

IOD - Modules - elements


Element Types
---------------------------
* U: User optional
* M: Mandatory
* 1: Mandatory with actual value
* 2: Mandatory that can be null(zero length)
* 3: Optional
* 1c: mandatory if some condition
* 2c: ...


Unique Identifiers(UID's)
--------------------------

Every entity in the DICOM Data Model also has a UID with the exception of the
patient. Patients are identified using the combination of their name and ID.
Studies, Series, all have UID’s.

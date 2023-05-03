# imag3View4
A fast & simple image viewer to integrate into context menu/shell

<img width="236" alt="Clipboarder 2022 11 11" src="https://user-images.githubusercontent.com/62726599/201299867-2456136d-e049-4127-b301-9cb64f22cffb.png">
<img width="236" src="https://user-images.githubusercontent.com/62726599/235603422-acbcf625-ac1a-4dc7-9785-5f764dbc164f.jpg">
Features,
alpha transparency support/visualisation options
alphachannel intact.
colour options
rotation options
brightness options 
copy/save not fully implemented
somehwere around 40ms to load and display a full screen png from disk
extremely small memory impact, around 10-40 mb at 4k after viewing 100 images


optionally rescale keeping pixel ratio whole

UI band.

mouse movable

relative centering position anchoring working when viewing consecutive images (mouse wheel up down to increment and decrement through the surrounding image files (optionally recusive*))

20fixed ; bug: opening filename with similarly named folder under the initial location, containing a simillarly named filename not being needled correctly.

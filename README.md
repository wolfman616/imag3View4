# imag3View4
A fast & simple image viewer to integrate into context menu/shell

<img width="236" alt="Clipboarder 2022 11 11" src="https://user-images.githubusercontent.com/62726599/201299867-2456136d-e049-4127-b301-9cb64f22cffb.png">

Features,
somehwere around 40ms to load and display a full screen png from disk
extremely small memory impact, around 10-40 mb at 4k after viewing 100 images

alphachannel intact.

optionally rescale keeping pixel ratio whole

UI band.

mouse movable

relative centering position anchor when viewing consecutive images (mouse wheel up down to increment and decrement through the surrounding image files (optionally recusive*))

; bug: relative repositioning; mental blank on way to implement anchor correctly for 1> repeted adjustments to the offset,  works off the centre being percieved initation point pre offset doesnt help.

fixed ; bug: opening filename with similarly named folder under the initial location, containing a simillarly named filename not being needled correctly.

# Getting started

This repository mostly serves as a fascade for the [std-avr-gcc](https://github.com/DolphinGui/std-avr-gcc)
repository, and as such most contributions should go there. There is also the
[ArduinoCore-avr](https://github.com/DolphinGui/ArduinoCore-avr) repository, which
is a lightly modified fork of the Arduino repository.

## Getting started with toolchain development

For building GCC, I highly recommend building GCC locally or in a container to reuse
build cache to avoid long compile times. The code for GCC is hosted on the
avr-except branch of [gcc](https://github.com/DolphinGui/gcc/tree/avr-except)
on my own account. This code is then made into a patch using create-patches.sh,
and then the patch is copied into the std-avr-gcc repo. The same is done with
[binutils](https://github.com/DolphinGui/binutils), because certain modifications
to the linker script were also necessary.

After that, rebuild [avr-libc](https://github.com/DolphinGui/avr-libc/) (which also
has certain modifications) and install it.

After using the build scripts in std-avr-gcc to build everything, copy the prefix root
into ~/.arduino15/packages/stdarduino/tools/avr-gcc/\[VERSION\] in order to copy the changes
into arduino. Alternatively you could also specify the install location to be directly inside
of the arduino directory. At this point, you would have successfully built and installed a custom
toolchain for arduino on your own.

## Debugging

Usually for debugging, I use simavr with avr-gdb. You could use a physical debugger along with
a development board, but for pure software cases where the bug has nothing to do with hardware,
a simulator and debugger by itself suffices.

## Contributing

Please direct any changes towards the relevant repository. Pull requests and issues are welcome.

### Future areas of improvement

Right now exceptions don't work. I'm not really sure why, but if somebody is willing to try, use the
0.8.4 version of the avr-gcc toolchain to try to figure it out. For some reason `free()` is being called
with -6 for some reason last I tried debugging it? I suspect that particular case was due to a bug in the
unwind code, although I'm not sure where it would be.

If at any point anybody feels like financially contributing it would become worthwhile to
put builds onto CI instead of doing it locally. This would speed up build times and improve
reproducibility.

Several functions in avr-libc need to be tagged with `__attribute__(__noexcept__)` to reduce binary
size. Exception lookup speeds can also probably be sped up by sorting the sections and then
using binary search to search exception tables, but that's something I'll get to later.



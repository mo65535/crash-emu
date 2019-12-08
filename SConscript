Import('env')

sources = [
    './src/poc.S',
]

obj = env.Object(
    source=sources,
)

bin = env.Command(
    'crash-emu-nocheck.bin',
    obj,
    '$LINK -Ttext 0 --oformat binary -o $TARGET $SOURCE'
 )

# TODO: make a scons tool
fixed_bin = env.Command(
    'crash-emu.bin',
    bin,
    '$PYTHON ./tools/checksum.py --out $TARGET $SOURCE',
)

Return('fixed_bin')


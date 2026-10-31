set -ex

# Compile and run a client without requiring a print server.
cat > client.c <<'EOF'
#include <cups/cups.h>
#include <string.h>

int main(void) {
    cups_option_t *options = NULL;
    int count = cupsAddOption("media", "A4", 0, &options);
    const char *media = cupsGetOption("media", count, options);
    int result = !media || strcmp(media, "A4");
    cupsFreeOptions(count, options);
    return result;
}
EOF

${CC} ${CFLAGS} client.c ${LDFLAGS} $(pkg-config --cflags --libs cups) -o client
./client

#!/usr/bin/env bash
# Solution from: https://askubuntu.com/questions/778100/how-to-install-compile-nvenc-in-ubuntu
# Additional info: https://it.toolbox.com/blogs/jeffhoogland/howto-obs-with-nvenc-support-on-ubuntu-linux-071117

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/compile/ffmpeg-nvenc.sh"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"

SOURCES_DIR="/tmp/ffmpeg_sources"
BUILD_DIR="/tmp/ffmpeg_build"


prompt()
{
    echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"
    echo "$CLR_RED""$CLR_BOLD""WARNING$CLR_RESET"", this is a fairly intesive process that requires the following in order to succeed:"
    echo -e "\n  - An Nvidia graphics card with the correct proprietary drivers installed"
    echo "  - An active internet connection"
    echo "  - git"
    echo "  - make"
    echo -e "  - A heck-ton of other dependencies needed to build ffmpeg from scratch\n"

    read -rp "$CLR_YELLOW""Without these prerequisites, this task$CLR_BOLD WILL$CLR_RESET""$CLR_YELLOW fail. I hope you know what you're doing... (y/n) $CLR_RESET" answer

    if [[ $answer != "y" ]] && [[ $answer != "Y" ]]; then
        echo -e "----------$CLR_RED User Aborted $CLR_RESET----------\n"
        exit 1
    fi

    rm -rf "$SOURCES_DIR"
    rm -rf "$BUILD_DIR"

    mkdir -p "$SOURCES_DIR"
    mkdir -p "$BUILD_DIR"

    install_dependencies
    install_nv_codec_headers
    compile_manual_rependencies
    compile_ffmpeg

    echo -e 'Finished! moving compiled ffmpeg to ~/.local/bin'
    mkdir -p ~/.local/bin
    [[ -f ~/.local/bin/ffmpeg ]] && mv ~/.local/bin/ffmpeg ~/.local/bin/ffmpeg-old
    cp /tmp/bin/ffmpeg ~/.local/bin 

    echo -e "----------$CLR_GREEN Success $CLR_RESET----------\n"
}

install_dependencies()
{
    echo "Installing a heck-ton of dependencies, hang in there."
    sudo apt-get update -qq && sudo apt-get -y install \
        autoconf \
        automake \
        build-essential \
        cmake \
        git \
        git-core \
        libass-dev \
        libfdk-aac-dev \
        libfreetype6-dev \
        libmp3lame-dev \
        libnuma-dev \
        libopus-dev \
        libsdl2-dev \
        libtool \
        libva-dev \
        libvdpau-dev \
        libvorbis-dev \
        libvpx-dev \
        libx264-dev \
        libx265-dev \
        libxcb1-dev \
        libxcb-shm0-dev \
        libxcb-xfixes0-dev \
        make \
        pkg-config \
        texinfo \
        wget \
        zlib1g-dev
}

install_nv_codec_headers()
{
    echo "Cloning nv-codec-headers from https://git.videolan.org/git/ffmpeg/nv-codec-headers.git"
    mkdir "/tmp/nv-codec-headers_build" && cd "/tmp/nv-codec-headers_build"
    git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
    cd nv-codec-headers

    echo "Building nv-codec-headers"
    make && sudo make install
}

compile_manual_rependencies()
{
    # NASM
    echo "Manually compiling NASM from source"
    cd "$SOURCES_DIR" && \
        wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.bz2 && \
        tar xjvf nasm-2.13.03.tar.bz2 && \
        cd nasm-2.13.03 && \
        ./autogen.sh && \
        PATH="/tmp/bin:$PATH" ./configure --prefix="$BUILD_DIR" --bindir="/tmp/bin" && \
        make && \
        make install

    # libaom
    echo "Manually compiling libaom from source"
    cd "$SOURCES_DIR" && \
        git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom && \
        mkdir aom_build && \
        cd aom_build && \
        PATH="/tmp/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$BUILD_DIR" -DENABLE_SHARED=off -DENABLE_NASM=on ../aom && \
        PATH="/tmp/bin:$PATH" make && \
        make install
}

compile_ffmpeg()
{
    echo "$CLR_CYAN""And now for the grand finale... Compiling FFMPEG with NVENC.$CLR_RESET"
    cd /tmp/ffmpeg_sources && \
        wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
        tar xjvf ffmpeg-snapshot.tar.bz2 && \
        cd ffmpeg && \
        PATH="/tmp/bin:$PATH" PKG_CONFIG_PATH="$SOURCES_DIR/lib/pkgconfig" ./configure \
        --prefix="$SOURCES_DIR" \
        --pkg-config-flags="--static" \
        --extra-cflags="-I$SOURCES_DIR/include" \
        --extra-ldflags="-L$SOURCES_DIR/lib" \
        --extra-libs="-lpthread -lm" \
        --bindir="/tmp/bin" \
        --disable-x86asm \
        --enable-gpl \
        --enable-libaom \
        --enable-libass \
        --enable-libfdk-aac \
        --enable-libfreetype \
        --enable-libmp3lame \
        --enable-libopus \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libx264 \
        --enable-libx265 \
        --enable-nonfree && \
        PATH="/tmp/bin:$PATH" make && \
        make install && \
        hash -r

    echo "You must re-source your current shell in order for the changes to take effect."
}

prompt

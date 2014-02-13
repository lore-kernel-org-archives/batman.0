Return-Path: <konstantin.pribluda@gmail.com>
MIME-Version: 1.0
Date: Thu, 13 Feb 2014 15:15:54 +0100
Message-ID: <CANcKu40YtXgXGSiPnPo9biG=auHFqKNRA3G0WNy3E2MYWyqiNg@mail.gmail.com>
From: Konstantin Pribluda <konstantin.pribluda@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Problem compiling batman for openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi all,

I try to compile  2013.4 against trunk of openwrt,  and habe problem
with batctl:
----------------------%<-------------------
CPPFLAGS="-I/home/ko5tik/openwrt/staging_dir/target-mips_34kc_uClibc-0.9.33.2/usr/include
-I/home/ko5tik/openwrt/staging_dir/target-mips_34kc_uClibc-0.9.33.2/include
-I/home/ko5tik/openwrt/staging_dir/toolchain-mips_34kc_gcc-4.6-linaro_uClibc-0.9.33.2/usr/include
-I/home/ko5tik/openwrt/staging_dir/toolchain-mips_34kc_gcc-4.6-linaro_uClibc-0.9.33.2/include"
CFLAGS="-Os -pipe -mno-branch-likely -mips32r2 -mtune=34kc
-fno-caller-saves -fhonour-copts -Wno-error=unused-but-set-variable
-msoft-float -ffunction-sections -fdata-sections -flto"
LDFLAGS="-L/home/ko5tik/openwrt/staging_dir/target-mips_34kc_uClibc-0.9.33.2/usr/lib
-L/home/ko5tik/openwrt/staging_dir/target-mips_34kc_uClibc-0.9.33.2/lib
-L/home/ko5tik/openwrt/staging_dir/toolchain-mips_34kc_gcc-4.6-linaro_uClibc-0.9.33.2/usr/lib
-L/home/ko5tik/openwrt/staging_dir/toolchain-mips_34kc_gcc-4.6-linaro_uClibc-0.9.33.2/lib
-Wl,--gc-sections -fuse-linker-plugin" make -C
/home/ko5tik/openwrt/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-adv/batctl-2013.4.0
REVISION="" CC="mips-openwrt-linux-uclibc-gcc"
DESTDIR="/home/ko5tik/openwrt/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-adv/batman-adv-2013.4.0/ipkg-install"
batctl install
make[4]: Entering directory
`/home/ko5tik/openwrt/build_dir/target-mips_34kc_uClibc-0.9.33.2/batman-adv/batctl-2013.4.0'
mips-openwrt-linux-uclibc-gcc
-L/home/ko5tik/openwrt/staging_dir/target-mips_34kc_uClibc-0.9.33.2/usr/lib
-L/home/ko5tik/openwrt/staging_dir/target-mips_34kc_uClibc-0.9.33.2/lib
-L/home/ko5tik/openwrt/staging_dir/toolchain-mips_34kc_gcc-4.6-linaro_uClibc-0.9.33.2/usr/lib
-L/home/ko5tik/openwrt/staging_dir/toolchain-mips_34kc_gcc-4.6-linaro_uClibc-0.9.33.2/lib
-Wl,--gc-sections -fuse-linker-plugin  main.o bat-hosts.o functions.o
sys.o debug.o ping.o traceroute.o tcpdump.o hash.o vis.o debugfs.o
ioctl.o list-batman.o translate.o -lm -o batctl
/tmp/ccSxljUB.s: Assembler messages:
/tmp/ccSxljUB.s:3002: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccSxljUB.s:3018: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccSxljUB.s:3117: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccSxljUB.s:3141: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccSxljUB.s:3151: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccSxljUB.s:3205: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccSxljUB.s:3242: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccSxljUB.s:3298: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccSxljUB.s:3314: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccuGt0iL.s: Assembler messages:
/tmp/ccuGt0iL.s:666: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:677: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:736: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:752: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:775: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:838: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:859: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:876: Error: opcode not supported on this processor:
mips1 (mips1) `ext $3,$3,24,4'
/tmp/ccuGt0iL.s:880: Warning: Macro instruction expanded into multiple
instructions
/tmp/ccuGt0iL.s:909: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:941: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:945: Warning: Macro instruction expanded into multiple
instructions
/tmp/ccuGt0iL.s:971: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:975: Warning: Macro instruction expanded into multiple
instructions
/tmp/ccuGt0iL.s:1004: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1032: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1063: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1083: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1091: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,28,4'
/tmp/ccuGt0iL.s:1098: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1116: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1249: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1278: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1294: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1317: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1356: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1373: Error: opcode not supported on this processor:
mips1 (mips1) `ext $3,$3,24,4'
/tmp/ccuGt0iL.s:1377: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccuGt0iL.s:1411: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1415: Warning: Macro instruction expanded into
multiple instructions
/tmp/ccuGt0iL.s:1440: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
/tmp/ccuGt0iL.s:1472: Error: opcode not supported on this processor:
mips1 (mips1) `ext $2,$2,24,4'
lto-wrapper: mips-openwrt-linux-uclibc-gcc returned 1 exit status
/home/ko5tik/openwrt/staging_dir/toolchain-mips_34kc_gcc-4.6-linaro_uClibc-0.9.33.2/lib/gcc/mips-openwrt-linux-uclibc/4.6.4/../../../../mips-openwrt-linux-uclibc/bin/ld:
lto-wrapper failed
---------------------------%<-------------------------------------------

Adding ARCH=...  to build comman in Makefile:

MAKE_BATCTL_ARGS += \
        REVISION="" \
        CC="$(TARGET_CC)" \
        ARCH="$(LINUX_KARCH)" \
        DESTDIR="$(PKG_INSTALL_DIR)" \
        batctl install


does not help.    Do I miss something?


regards,

----[ Konstantin Pribluda http://www.pribluda.de ]----------------
JTec quality components: http://www.pribluda.de/projects/

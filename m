Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1429023208.9533.12.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 14 Apr 2015 16:53:28 +0200
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] gateway_common.c:47:3: error: implicit declaration
 of function 'strnicmp'
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

Hi all

Sorry if this is something You already know.

I'm on 16b4833 and try to compile the module

LANG=C make \
CONFIG_BATMAN_ADV_DEBUG=n \
CONFIG_BATMAN_ADV_BLA=y \
CONFIG_BATMAN_ADV_DAT=y \
CONFIG_BATMAN_ADV_NC=y \
CONFIG_BATMAN_ADV_MCAST=y \
KERNELPATH=/usr/src/linux-4.0.0-gentoo

and got this:

  CC [M]  /usr/src/batman-adv/gateway_common.o
/usr/src/batman-adv/gateway_common.c: In function
'batadv_parse_gw_bandwidth':
/usr/src/batman-adv/gateway_common.c:47:3: error: implicit declaration
of function 'strnicmp' [-Werror=implicit-function-declaration]
   if (strnicmp(tmp_ptr, "mbit", 4) == 0)
   ^
cc1: some warnings being treated as errors
scripts/Makefile.build:258: recipe for target
'/usr/src/batman-adv/gateway_common.o' failed
make[2]: *** [/usr/src/batman-adv/gateway_common.o] Error 1
Makefile:1390: recipe for target '_module_/usr/src/batman-adv' failed
make[1]: *** [_module_/usr/src/batman-adv] Error 2
make[1]: Leaving directory '/usr/src/linux-4.0.0-gentoo'
Makefile:53: recipe for target 'all' failed
make: *** [all] Error 2

the kernel is already compiled with this config

$ grep BATMAN .config
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set

there was no error

also there was no error in March with 3.19.2

Again, thanx for Batman-adv

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –















debug information:

# LANG=C gcc -v
Using built-in specs.
COLLECT_GCC=/usr/x86_64-pc-linux-gnu/gcc-bin/4.8.4/gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-pc-linux-gnu/4.8.4/lto-wrapper
Target: x86_64-pc-linux-gnu
Configured
with: /var/tmp/portage/sys-devel/gcc-4.8.4/work/gcc-4.8.4/configure
--host=x86_64-pc-linux-gnu --build=x86_64-pc-linux-gnu --prefix=/usr
--bindir=/usr/x86_64-pc-linux-gnu/gcc-bin/4.8.4
--includedir=/usr/lib/gcc/x86_64-pc-linux-gnu/4.8.4/include
--datadir=/usr/share/gcc-data/x86_64-pc-linux-gnu/4.8.4
--mandir=/usr/share/gcc-data/x86_64-pc-linux-gnu/4.8.4/man
--infodir=/usr/share/gcc-data/x86_64-pc-linux-gnu/4.8.4/info
--with-gxx-include-dir=/usr/lib/gcc/x86_64-pc-linux-gnu/4.8.4/include/g
++-v4 --with-python-dir=/share/gcc-data/x86_64-pc-linux-gnu/4.8.4/python
--enable-languages=c,c++,fortran --enable-obsolete --enable-secureplt
--disable-werror --with-system-zlib --enable-nls
--without-included-gettext --enable-checking=release
--with-bugurl=https://bugs.gentoo.org/ --with-pkgversion='Gentoo 4.8.4
p1.4, pie-0.6.1' --enable-libstdcxx-time --enable-shared
--enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu
--enable-multilib --with-multilib-list=m32,m64 --disable-altivec
--disable-fixed-point --enable-targets=all --disable-libgcj
--enable-libgomp --disable-libmudflap --disable-libssp --enable-lto
--without-cloog --enable-libsanitizer
Thread model: posix
gcc version 4.8.4 (Gentoo 4.8.4 p1.4, pie-0.6.1) 


# /lib64/libc-2.20.so 
GNU C Library (Gentoo 2.20-r2 p4) stable release version 2.20, by Roland
McGrath et al.
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 4.8.3.
Available extensions:
	C stubs add-on version 2.1.2
	crypt add-on version 2.1 by Michael Glad and others
	GNU Libidn by Simon Josefsson
	Native POSIX Threads Library by Ulrich Drepper et al
	BIND-8.2.3-T5B
libc ABIs: UNIQUE IFUNC



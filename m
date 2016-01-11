Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 Jan 2016 11:03:51 +0100
Message-ID: <6156489.uHiVaphWnp@sven-edge>
In-Reply-To: <CAJuY50wv1F1OcJc-ne=JJB3xyLUMBVf=Uo8w36rM07vntXj=cQ@mail.gmail.com>
References: <CAJuY50wv1F1OcJc-ne=JJB3xyLUMBVf=Uo8w36rM07vntXj=cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4908917.MeCGboOY1Y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred dies without any log/dmesg entry
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
Cc: 3zl Trizonelabs <trizonelabs@gmail.com>

--nextPart4908917.MeCGboOY1Y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 30 December 2015 13:32:39 3zl Trizonelabs wrote:
> ref: alfred ver 2015.1 / .2 @openwrt CC
> 
> afred.facters disabled
> 
> alfred process dies (not listed in ps ) without leaving any log entry
> 
> does anybody have any hint or idea ?

I don't use the new OpenWrt init scripts and therefore hoped that one of the 
authors would answer here.

But maybe it is an alfred crash. You can try to find more about the reasons of 
a crash by enabling core dumps [1]. I think the netifd init script should then 
enable the rest ("ulimit -c unlimited" and setting 
/proc/sys/kernel/core_pattern).

You should then check /tmp for *.core files when you've detected that alfred 
isn't running anymore. If you find some from the alfred process then you can 
assume that there was some crash. You can analyze these core dumps as 
described in the OpenWrt wiki [2]. Just specify the core file instead of 
"192.168.1.1:9000" as the first parameter for ./scripts/remote-gdb. 

You may also want to change the alfred/Makefile before compiling your image to 
make debugging easier. Try replacing the lines

    TARGET_CFLAGS  += -ffunction-sections -fdata-sections -flto
    TARGET_LDFLAGS += -Wl,--gc-sections -fuse-linker-plugin

With

    TARGET_CFLAGS += -ggdb3 -O0

to make the output of things like "bt full" in remote-gdb a lot better to 
read.

Kind regards,
	Sven

[1] OpenWrt config: CONFIG_KERNEL_ELF_CORE=y
    under "Global build settings" as "Enable process core dump support"
[2] https://wiki.openwrt.org/doc/devel/gdb
--nextPart4908917.MeCGboOY1Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWk34HAAoJEF2HCgfBJntGRhEP/iM2SqBITICo6S1lvYNwXG+d
9iK+3ogdpGIF6+s/Q89GayVkaXQTo7tIgdBiEXkG8gU7B3F+OtjRKahOJxi3tNzN
uCXyn5WDdv+U9MNQQca/PtA++7zORFeHCqO/rXVUmgh02ZgSWcTpEGJuV1wRzT6c
GwlyhBChL9Awv5U35WyrHrPHRZjO7xmHlYekCadADE3lGnbOEaaQL5UQ/Lz7o3q9
ytQctui4CH4xOPu+i2+OGAIw25WCbUGgtMecm6SwY90ZaliuXRyxzAEJbS9BkZDR
dXWyTEvdhXeLdwYr98gDxv2fNjeMwrgSsS0mUQGX1oja+hEBzj+jyj1VWsuHOshW
trvjhxn2yljStXzoIbkVyVvPDDtCbNdqaK3SSvh++xFmE3Z7LzVpGNPIG9pWosZN
7/m+BAIkGX5ojE4K7s/k2hB+uBmI1eAgHc7q0Xnn5aHBlK8l2V5xhuoh9D0oeXun
44otbnairoUu5TdHjgL1+DLvBTPd90R0LDZ8xV0OlaQan4IZFj8u7/h4/rP0LEcI
BC0+PQdVpwrI7MqyNpp0RSC7BLYOvIKbdmB79AHY2kts1egojqmGeZNal5UhWapS
fFA1nrJOL3Itvo3YsIJcpGbOJ3A8UZYTO2TltMSvlNf1jW0JPph8J8HlPVmlvJIg
akU3zPlSXvvGsMqb2een
=FXKV
-----END PGP SIGNATURE-----

--nextPart4908917.MeCGboOY1Y--


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 18 Apr 2015 09:43:06 +0200
Message-ID: <109951125.NvYEQkeGZQ@sven-edge>
In-Reply-To: <1429023208.9533.12.camel@gmail.com>
References: <1429023208.9533.12.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8824769.NcKzJ4nAjK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] gateway_common.c:47:3: error: implicit
	declaration of function 'strnicmp'
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


--nextPart8824769.NcKzJ4nAjK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 14 April 2015 16:53:28 Philipp Psurek wrote:
[...]
> I'm on 16b4833 and try to compile the module
> 
[...]
> 
>   CC [M]  /usr/src/batman-adv/gateway_common.o
> /usr/src/batman-adv/gateway_common.c: In function
> 'batadv_parse_gw_bandwidth':
> /usr/src/batman-adv/gateway_common.c:47:3: error: implicit declaration
> of function 'strnicmp' [-Werror=implicit-function-declaration]
>    if (strnicmp(tmp_ptr, "mbit", 4) == 0)
>    ^
> cc1: some warnings being treated as errors
[...]
> 
> also there was no error in March with 3.19.2

Please try the patches which bring batman-adv (nearly) to the same version as 
the current pre-Linux-4.1-rc1 version of batman-adv:

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012987.html
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012988.html
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012993.html
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012994.html
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012991.html
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012986.html

The first one is missing in your version to make the out-of-tree module 
compatible with Linux 4.0. The rest should not affect you.

Kind regards,
	Sven

--nextPart8824769.NcKzJ4nAjK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVMgsOAAoJEF2HCgfBJntGrkYQAJKs3Hf+2TprjVDsR9+byMpL
7f2mWgSvDBnyDTFVPZ3Cyq7Mx/1tTMjzCCdJeKY53VuZL7HkDTdReCfe245nUEzc
uCxy5bLTI2i/Ru0FE95pyAUoQiA7m0/mxUyiQgJIygLtItJTTly6ArDn4F5LxYr/
hxLrU9dCSZ8fYSs50MBUx/vtK5ZGxsBJ9iNimREj9Tycx9fIoUV41a2S6kIf3aud
IyRSlqhlURM2Ka9QUQmDY7mAwPen9wXQv3+l9+ZbwLfrlfgjGX5/gB3sj50yObfT
jltmriJS1xyOhxdC7JxiIY64fc53L8hXhbDtOhwakuOueIXWV33EJXJnarIgbXkL
510p6hpwa9YOycPztaHQ//L/XH2DA5rnW5s4oXxrdnwlMkaOI4GH9pMWb4mTf/Ex
tDd2nVkfSEoExRy4QP93sWNAAJLshDh6/fVR8ZjEONXM+uRClTTWWs2J55DJyqWG
s+NJa4AG/8bRrtAw0rsbFZecQxDZyUD2CehiMJRYnQNsxIBj7M49dgy+rbdnLr9V
5OTTjWkfbKOOGbn3fril7SZ1HtXrvJcPocO4r4mO5Dd1BNrAXoz+DgidAL6SEof4
huIQQKCAsRaIvYUsG959MeyY9gEeorJiaxZNgvr/hn5UHCUG/K27c3hjBntpXg9g
wdA7xF1w3hiRo1Uz27VR
=3DeU
-----END PGP SIGNATURE-----

--nextPart8824769.NcKzJ4nAjK--


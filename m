Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 May 2016 18:46:45 +0200
Message-ID: <5852435.LV6X2bqICk@sven-edge>
In-Reply-To: <bd9e8031919e41188957b3791a29d2d5@Ek.usurf.usu.edu>
References: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
 <1906308.Wsn34X6QAt@sven-edge>
 <bd9e8031919e41188957b3791a29d2d5@Ek.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26595324.IXTP17cBvr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Alfred 2016.1 bind errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart26595324.IXTP17cBvr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 May 2016 16:37:55 Jonathan Haws wrote:
[...]
> I am using the Yocto project to build my kernel/distro for my VMs, since
> that is what we use on our hardware.  Here is the output from those
> commands:
> 
> root@sierra1:~# ip link show dev bat0
> 6: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state
> UNKNOWN mode DEFAULT group default
>      link/ether f2:52:c3:50:2e:d7 brd ff:ff:ff:ff:ff:ff
> 
> root@sierra1:~# uname -a
> Linux sierra1 4.1.18-rt15-yocto-preempt-rt #1 SMP PREEMPT RT Wed May 4
> 23:15:13 MDT 2016 x86_64 GNU/Linux
> 
> My guess, per Matthias next email in the thread, is that IPv6 is
> required, which I believe is not built into my kernel.  I'll see about
> adding that and try again.

Yes, this looks like the problem and this is why I've asked for the output. 
The excellent answer from Matthias should be enough to fix your setup :)

Kind regards,
	Sven
--nextPart26595324.IXTP17cBvr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLhv1AAoJEF2HCgfBJntGzb4P/jwgk7WlV4Ly5dXoo9hAMbJs
HOnrbKiZ7Ir0hqwQjtWDUGuLNadrSQo9TIX8y5se6o/2moHZpXzY60IsDLfTeeWX
qHcp6xzYX3u3O5n31Sjrum0jyt76S8HWZ5y+EGpnie5iV2iIuWZMH52prsFsVx1c
3D1e4YZt4N1wQyKcxkPKRr7QGBSqK+9QfT1F9S0hsJCjyagD5mCTdeCZ+sjOtQmP
zSpd9jmvdBfZVTcU0+yqMejzfan98iCX4OG8LrA1WxVZQMWAijfJsKS7VRBqQEXu
hO3qeT5vObBI5FwAIPi+HeWn+MzsOgKuGMh+51YU0uf7KFhwPwgYBEsbDYwT2iDX
vVylk2DWfgPBcyjsTrDWsT7S2k1IUfvTLhx01LyTvI+Um+MhnEpD/q2TEVhL2TkR
Az+ySk0WxAI0LQ2fj9Gr9CGlaRyU1+1RqtZ11rsDMqDnPcAGNpvGu6RQyjaH4VrA
70xa66/VHZASKLXaaRmbDrt6HSCEkF3wMkQkzH1FEsyb4Gb2pXb8EtsUD1vXqp72
1QkUqV527NgbbBiAjdbDwJNqkw7s58J08aRCjqUIFjHINKQlpjhibf0w2thHIrdq
zmg8gQfsYY3Dcr1LgiXjDvHSugBgBCa0M2s7dA1ajP0k1CDIaG1Ox2y5mx5wz6rD
avsWjN9FWb0nTokk2PIS
=IxRh
-----END PGP SIGNATURE-----

--nextPart26595324.IXTP17cBvr--


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2016 22:50:20 +0200
Message-ID: <10164043.KPuzFIC6Pp@sven-edge>
In-Reply-To: <20160515124138.GI4375@otheros>
References: <20160514145129.GD4375@otheros> <20160515120626.GG4375@otheros>
 <20160515124138.GI4375@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart41811792.8NTTJnC3gm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
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

--nextPart41811792.8NTTJnC3gm
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 15 May 2016 14:41:38 Linus L=FCssing wrote:
> On Sun, May 15, 2016 at 02:06:26PM +0200, Linus L=FCssing wrote:
> > Ok, yes, that's what I had looked at yesterday, too.
>=20
> Btw., these were the results from slabinfo I got yesterday. The
> first one before applying the patches, the second one after:
>=20
> http://metameute.de/~tux/batman-adv/slablog/before/
> http://metameute.de/~tux/batman-adv/slablog/after/
>=20
> The first number is the number of lines from "batctl tg", second
> one the timestamp.

Hm, looks like the the biggest difference is in kmalloc-64. So this wou=
ld mean=20
that the kmalloc version uses 64 byte entries for tg entries. And the=20=

batadv_tt_global_cache version uses 192 bytes (so it has an even larger=
=20
overhead). The question is now - why?

My first guess was that you you are using ar71xx with MIPS_L1_CACHE_SHI=
FT =3D=3D=20
5. This would cause a cache_line_size() of 32. The tg object is 48 byte=
s on=20
ar71xx. So it looks like you are using a different architecture [1] bec=
ause=20
otherwise the (cache) alignment would also be 64 bytes. Maybe you have =
some=20
debug things enabled that cause the extra used bytes?

Extra debug information would also explain it why bridge_fdb_cache requ=
ires=20
128 bytes (cache aligned) per net_bridge_fdb_entry. I would have expect=
ed that=20
it is not using more than 64 bytes and is merged automatically together=
 with=20
something like kmalloc-64 (see __kmem_cache_alias for the code merging=20=

different kmem_caches).


Just some thoughts about the kmem_cache approach: We would only have a =
benefit=20
by using kmem_cache when we could have a objsize which is smaller than =
any=20
available slub/slab kmalloc-*. Otherwise slub/slab would automatically =
use a=20
good fitting, internal kmem_cache for everything.

Right now, the size of a tg entry on my system (ar71xx mips, amd64) wou=
ld have=20
a raw size of 48-80 bytes. These would end up at an objsize (cache line=
=20
aligned) of 64-96 bytes. On OpenWrt (ar71xx) it should be merged with=20=

kmalloc-64 and on Debian (amd64) it should be merged with kmalloc-96 (n=
ot=20
tested - but maybe it is important to mention that kmalloc-96 has an ob=
jsize=20
of 128 on my running system).

Kind regards,
=09Sven

[1] Yes, I saw the kvm and ACPI lines after I wrote this stuff. So you =
are
    most likely testing on some x86 system
--nextPart41811792.8NTTJnC3gm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOOEMAAoJEF2HCgfBJntGbykP/3B8jU+5RxuNKRFkJoC++zJ+
4W9QlnhoQSLQA7NkXzdy7wQeM7fK5kGURRzX6sozezH0/UolmAYFOSrkDL/aYLOb
vNVqJMMJoy8EesUSWEWjV8sRHenIfxXGkGfJWOYy9IcF/i6CoLEx9atoHiaoAtAS
pB+RrhMQozzAiJ6JiztC7XLhiDKCCxHonnWoMOt1t6KKYH1RmV3kmr0pNyZmUzz8
sUllZpT75MPFwD3Fk09U61PfYlGlx+UZvxxaL4INLQcRlL2CSc7J1ePXTvP4v2y5
fx6lUUP8o2AnyU0WqbxW1W4jXOolQsyqcVhUTU3mhTTyZ8TqSpTo9z0OQkBJOr8X
1GAmhvXbPZ2eVxQGLX7rAUvKWx+jpR0jYbRUR9ZTu9+aW/ZOoCRsajXSPLL2NQiI
/AltL61/yNCuifAd9c9QvQ4EmVEVuSIxOcVGBFJUzxSIJxLBmL3uee8Rx1u/4FSp
90LDNsUzcrmweIJBdwHqiWlYaFE2j8LFFz6lyPSIc+mHsPt05GBssCOXFiWWAq2k
xfMIXdqrxgppQU/1kBRIjFLPm7cBIyilDaHEXWVqwPex8Fj9mnVdZ7Y16ogaeQYQ
bIZ8jvyzFhzL/8cfssgU4nqYl3IQGdUMKbQT2I6g/ExSu8Jy4mACVY0cVk5SkScv
H3J8mGj6oBjCG5vGfyt9
=kXoM
-----END PGP SIGNATURE-----

--nextPart41811792.8NTTJnC3gm--


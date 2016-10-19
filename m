Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 19 Oct 2016 08:31:03 +0200
Message-ID: <9062705.AOdrQGRa4W@bentobox>
In-Reply-To: <20161018232239.GI6366@otheros>
References: <20161018212125.32010-1-linus.luessing@c0d3.blue>
 <1555062.TzeBilqSPn@sven-edge> <20161018232239.GI6366@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2588665.eusO3k0BuX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: Substitute compat
	code for netlink constification
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

--nextPart2588665.eusO3k0BuX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 19. Oktober 2016 01:22:39 CEST Linus L=FCssing wrote:
> On Tue, Oct 18, 2016 at 11:28:23PM +0200, Sven Eckelmann wrote:
> > Doesn't seem to scale. Especially when we think about batadv_netlink_ops
> > which should also be const. It is currently not const because of the
> > Linux <=3D 3.13 workaround.
>=20
> Hm, okay, batadv_netlink_ops is a little more tricky/larger, yes.
> What about a memcpy'ing approach with BUILD_BUG_ON()'s as
> safe-guards like this:

Yes, this would also be an idea. But I would personally just use the=20
coccinelle approach because it needs less extra hacks. Or do you have any=20
problems with coccinelle? My personal preferences are (at the moment):

1. code which doesn't need compat code
2. code which can supported with clean (not too hacky) compat-include
3. code which can be supported with coccinelle
4. code which can be supported with compat.h hacks
5. code which can be supported with small patches

The replace.sh was just a quick way to make sure we can ship 2016.4 without=
 to=20
many extra modifications.

Btw. this is right now only something for later. It is more important to ge=
t=20
your other changes in master. And also to get the patchwork queue smaller -=
 so=20
reviews are more than welcome.

Kind regards,
	Sven
--nextPart2588665.eusO3k0BuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBxMnAAoJEF2HCgfBJntG37YQAKAzk2/yrAF2uWGywY9c/6/A
zLWl80A07Tu4ZLO3WaslfVOomZD2FOFTzt3ZGqgClhiV3Gku2y0vLcOXLPHTYXZV
/b6CRH9vgdJft7FXPwBaz2WXVW9d2y/SUphQsQWTfxLO5DvV9Am4gx38EIBktvDh
YRTiaz1T2GVzArm16spWeKQzmYeAvbh8cICUSbQwDHDoXObU6PWnIgDpP3RscLJQ
VzwBkGoa0B/ThISewy1XH5aki7q0Sil6LolUDhg5inqDlVYTclsJwB3Dn814bp99
uquIy26lWUjGtiV9cGvD7M5hoFIXMfnXnKVyv4H48DwJUULMH+fxbmjWklC2HqQV
GAL7IKVW91et4I01VaBA2xCPUkiqPd3LJEziLhBZLI8GJ+4bsYUgh86+hMHkhW+9
509sUBK2wpt0Wm55JqceO1Mvl1cSEBHKi8BK6HCZ8ZDWYJrosnanLFzJB4Pt3bYa
pG1sSYnblZFJNw3jjrNxWQNNMJoA73FTlE4eFJmmVPIKkzIS3n12VSa1KVVp7x8w
P8sp3+rOxXRytFqvoLioeqJx6IUtau0UJlcMHzFRw61MrZq1IpUqvp0s96pKrXTR
VoGb6z/MF6WKilIydyBQXSiQzFWjzM/wOj6Ev6PQ4y5geXX8YI8lK6s2ZTaeIy6T
+dQ8LK9Nl99873xjfTIo
=W3+x
-----END PGP SIGNATURE-----

--nextPart2588665.eusO3k0BuX--


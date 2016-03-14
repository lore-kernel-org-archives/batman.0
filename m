Return-Path: <mschiffer@universe-factory.net>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-5-git-send-email-andrew@lunn.ch>
 <56DD8E53.3010904@universe-factory.net> <9919433.c4WuAskJuF@sven-edge>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56E69562.9050109@universe-factory.net>
Date: Mon, 14 Mar 2016 11:41:38 +0100
MIME-Version: 1.0
In-Reply-To: <9919433.c4WuAskJuF@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="m8fvfWq42vvOFuXGeP4WtDKDfjlHeM4PD"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
 support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m8fvfWq42vvOFuXGeP4WtDKDfjlHeM4PD
Content-Type: multipart/mixed; boundary="aHhNDKsfHnokxRIpixXt22uBfAGSP36DD"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <56E69562.9050109@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
 support
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-5-git-send-email-andrew@lunn.ch>
 <56DD8E53.3010904@universe-factory.net> <9919433.c4WuAskJuF@sven-edge>
In-Reply-To: <9919433.c4WuAskJuF@sven-edge>

--aHhNDKsfHnokxRIpixXt22uBfAGSP36DD
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/13/2016 10:12 AM, Sven Eckelmann wrote:
> On Monday 07 March 2016 15:21:07 Matthias Schiffer wrote:
> [...]
>> By the way, the netns support is another good reason to switch from th=
e
>> debugfs interfaces to a netlink-based interface (as the netlink interf=
ace
>> wouldn't need userspace applications like batctl to be aware of the
>> namespaces). I guess I should finally finish the patches I started wri=
ting
>> for that...
>=20
> So what is your suggestion here? Should the namespace support for names=
paces=20
> be rejected and you send in your netlink implementation patches? Or sho=
uld=20
> this patch be merged and be removed (together with the rest of the debu=
gfs=20
> stuff) when your netlink support is integrated?
>=20
> Kind regards,
> 	Sven
>=20


As my netlink patches need more work, I guess it would make sense for me =
to
rebase them onto the netns patchset.

At least the non-netns debugfs interface would need to continue being
supported for a while I guess. As you know, both Linus Torvalds and David=

are very strict about kernel ABI regressions, and I know that at least
Linus considers debugfs kernel ABI, so the same ABI stability guarantees =
as
for the rest of the kernel apply. This makes me think that the netns
support should not be merged into mainline until the netlink interface is=

done, so we don't add even more legacy interfaces.

I'll continue my work on the netlink patchset, I plan to send a v2 some
time this week.

Matthias


--aHhNDKsfHnokxRIpixXt22uBfAGSP36DD--

--m8fvfWq42vvOFuXGeP4WtDKDfjlHeM4PD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW5pViAAoJEBbvP2TLIB2cnD0P/2wlXioCOpREFK9/UI4w7NBP
ocXYiYF0QrmWuFgP+08XBt1EsNFHQOr9TxM9ATcjdxbU+H4Pkqt/L0ToKcCtaDSd
lnUhzzQ0yjM5oV5691OvxMBaDiBWgBfk39FUAdpkvkQKzZJoxiOFeXHI1WuQ7GBT
+JiTA11m3KG+A0R1J8oh2iiK+FlLt3AOLCfGNmbDnRF3AsMrTDKEcdBmMU96powR
zSCQKN1kt4UK66bY1De6Oc1Q8soOIahGVYPDraIiNvLm9gBXkuDRSh0ABgK3iRZm
SV5nXQ+yqHPIxr8E5CXx0tEnnJVXX4yI9ajxjdzXn+OWqYZ/+G+xLerPD53H30GE
fUuJBFCu3/kq5htHaNR9J0LZQV9qZWIffGfH6cAV6lOOS8EMXk0fWyfGo5s1XfAf
bDwd6EAeCGNqGtc/goSpFSL+LtKF03202q6VoJXQo2xepFxwNfbPKNDgL8haBwcP
rcWR5ACTIUzsZLOm68yjQQJ2vV64wruqzE24PpFUK503btWKG4sMI9JYJJ+N/sog
e6cO+9sAzyIYhB8+Hve4nokU0GYfZRNokA60H4NDKORmeCbsPBgTdXCRbheqcgv2
35RIlgD3BlT3ylIwEoxmUXCiaCUEyjj2iK4tWNUQ4/ews6/COfaLbeJK4YyJyVm/
8dSVxmsVvJ4hyQnk4T+S
=QKf6
-----END PGP SIGNATURE-----

--m8fvfWq42vvOFuXGeP4WtDKDfjlHeM4PD--

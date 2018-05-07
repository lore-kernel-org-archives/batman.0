Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 07 May 2018 08:34:16 +0200
Message-ID: <2078208.hARaRF5Zct@bentobox>
In-Reply-To: <20180327154307.GA2052@otheros>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161029105628.GE1692@nanopsycho.orion> <20180327154307.GA2052@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1919136.vZDWomlev3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
 mcast sysfs files to README
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Jiri Pirko <jiri@resnulli.us>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, netdev@vger.kernel.org, davem@davemloft.net

--nextPart1919136.vZDWomlev3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 27. M=E4rz 2018 17:43:08 CEST Linus L=FCssing wrote:
> On Sat, Oct 29, 2016 at 12:56:28PM +0200, Jiri Pirko wrote:
> > >> I strongly believe it is a huge mistake to use sysfs for things like
> > >> this. This should be done via generic netlink api.
> > >
> > >This doesn't change the problem that it is already that way. This patch
> > >only adds the list of available files to the README.
> >=20
> > Sure. Just found out you did it like that. Therefore I commented. I
> > suggest to rework the api to use genl entirely.
>=20
> Hi Jiri,
>=20
> Thanks for sharing your thoughts!
>=20
> Could you explain a bit more on which disadvantages you see in
> the usage of sysfs here?

Linus is asking because of following patch:=20
https://patchwork.open-mesh.org/patch/17340/

Kind regards,
	Sven
--nextPart1919136.vZDWomlev3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrv82gACgkQXYcKB8Em
e0bvSBAAzrpIyF7w4rJSYNTtIWjkaR66LtbpOQqHzr14ghYCBncgX5xeLNwcREl7
0g/lYmUhClq3lOMnWgd1AkrUN+h2p2gGQvciBw5qfopLyO04+LQB9JkTXEWJISXw
4cCF6mYpBStKN/HNXiI5sjNzWCZY+VOglNw85DGq5u6YBQBcxFvY6K7Lud1YPgpy
36DhRSBSlqzXipxtZfl8K0jmRGzzOW5K1/pMxAKANE5/cAUt1z5VCBjcxq9uVAtX
6f+UDhcEq0rlWG9X2nmtSjycHhTP2pMt/At/5nsUD4Jx6qQQFdfKT2n5EObymJ4l
ESxJPCeEsJ/QMjtjnUf4YPcXbjDqWcSDoRBD+Fg4zcTG/UQ36JcuiZWoUpYfjR0+
hiBhzMXxBa/3MM++2UZWErW1MoS4WSlNs4DmZ2W6r9QtWnHLsPTspUXYcBWddOKw
cXRCERgqnfz+6F6xXmCrUX9cwPR6hp+D2n8k8NQ0exr3U4QtlIAdgbH1pVYeSO+l
VCTdGOxoFPvS/p/F/hhENVVTo5TZHg8vIwXMw0/LPcLPpOWknOgpFzpOHm5USLHF
Bthq6UNvRzUjx1DU/d6ZrtxD1lGajEhaJ5k7M/fMWVR4uTCviK1easvIloz9cdJC
1VP0ewoXA+o7LhOgoWVe44eVYIVPf3JTm/N05BKju1+mt4oOxZo=
=ogIH
-----END PGP SIGNATURE-----

--nextPart1919136.vZDWomlev3--


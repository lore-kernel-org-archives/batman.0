Return-Path: <ruben@freifunk-nrw.de>
Date: Mon, 30 Mar 2015 21:27:26 +0200
From: Ruben Wisniewski <ruben@freifunk-nrw.de>
Message-ID: <20150330212726.46ff30c5@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/NUayR.Sv=Y/oJ8AyE8PjVDY"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] batman-adv: increased default hop penalty
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
Cc: Simon Wunderlich <simon@open-mesh.com>, felix@freifunk-nrw.de

--Sig_/NUayR.Sv=Y/oJ8AyE8PjVDY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Forwarded private message, on request by Simon.

On Friday 27 March 2015 16:52:14 Ruben Wisniewski wrote:
> Hello Simon,
>=20
>=20
> we just updated our mesh, to the batman-adv-version 2014.4. Now your
> patch batman-adv: increase default hop penalty[1] is included.
>=20
> Since we got very large mesh-networks, we have some troubles with your
> patch, which makes long (needed) pathes unusable, because they TQ drop
> to lower zero.
>=20
> Else, we got some old and some new batman-adv versions, this change
> overloads the old nodes, because their TQ are better, and similiar
> links over new nodes got ignored.
>=20
> Else I see no improvement overall, because the usual urban link-wide
> is about 30-50 meteres, and we got parts of the net where we need 4-5
> hops to reach the last node. Your Patch seem to limit these pathes to
> something around 3 hops. So parts of our net are now offline, and the
> speed overall doesn't seem to be improved.
>=20
> After these experience I like to ask you, if you mind reverting this
> patch again. Else we have to work around with resetting to 15 again on
> boot, which I think is not the prefered solution.
>=20
>=20
> [1]
> http://www.open-mesh.org/projects/batman-adv/repository/revisions/7644650=
bb7
> 66bd4c7b6be5d97e6b1c3ed93a38d7
>=20
>=20
> Best regards,
>=20
>=20
> Ruben =20

--Sig_/NUayR.Sv=Y/oJ8AyE8PjVDY
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iKAEARMKAAYFAlUZo54ACgkQgB++GrevraS/uAIIsHl7pQYFJ2MS2mppT5fTsbvH
enrjJZzmfNdxkHG37OwIixcyqVRPjYx2siGqKxxKpMlMYX7rlSh8bnwgqrbckbUC
CKrIzZrXrJ44wYpejTtBTWxSP3XFS3K2BjmGSFAIKI3DXUe7TFE/YBN+JbzuUxTZ
CSWrbOA9cRqf+S4raE0LaP6g
=eEGT
-----END PGP SIGNATURE-----

--Sig_/NUayR.Sv=Y/oJ8AyE8PjVDY--

Return-Path: <pau@dabax.net>
References: <20160725175212.GC2263@makrotopia.org>
From: Pau <pau@dabax.net>
Message-ID: <60020429-5aca-f377-5bde-a5c631fce66f@dabax.net>
Date: Sat, 6 Aug 2016 23:43:44 +0200
MIME-Version: 1.0
In-Reply-To: <20160725175212.GC2263@makrotopia.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k1CfnDTdR628P8ddcX40I7MrrMOrKSqL8"
Subject: Re: [B.A.T.M.A.N.] [lime-dev] bridge and batman-adv over ethernet
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: libre-mesh developement <dev@lists.libre-mesh.org>, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>, battlemesh@ml.ninux.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k1CfnDTdR628P8ddcX40I7MrrMOrKSqL8
Content-Type: multipart/mixed; boundary="ovFPLnnt7Dt1EOTHEBbnuJ69CP4jjSkeB"
From: Pau <pau@dabax.net>
To: libre-mesh developement <dev@lists.libre-mesh.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>,
 battlemesh@ml.ninux.org
Message-ID: <60020429-5aca-f377-5bde-a5c631fce66f@dabax.net>
Subject: Re: [lime-dev] bridge and batman-adv over ethernet
References: <20160725175212.GC2263@makrotopia.org>
In-Reply-To: <20160725175212.GC2263@makrotopia.org>

--ovFPLnnt7Dt1EOTHEBbnuJ69CP4jjSkeB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

It would be nice to have some update on this issue if possible.

Thank you!

On 25/07/16 19:52, Daniel Golle wrote:
> Hi!
>=20
> We are currently trying to use the Libre-Mesh.org firmware with
> batman-adv enabled on wired Ethernet interfaces alongside with a VLAN
> which is a member of the bridge the batX interface also resides in.
> ------------------------------
>  E |VLAN---batadv---bat0
>  T +--------------+ BRIDGE
>  H |VLAN------------eth0.xx
> ------------------------------
> We do want such a setup to have the best of both worlds: the
> performance of a plain bridge but yet benefit from batman-adv topology
> information, alfred and all that. As many cheap Ethernet switches do
> not support frames larger than 1500 bytes, increasing the MTU is not an=

> option and thus frames inside batman-adv end up fragmented which hurts
> performance if encapsulating all traffic via batman-adv.
>=20
> I remember there was a discussion during battlemesh about a race-
> condition which can confuse BLA and thus batman-adv is still disabled
> on wired Ethernet interfaces in Libre-Mesh by default.
> So here I am asking you about the current state of affairs regarding
> this issue.
> We are discussing it on
> https://github.com/libre-mesh/lime-packages/issues/56
> and it would be great to hear a more detailed summary because I only
> remember the rough details and also haven't been watching if anything
> was fixed or improved since we all met in Porto.
>=20
> Cheers
>=20
>=20
> Daniel
> _______________________________________________
> Dev mailing list
> Dev@lists.libre-mesh.org
> https://lists.libre-mesh.org/mailman/listinfo/dev
>=20

--=20
=2E/p4u


--ovFPLnnt7Dt1EOTHEBbnuJ69CP4jjSkeB--

--k1CfnDTdR628P8ddcX40I7MrrMOrKSqL8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXploQAAoJEAX7rWpc+YnN0yMH/1CUK8huZAhdQ+WbmgPFl+VM
lwwjbK5im7CA6P8mTdW7qoi67B6o6yC9Mb1uJGFtwnLKRGb6EBJbHtTo9IGtaKFU
GxQGhqGkK3oBSE/pFrgVP/Sb4U1vjIIOqJgBhm1rm+nF3u5minsX73OfpZtUI4q4
ciajhlZRNSjh1IrAZj3bMiRWDLHQvuZUm2QNYPMzPqnn9lBhKrpsy8l/fKcXap+E
OQOivKfLGTgdFrAzL0wMAK4cOInrUkHtEbRUILK4yd7+MDNi5nN6Vq2RYb+Y1BxH
laZRcoR/pmSoMBknee0tobS4EsWNO0MiSXZHloCE0BdyWhlXZ14caLpfgVy+Hi8=
=EvgE
-----END PGP SIGNATURE-----

--k1CfnDTdR628P8ddcX40I7MrrMOrKSqL8--

Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 May 2011 14:43:29 +0200
References: <1306572183-25950-1-git-send-email-sven@narfation.org>
	<201105281407.15153.sven@narfation.org>
	<201105281417.16069.lindner_marek@yahoo.de>
In-Reply-To: <201105281417.16069.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2756043.MV86UGrTEx";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105281443.35742.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH-marek] batman-adv: Unify the first 3
	bytes in each packet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2756043.MV86UGrTEx
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 May 2011 14:17:14 Marek Lindner wrote:
> On Saturday 28 May 2011 14:07:10 Sven Eckelmann wrote:
> > Why dont you use the reserverd part for the flags which are currently n=
ot
> > in unicast? Then you could also remove that other align byte. It would
> > still be possible to add flags to unicast packets when necessary.
>=20
> The unicast_frag header assumes it looks like the unicast header plus some
> extra fields:

Where does it assume that the frag is _not_ part of the unicast_packet head=
er?

>=20
> struct unicast_frag_packet {
> 	struct unicast_packet unicast_packet;
> 	uint8_t  flags;
> 	uint8_t  align;
> 	uint8_t  orig[6];
> 	uint16_t seqno;
> };
>=20
> We probably should add a little comment there to make that clear.
>=20
> Both reserved fields (unicast + unicast frag) are going to be converted to
> ttvn with the tt patches.

Ok, makes sense to use reserve fields then

Kind regards,
	Sven

--nextPart2756043.MV86UGrTEx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN4O31AAoJEF2HCgfBJntG7lAP/07waqAYwdUtpt580GOLQ7eO
l+p6AGGCPUbJuP5EOmLS2WrFiFMQwr/Qlc7If49Km6CQSlfkmZp97IOOlrdTwlKs
2ixg2ybVzPgli9oejF0mbMJz89vdNw3areRrHibD1gC0ahwZXaRp91qMZfvr+ESN
cK6dz/YJ7D2fizVSHI1lR6+0PmDbr5JTG6NlSTs/ZeKGlSRHFnpce9SPcyu2NB1b
WD++tx341IfJuGPjNuNId/eOPjPPxWVOqFqP0YaG0mPwxLhcM24mUI2p9ypSB3ls
Yqj2ZQU4f8RdsVjWqAUBOF8rcPlSWfWmta1VYdUQF+6S9zvF79mbXKxrUyGBUtFn
hdt1O5AR3Rq6CTd8HE3wrDqjWHwp4eFV7GSCUKPtyCgTFBdkbXqRb1Y8I6mWLupL
BlRAofKxiyacXhUi+5BjR01Eq7xvnNqygcGhmL5YGwTc5uHralx66U8JSP+BE7eg
PwXC7PQfaotnlPQ36kuWLF+8JOhgd72k4vb22ZeBdhzneNxuAJUQFtAgKaqLfY96
1Q3/rUFjQvJnc4rK/vVPLsvcmGnehN4L6xhZlF6ktY7cyN5HkMPXNBRVUuJk+MNu
AmAHdaRnW7h7ITWft64UnSKXV1HnuLCjh+5s3lHCsynzwng1uY1lJm1D4VSArvnN
XLTZIeiLCKBK6N/Mm9KJ
=NAuw
-----END PGP SIGNATURE-----

--nextPart2756043.MV86UGrTEx--

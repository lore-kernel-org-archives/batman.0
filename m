Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 18:27:49 +0800
Message-ID: <3750988.JXPdiNAa4Q@diderot>
In-Reply-To: <547C534E.5010405@hundeboll.net>
References: <1417426648-9319-1-git-send-email-sven@narfation.org>
 <547C534E.5010405@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3117888.qhJrk5WxNs";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/2] batman-adv: Check total_size when
	queueing fragments
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>, Sven Eckelmann <sven@narfation.org>


--nextPart3117888.qhJrk5WxNs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 01 December 2014 12:38:54 Martin Hundeb=F8ll wrote:
> On 2014-12-01 10:37, Sven Eckelmann wrote:
> > The fragmentation code was replaced in
> > 9b3eab61754d74a93c9840c296013fe3b4a1b606 ("batman-adv: Receive frag=
mented
> > packets and merge") by an implementation which handles the
> > queueing+merging of fragments based on their size and the total_siz=
e of
> > the non-fragmented packet. This total_size is announced by each fra=
gment.
> > The new implementation doesn't check if the the total_size informat=
ion of
> > the packets inside one chain is consistent.
> >=20
> > This is consistency check is recommended to allow using any of the =
packets
> > in the queue to decide whether all fragments of a packet are receiv=
ed or
> > not.
> >=20
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
>=20
> As with the first version:
> Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>

Applied in revision 73c9ecc.

Thanks,
Marek


--nextPart3117888.qhJrk5WxNs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUslAlAAoJEFNVTo/uthzAWloH/3XGNq1yyqHQHjmvU5J+CGrE
1s67/pHlJj6QCiLqhIenUprbMLIV/u3Ohox7Z+dFv/v/Z8inlZdbIf+ZUS3xDxc3
nMm6lDN+RtQGAQfzZ4RSVHas/LSEpDJRMVxtCgKfzy711qEYWzm4fVPKdvL4t+Hf
KPAKvXwMbSwSFqcTslCfC0QZOb/1N+cXV9WbyUVfz5KxSJpeOJRhVbj8tStkzt+I
tWrKGdTBgu0oueM8HWFNuDUI4bVBVPkR5usBAjZ7rT2UNrLg+8KHPWVwu6PcntNV
d4tnZAsoTc09DBvwOomUcIae7BlQVHU2bK2I34yc1xMA9u6sR6rE2PTs+50PHf4=
=Tn96
-----END PGP SIGNATURE-----

--nextPart3117888.qhJrk5WxNs--


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 03 Jul 2017 11:58:41 +0800
Message-ID: <1776891.VAe0jbq0YE@lafayette>
In-Reply-To: <20170701164711.GA13650@otheros>
References: <20170623154826.7792-1-linus.luessing@c0d3.blue>
 <3606832.Ug1eaxX1Ot@lafayette> <20170701164711.GA13650@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1735873.CzLzA1tsgn";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix TT sync flag
 inconsistencies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1735873.CzLzA1tsgn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, July 1, 2017 6:47:11 PM HKT Linus L=FCssing wrote:
> On Sat, Jul 01, 2017 at 11:34:37PM +0800, Marek Lindner wrote:
> > On Friday, June 23, 2017 5:48:26 PM HKT Linus L=FCssing wrote:
> > > @@ -1946,6 +1977,7 @@ batadv_tt_global_dump_subentry(struct sk_buff
> > > *msg,
> > > u32 portid, u32 seq, struct batadv_tt_orig_list_entry *orig, bool bes=
t)
> > > {
> > > +       u16 flags =3D (common->flags & (~BATADV_TT_SYNC_MASK)) |
> > > orig->flags;
> >=20
> > Why do we need to output the combined global (partially masked) and the
> > flags  propagated by originator ? Shouldn't writing orig->flags be what
> > we want ?
> I thought it'd be helpful to be able to look at the sync flags
> on a per originator basis. So that users can more easily spot nodes with
> broken flags and can take action sooner.

Yeah, makes sense. Needed some help from Antonio to not get lost in the TT=
=20
flags jungle.

Cheers,
Marek

--nextPart1735873.CzLzA1tsgn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAllZwPEACgkQU1VOj+62
HMCpWQf+PTDw6BHAoaExnu4TqrmDpoa1kRLgi9Cd+/c4gFkLkQovimyoXQFV7eJi
AidrIagzLT1Mz0/+b1BmrD8X8QmvRhPJQb/YYwf+1iUxSq4iAQyZws1cEXPKDa2D
rwCgu5U++BWQgs6fJw8Sqc5fmrQ/JZkfbByT7ZOq5Pujt41Gq8UU5G8xzy5rCVdW
6NGFfA87PdsK8SROx7f+7SQBcrahNWEQJbsp0mY1tetNeK0z47U76HjGuLWgVD/Y
aSzeqEDUxj1qs7cs9tzMBqxREvXn3c0MP0uPQUkqaTh/tLCpLGGa4p6ne09mYB3k
DyY2OrgAIjYPq/AnBliiPuzhcO3mcw==
=Jto3
-----END PGP SIGNATURE-----

--nextPart1735873.CzLzA1tsgn--


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 23 Oct 2013 06:04:45 +0800
Message-ID: <2255991.JK9p696vaN@diderot>
In-Reply-To: <20131022212604.GA6214@Linus-Debian>
References: <20131020082506.GC13550@Linus-Debian> <1989798.ZHJlJXvcrz@diderot>
 <20131022212604.GA6214@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1430361.TUPAWmbWRl";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] A few questions on TVLV
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1430361.TUPAWmbWRl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 22 October 2013 23:26:05 Linus L=FCssing wrote:
> With the current TVLV approach it is still going to be difficult
> to introduce new features / changes to batman-adv broadcast /
> coded / fragment / ... packets as the current approach only
> provides TVLVs for OGMs and unicast packets.

What kind of features are missing ? Can we please stay specific and not=
 drift=20
into the "meta" future where everything and anything could be added ? W=
hat is=20
the feature or the features we are talking about ?


> How difficult, I'm not quite sure. Initially I thought compat
> bumps would be needed for new broadcast features for instance,
> but now I realized, that this is not the case, because bcast features=

> could be signalized via OGM TVLVs and like with the mcast patches,
> could be enabled only if all nodes have that bcast-feature OGM
> TVLV.

Currently, I could not come up with a bcast feature we would want to ad=
d that=20
requires a compat bump. Please name it/them and state why a compat bump=
 would=20
be needed. This is where the discussion can start.


> For the disadvantages of moving 'TVLVs down to the common header',
> I'm actually having trouble getting them. Maybe others could list
> them again and I try to explain which of these I'm having trouble
> understanding and why?

Again, let's start with an advantage of adding TVLVs using a practical=20=

example. We don't want to implement TVLVs for the sake of implementing =
TVLVs.

Cheers,
Marek

--nextPart1430361.TUPAWmbWRl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSZvaFAAoJEFNVTo/uthzA5qAH/i1LIB3lskoM7mUR1Pm7Z/wf
f1JrRmb/l0GbYHsUKj/53zxWJ2BMIk89ejb4Govbdd9IeUgE0rL8gYi94r2KqYw6
5BsyyLjtcygphIkYjDz8OQ5B2EpqJruHUQM63enLWYkUjJpNme+DVzu8OEdDAy5a
wkTr8c+xGyCh6XtTTsZO/5onQAfu8utN1uPcEJhCJTLiixvcW61eTPSReqUZJ3S2
0g2WKgxYmLbPWDf6gVRiATTlVg+tCzBBtID10Jfbg5nLt1FWh6EDbYXZnnj0/xHr
tIDw4d+X7ciIR7SFmW7qcE1wA6fldi6Ts6/PRQTxSXiDXyModMfgdByy6Fq91aI=
=mA9O
-----END PGP SIGNATURE-----

--nextPart1430361.TUPAWmbWRl--


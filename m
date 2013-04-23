Return-Path: <ordex@autistici.org>
Date: Tue, 23 Apr 2013 21:47:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130423194703.GB16603@ritirata.org>
References: <1366474654-26361-1-git-send-email-martin@hundeboll.net>
 <201304240317.27196.lindner_marek@yahoo.de>
 <20130423193004.GA16603@ritirata.org>
 <201304240343.06405.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <201304240343.06405.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Receive fragmented
 packets and merge
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


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 03:43:06AM +0800, Marek Lindner wrote:
> On Wednesday, April 24, 2013 03:30:04 Antonio Quartulli wrote:
> > On Wed, Apr 24, 2013 at 03:17:26AM +0800, Marek Lindner wrote:
> > > On Sunday, April 21, 2013 00:17:33 Martin Hundeb=C3=B8ll wrote:
> > > > +	/* Make room for the rest of the fragments. */
> > > > +	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0=
) {
> > > > +		kfree_skb(skb_out);
> > > > +		goto free;
> > > > +	}
> > >=20
> > > If pskb_expand_head() really fails this function will lead to a crash
> > > because skb_out points to undefined memory.
> >=20
> > I'm not sure about this. pskb_expand_head() can only fail in the early
> > phase and in that case it seems to return the original skb as it was.
>=20
> I guess I did not make myself sufficiently clear: If pskb_expand_head() f=
ails=20
> the skb is free'd with "kfree_skb(skb_out);" followed by a jump to "free"=
=20
> where the recently free'd buffer is returned ...
>=20

Oh, ok. I misunderstood then. Sorry.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRduU3AAoJEADl0hg6qKeOttcQAK2lA10V6vAV3UhPotM3EPxk
V/+uR2sPmJX820PAxIFeMfhRnoj5Og0rRsXWatzV27uDi6u/pzyySyUfkWMRK9QK
T8/oSOqqIISjeARLTeCUQvorJF0kYHUJfjuJejDl/EfwORCez2f8BU6sI2BfhrtE
qza2GqRkcEhlB8zo75zjAGESIYWji5LqssSmACthc0PUdYN/U9e9QYvL7H4oe66r
lm8GTszZSA7+HvWTyuhccU8mmZziuVY/Fo8k7cZfkwhAm17knaUikXGGT2KDrC1r
/W4cV9LT6DD83NUCGlzLbFDOm3NLRbhNWvE9Gh/JPILyhinhKdR94h6dN9WlJqtZ
LopB/OG0BIB/rGVuFuqScAkwTH16Q2oyn73wi0ZtuYX8TBykTP83kgtS6HJLCLZi
BRSL57aib0CW8arQWHR+VuFJGoq3hii2Npszn4dWbKwv6brEwkezb5ChDhzRn/lO
NdsdrR5JKF4GUu0njLx8mqt/c9UQMDTSOFt7wFvSe0mStSIg6C7SyDDvLWDIIu9F
0geJyFsiZ8OhvPzn6nTD4bccQz9sahq3wQ++6EyqSZLerRtXi556CMEFmCzpgaUh
Cw1I5KR7esgwngOl1Jn2ktOCyy9YfENcalqkfPw4ACNX4fQTfYjOLDKHIG6mx3Sm
M+iE+if6mWTFcutJxqDp
=AN2O
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--

Return-Path: <ordex@autistici.org>
Date: Wed, 18 Apr 2012 10:31:38 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120418083137.GF27966@ritirata.org>
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
	<1334701645-25862-2-git-send-email-ordex@autistici.org>
	<4F8E777A.5010901@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
In-Reply-To: <4F8E777A.5010901@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: don't delay OGM
 information announcement
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
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 10:12:42AM +0200, Martin Hundeb=C3=B8ll wrote:
> Hi Antonio,
>=20
> One minor/trivial change below.
>=20
> On 04/18/2012 12:27 AM, Antonio Quartulli wrote:
> > +	/* if we have too many changes for one packet don't send any
> > +	 * and wait for the tt table request which will be fragmented */
>=20
> Better change that comment te end with */ on a newline, before sending to=
 David :)

I definitely agree. Thank you. I would really like to see this check in
checkpatch.pl :(:(

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjnvpAAoJEFMQTLzJFOZFFawIALMCIWHrDgVjXXJwwKLfKNqc
BRuY/c6bgGYNDYPYmxzm/Ih6COSU4K9SzrlOLH7KOKY28Cmr6LV+DjpM0g7lvmPB
AK2i6gMCvaEOzht7Q+MNhh+ZM9SUvZNgoy026Wn6r09smMEg463DKe+8cwe5PQto
riAtlmRXzauAetH4Wq/BNIIFr7dzS0J6FlKxz5yu55zRoqUuUT/nEiKxqvTrP7fW
c8OpTCphf0B5jph3bYnqsn7hgUls62BaGxoqzU4Kkf3DYgFP05oQvcz2JRfNJlt5
zZ4m3M/FuA1Stjnb+NzGWC8tvfJqi8pZ3kTstynKm9QJMHC+Kh4jTitg1GZ2E3M=
=Jf87
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--

Return-Path: <ordex@autistici.org>
Date: Tue, 17 Apr 2012 15:29:34 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120417132934.GD3377@ritirata.org>
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
	<201204171019.32919.lindner_marek@yahoo.de>
	<4F8D6F20.8060501@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <4F8D6F20.8060501@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add get_ethtool_stats()
 support
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 03:24:48PM +0200, Martin Hundeb=C3=B8ll wrote:
> >> +struct bat_stats {
> >> +	uint64_t forward;
> >> +	uint64_t mgmt_tx;
> >> +	uint64_t mgmt_rx;
> >> +	uint64_t tt_request_tx;
> >> +	uint64_t tt_request_rx;
> >> +	uint64_t tt_response_tx;
> >> +	uint64_t tt_response_rx;
> >> +	uint64_t tt_roam_adv_tx;
> >> +	uint64_t tt_roam_adv_rx;
> >> +	uint64_t dat_request_tx;
> >> +	uint64_t dat_request_rx;
> >> +	uint64_t dat_reply_tx;
> >> +	uint64_t dat_reply_rx;
> >> +};
> >
> > How do we handle code segments that are not compiled into the module ? =
We
> > simply leave this counters hanging around at 0 ?
>=20
> As I understand it, ethtool doesn't mind "unused" counters in general, so=
 it comes down to the memory footprint of batman-adv. Do we want to clutter=
 the code with ifdef's to save the memory?

As we do for all the other component-private fields in bat_priv, I'd say th=
at it
would be better to do the same here by using ifdefs.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjXA+AAoJEFMQTLzJFOZFMFMH/2SjiVGrDe730G9rWHJErBNd
FSECXM8FNDd4nHwRL3rcFSbNSaNB8LYvOqwmvqbvVI5f/i4QCeRh+MFqZtarZNpU
W28hDzB6CGn5yZE5EER5nTzXyoG6cBXqXRFOjVyb6DqtwfDdekwFE3wD7KP3x6W9
WVdH8GHQXK70zGA6TJ3REr7EtRj/c5KuswtklNZYPxJJcHpAc0UMj/lr3mrWZR5g
qro1HiKjcLmDTTMJlZb3RqrcNCyMpJsDpp14FQbkpytqsL6ySModIPkuSBg/iDsx
b2uSQHt1fnyr0Lshh+yPnLYWWQJQg2xj45/3i2CATVzTR6jIrMFNr0QTBIicQ4A=
=0r7X
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--

Return-Path: <ordex@autistici.org>
Date: Wed, 17 Oct 2012 13:56:04 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121017115604.GO7023@ritirata.org>
References: <1350473910-27496-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Bk6L21jbBNK7V1Rv"
Content-Disposition: inline
In-Reply-To: <1350473910-27496-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix broadcast packet CRC
 calculation
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


--Bk6L21jbBNK7V1Rv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2012 at 01:38:30PM +0200, Linus L=C3=BCssing wrote:
> So far the crc16 checksum for a batman-adv broadcast data packet, received
> on a batman-adv hard interface, was calculated over zero bytes of its
> content leading to many incoming broadcast data packets wrongly being
> dropped.
>=20
> This patch fixes this issue by calculating the crc16 over the actual,
> complete broadcast payload.
>=20
> The issue is a regrission introduced by
> e5cf86d30a9b32feccb6b866a3f23b0e0483a3b0.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Hi Linus,

nice catch!! Don't know how much time you spent to find the correct point w=
here
your broadcast packets were getting lost.. :-)


Is it ok for you if we change the commit hash to ("batman-adv: add broadcast
duplicate check") when merging this patch? Lately Dave complained about com=
mit
hashes in patch because it may happen that a developer uses a different hash
function for his git repo.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Bk6L21jbBNK7V1Rv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlB+nNQACgkQpGgxIkP9cwdIWgCgmLKE5KxvZTScUauhDGZEg2Sq
jSsAn3P9OM7Zx6m3ZEYx2OQuVN1eVfOB
=NSMr
-----END PGP SIGNATURE-----

--Bk6L21jbBNK7V1Rv--

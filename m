Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 11 Dec 2012 23:34:35 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121211223435.GA17765@pandem0nium>
References: <1355263044-13131-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <1355263044-13131-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: postpone OGM preparation to
 sending time
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


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2012 at 10:57:24PM +0100, Antonio Quartulli wrote:
> OGMs are currently prepared 1 originator interval in advance then the tim=
e they
> are used to be sent. This means that once in the air they carry old infor=
mation
> (e.g. TT announcements).
>=20
> To fix this, postpone the OGM creation to the same time of sending, in th=
is way
> the OGM is first created and then immediately sent.
>=20
> This patch also removes an insane "-2" that was introduced with
> 4d30670880c84071dba4b220f595e64d6c01d1ba ("batman-adv: accept delayed
> rebroadcasts to avoid bogus routing under heavy load") in the OGM seqno
> validation code that was put there to fix a possible heavy loaded scenari=
o.
> First that operation shown to be completely not valid and consequently it=
 was
> creating problem to the new behaviour introduced by this patch

Actually the -2 was not introduced there but was present (in some form) for=
 a much
longer time ... something before 2009, didn't trace it to the very end. :)

The reason for this was:
 * seqno is increased right after scheduling a new (own OGM)
 * the scheduled OGM was waiting one more cycle before beeing finally sent

Seems we forgot to document this properly, but removing this one is a good =
idea. :)
Your patch thankfully seems to correctly eliminate both reasons for "correc=
ting" the
incoming seqno.

I haven't reviewed the rest (don't know if this will stir trouble for the a=
ggregation),
but wanted to comment on this history bit. :) Please remove/correct the ref=
erence if
you merge or send it again.

Thanks!
	Simon

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlDHtPsACgkQrzg/fFk7axabpACfbMWuXgnknMDT44Ly+CBSsBqu
l1gAn3qTPxQPbJ8qJH9jLvZr7fssjQMy
=ijeF
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

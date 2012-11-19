Return-Path: <ordex@autistici.org>
Date: Mon, 19 Nov 2012 23:07:34 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121119220734.GB3129@ritirata.org>
References: <1353355695-23252-1-git-send-email-sasha.levin@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <1353355695-23252-1-git-send-email-sasha.levin@oracle.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] net,
 batman: don't crash on zero length strings in routing_algo
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
To: Sasha Levin <sasha.levin@oracle.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, siwu@hrz.tu-chemnitz.de, lindner_marek@yahoo.de, davem@davemloft.net


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 03:08:15PM -0500, Sasha Levin wrote:
> The code that works with routing_algo assumes that the string passed is n=
on
> empty, this assumption is wrong:
>=20
> sh-4.2# echo -ne '\0' > /sys/module/batman_adv/parameters/routing_algo
> [   34.531340] BUG: unable to handle kernel paging request at ffff8800151=
42fff

[CUT]

> [   34.550025] ---[ end trace 6c53b662c574774b ]---
>=20
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>


Hello Sasha,

thank you very much for fixing this bug!

However, any patch sent against the B.A.T.M.A.N.-Advanced code should have a
subject starting with "batman-adv:".

Other than that I think this kind of patch
doesn't really need to report the entire kernel message: a more exhaustive
commit message is enough (e.g. use function names). I personally needed to =
read
the patch before understanding what you were trying to explain in the messa=
ge.


Then, we usually pick this patches up in our repo and then we send them as =
batch
to the networking tree via pull request, therefore you can also skip the ne=
tdev
ml when sending the fixes.

Thank you very much!

Regards,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCqraYACgkQpGgxIkP9cwfHpwCeMXI1IGzmmd1AnCgOUrMerNuw
tGQAn1SVuhxYNpsd9Q/dD26ivMcbFrUA
=GiPT
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

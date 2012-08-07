Return-Path: <ordex@autistici.org>
Date: Tue, 7 Aug 2012 20:50:36 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120807185036.GG3891@ritirata.org>
References: <alpine.LNX.2.00.1208072030500.3227@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1208072030500.3227@swampdragon.chaosbits.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix mem leak in the
 batadv_tt_local_event() function
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
To: Jesper Juhl <jj@chaosbits.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2012 at 08:32:34PM +0200, Jesper Juhl wrote:
> Memory is allocated for 'tt_change_node' with kmalloc().
> 'tt_change_node' may go out of scope really being used for anything
> (except have a few members initialized) if we hit the 'del:' label.
> This patch makes sure we free the memory in that case.
>=20
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Acked-by: Antonio Quartulli <ordex@autistici.org>


Thank you very much Jepser!


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAhY3wACgkQpGgxIkP9cwdFfwCeLDF4mxfR3nqQFSugsswE1ABb
pfoAn1pozRGK5vdweqEYCEq63VXelh37
=QOsH
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--

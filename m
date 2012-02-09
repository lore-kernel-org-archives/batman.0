Return-Path: <ordex@autistici.org>
Date: Fri, 10 Feb 2012 00:52:50 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120209235249.GA17348@ritirata.org>
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <1328830902-11574-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 0/9] DAT: Distributed ARP Table
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
To: b.a.t.m.a.n@lists.open-mesh.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 12:41:33AM +0100, Antonio Quartulli wrote:
> Hello people,
>=20
> ****
> This is the **fifth** version of this patchset. The whole code has been r=
eviewed
> after some discussions on irc and here in the ml in the previous threads.
> Several bugs have been spotted and fixed. Thanks Marek, Sven, Simon, Andr=
ew and
> all the others for the comments/feedbacks.
>=20
> This patchset assumes that patch
> [PATCH] batman-adv: add biggest_unsigned_int(x) macro
> has already been applied
> ****
>=20
> For details about the DAT mechanism, please refer to the preliminary
> documentation that has already been put on the wiki[1]. A more exhaustive=
 and
> detailed documentation is going to come soon.
>=20
>=20
>=20
> PatchsetV5 Additions:
> ------------------------
>=20
> - Sanity check for ARP messages (messages containing multicast/loopback
>   addresses are ignored)
> - A new unicast packet type has been introduced (UNICAST_4ADDR), which co=
ntains
>   the originator address and the payload type.
> - Thanks to this new packet type, more and more debugging messages have b=
een
>   added. In this way it is easier to track the behaviour of DAT and it is=
 possible to
>   understand who and why added a given entry in the soft_iface ARP table.

[1] http://www.open-mesh.org/wiki/batman-adv/GSOC2011_DAT

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPNFxRAAoJEFMQTLzJFOZF0RcIAIuG2ZOV8s3CKU16Jk+DyEN3
FtQul0uMXDbuRRA7quxVNy1hhqsBhaYmZsBX0MbzCMMR9Cg7nK+SuWtA4TMZhkK6
R2zxBU0pS8wm9kPkILndY7iPkchCPf1PqP9A1+lU/dHC5KrPB/KHNsoL5npkQy6L
J4NdowOZwHBekqDncSMv1qQHuWYWdJX2bUzTdbSNxMcUd5Papn+zsvv9JjUJSXuu
ZrLcAuS3dW7yvK4jHfGrN3/J0lMuFmr9W5BSArHI749AAJ3DaBawNAMPB+QUdHjZ
uJGNgV3OnSB0Ochw7UIvL6UYXCmeeAFNJCRMYQr/QFtuoQ/8ZHscAmWb19Wg9rE=
=YxkN
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

Return-Path: <ordex@autistici.org>
Date: Tue, 31 Jan 2012 22:39:36 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120131213935.GB28554@ritirata.org>
References: <1328045710-32600-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <1328045710-32600-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: pass the correct header size
	to interface_rx
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


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 10:35:10 +0100, Antonio Quartulli wrote:
> in recv_unicast_frag(), the third parameter of the interface_rx() invocat=
ion,
> which is the size of the current header, is wrongly computed.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---


This patch is based on top of maint, even if it does not really change so m=
uch.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPKF+XAAoJEFMQTLzJFOZFjdMIALexWvOY1zQemyi2upoVM8dv
AOYkI2RBOkD96JLjCgt9RJO6Ak1pMj+5PtrV0La14Vo/N3CnglYMoxyXBWivSbZV
0xxkh0vMfwClY2FoisqAZpv9NqWsbBtMt3/zRbdi79tZHQUnC6pnhapacFv1TpCw
YzAIVuKHpNvRleK01TJekT+hzSegBI8WD8DE6STIG0TXgymaVPS6rKxIzM56HvCF
9+cQ2Dmx8SLHXKmY1hYzv+gcheQdBL9AH3SDLuG6vuleC3WJbyKORMmId/dYp7fy
HUpHVT3Ds6HPslHJmkZSJID2/wFnbdXPRxenzwoPBbQBSJ9/7cvBrza62ZmaZ7A=
=72zW
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

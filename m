Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 21 Aug 2010 10:41:56 +0200
References: <1282318358-16121-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1282318358-16121-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1682167.Fireip0Cn3";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008211041.57550.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't write in not allocated
	packet_buff
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

--nextPart1682167.Fireip0Cn3
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Each net_device in a system will automatically managed as a possible
> batman_if and holds different informations like a buffer with a prepared
> originator messages. To reduce the memory usage, the packet_buff will
> only be allocated when the interface is really added/enabled for
> batman-adv.
>=20
> The function to update the hw address information inside the packet_buff
> just assumes that the packet_buff is always initialised and thus the
> kernel will just oops when we try to change the hw address of a not
> already fully enabled interface.
>=20
> We must always check if the packet_buff is allocated before we try to
> change information inside of it.
>=20
> Reported-by: Tim Glaremin <Tim.Glaremin@web.de>
> Reported-by: Lemonde <zukky@bb.banban.jp>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> Cc: stable <stable@kernel.org>

Before there is a wrong impression. This bug was indirectly already fixed i=
n=20
trunk by "batman-adv: attach each hard-interface to a soft-interface". So i=
t=20
is not a must have. maint/next got the patch now and I hope that=20
openwrt/debian will have them soon too.

But I will send it for the stable kernel tree now and change the patch
 "batman-adv: attach each hard-interface to a soft-interface" in master-reb=
ase=20
to remove those changes again.

Best regards,
	Sven

--nextPart1682167.Fireip0Cn3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMb5FUAAoJEF2HCgfBJntGNpgQAJew+I96Nl//nZJ7Qtd0WJAD
Hm8UKfBywQI3HN5f2w58QpjZrMqMC3sJEpM8pB/HHWABFQMYqxdTSOH01Ha9wAry
8/kCj46IJs3aFPVUET0eHCqE95JA4dsMJoso7yN2szDYu2GvPzVDHLITLYGN+hNy
3cEVfBHsdcFP57RUUhtzT2SQqPhocgWBoq3sR1KLIP5L+ZdCD9RCiyZTtrFiFX7M
u6IFcWLrpqdV8X6AVgoSMib+RJ/TG7MJQDNtUHLPwvw3FvYR9jn7MlKqp1kuCkLs
x0PchY4DsIvDp1a6NKYpVWKtEMpZah46Yik2+rjR1Jge4h9GBo+DNMrlWjL7VZIp
/hI7VIzi53FS0A3OWtC2p/0tcVBMtOmCnLPo2b/JQakeiuiyBV9Xi/D2OHbzuGO7
JrAsyhPSZG1Et6z8lWCXayspB64RojcMSzFfehrjYOeIU0tsv0heyOV0uLSr9LVv
rFQSVOJ6cz2Y1PAFVYiuJ59YYbxX/GmfKo00ewn4uwAPPUTlpUiPwP2GTnT2sTvA
yJceG2pOzMu7yKz85S+Je1ftxJsqNWaA96GHIJmttxGMymvXcX065Rpi2fINtkkw
9+YhJTl8H2cs+XGxSPGpmI7LXA9dxTTL0qDaZ0I4gBLzDLXMgEzWBFjljdY9TOm0
rH0p9AJq77ldTtbpTSC+
=BGKq
-----END PGP SIGNATURE-----

--nextPart1682167.Fireip0Cn3--

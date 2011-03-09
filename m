Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 9 Mar 2011 18:04:50 +0100
References: <201103091748.32512.onelektra@gmx.net>
In-Reply-To: <201103091748.32512.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7027543.MERJfnpI2G";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201103091804.55424.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [Patch] vis: Modified format of JSON output.
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
Cc: Alberto Escudero-Pascual <aep@it46.se>

--nextPart7027543.MERJfnpI2G
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 09 March 2011 17:48:32 elektra wrote:
> The current vis server JSON output format is breaking the json_decode()
> function for PHP.
>=20
> This patch mainly:
> - Removes all spaces
> - Removes all the \t TABS
> - Double quotes the string-variables
>=20
> Reported-by:  "Alberto Escudero-Pascual" <aep@it46.se>
> Signed-off-by: "elektra" <onelektra@gmx.net>

I am not sure if anyone currently maintains batmand and vis.

Anyway, your patch is more or less scrambled. Can you please resend it usin=
g a=20
client which doesn't create a wordwrap and space massacre[1]. Many people h=
ere=20
seem to use git-send-email for that purpose.

Kind regards,
	Sven

[1] http://kernel.org/doc/Documentation/email-clients.txt

--nextPart7027543.MERJfnpI2G
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNd7MzAAoJEF2HCgfBJntGFNkP/AlETzCk+qJKAM5lCRJEcsuu
R7cDF2FKK0y35X2k+juTJJ7btU7j1nUXqx0HcLZK4PVuK/jkQU/JUJTyc9jRzJAZ
L+RU+bOJrP3szQhPLVBaeqwsoZA/mUDmqzChlg6cqaolr2/sEefkCrtqk+T8Am6o
kNbJdYJsbbFtRJ+ZHwrEx5jXI0aBMm/Vy0XK+x8AA2OFpWrgzwGimQVOOhr7tVLD
qeZB/uIlB8s3W6AuQrNLPuoV8RsHqAWV3cs26yf0Y8HMr7aMbNuPbXQAfA1IxTCJ
aczINi1oJrjydWxv6cSRnscVFGNGvMrOEN5NCf+8f1DvECmNSlR8BZo4aGHkkhOD
KADfaX3cWVoJTVjrkbZnqb0UEgZsVl5X7O6qWU/oZCeA3PQK5FAJXEdV7UqpKF3/
+GjB2EhWaodIwzehwR2U9bettqTRJvzSLdNpF7SjUZwwIwnwHIi+FWIuXJYv/zUY
RmPnyc8PHbpslqt9d/l3DShcpBy9hDC/F/e8MpuJXYFOzeMEl0s97oPfcEFZ1JV/
9dcM3XYV5bDJ8Ko+vmbY1O5o5xTSDs3SDSRB1FSi6K6xtErTbB2CTPWiHTEKsS1Z
4ZERUolZ21FP1MCWIAPqOQabNTKPdRlSWx1snzypCQC0ZcIoU6d3geHUSmuDGjKv
XBUeKn9dlJ9cmCh4wOxI
=Vqb0
-----END PGP SIGNATURE-----

--nextPart7027543.MERJfnpI2G--

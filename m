Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 May 2011 13:44:56 +0200
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1306013107-18515-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1306013107-18515-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16328898.fpUY3Hkhjp";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105221344.57586.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: improved roaming
	mechanism
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

--nextPart16328898.fpUY3Hkhjp
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> +	memcpy(roam_adv_packet->src,
> +		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);

Again, Nack.

This is _definitely_ not allowed. Please use the primary_if !=3D NULL that =
you=20
got through primary_if_get_selected instead of dereferencing
bat_priv->primary_if directly.

Kind regards,
	Sven=20

--nextPart16328898.fpUY3Hkhjp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN2Pc4AAoJEF2HCgfBJntGOHcP/3otkKTgWtKI+cnOkxtrVFem
o9pEEdTCnvehxHXD0INB2g16si8v7zrz8bLsf1chQ6C8cxaj8ueD/mGkiQhpn7ZD
kWc0Qr1FZSMQMo6gISOAH0fUUrvaydkzDH3FH2I5vBTokY9FvrySjzJ3hnpce5du
nuixG6PY2R/1SkkEG+wrXxh6qr2NWbMORmNuF41JuFsv3xRZGc1qRoYgdMG0A4MS
y4KG9FErnlP0ayyin7p59bcyTPpUDrtmbEGh9+KCMm0291q2DfhLe1AsES35Vxts
Lfabjmx/TP9onRW3p7JKp3EMLi1o9vKWDyP68fBMl0pD740nDP+NGM9A2CcMGqWy
c4aG/RhJXDMH1kKADLim6c5vRre8A5eWIoGjLY2NWEtgI6BeNGr+OpTpBm7Z4L+i
r/G5rMKqBLph4lNhu997JTYJG54MVUgf9MfXqIaBVx+6m4LyPZujEyFlhu1ORFoa
YsZ2SMYpKS/Gh34ISPZQiHDXScD+bvG+yz88hwO5goEc5jbGWDahOj+B/JCFB5Zg
tSptlT5leacUriSUdjAwAc01pmd6xr59b5dfMY34Ehct74ktJh6YuIc6Wfn5YoId
SG5k80jjH0m09lkou1GseM77/ymVD7/l9IcXxkqOLU9mK8Ncjtn7JkYT2Ro6hU/1
BYZ+NwQxvGey8C1hFgmJ
=NE/3
-----END PGP SIGNATURE-----

--nextPart16328898.fpUY3Hkhjp--

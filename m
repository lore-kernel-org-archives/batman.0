Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 May 2011 13:01:02 +0200
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1306013107-18515-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1306013107-18515-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1627545.XDBQI2q7e2";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105221301.03376.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/3] batman-adv: improved client
	announcement mechanism
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

--nextPart1627545.XDBQI2q7e2
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Antonio Quartulli wrote:
> - Cleaned following ecsv's patches/suggestions.
> - recv_unicast_packet() now uses seq_before()

Antonio Quartulli wrote:
> +           (diff < 0 && diff > -0xff/2)) {
> +               /* Linearize the skb before accessing it */

What?

Sry, have to Nack this one.

Kind regards,
	Sven

--nextPart1627545.XDBQI2q7e2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN2OzvAAoJEF2HCgfBJntGFiIP+gKbWLkPIOVNBeowUL1s64it
vsmwaAsOYm2PtZK6CdMsJyTufNbr0wiey2DtoiqF1CWWrY1mo2TSH9EgWe8G6c7X
jEJpwGIT0TI/tgPobOmwQOWpPsJLeiM7VKVr0AVfAJ3YTazNGaRPrt6af975pdUk
1WGqLHJ8G4gxu9GBaYtIVTow6ZUcbxj2iv8HQTXoLGSF0Y+1Co73f1cdqXCCM5Yg
ZrwLv407am9NqcCclx3saYlMTzf3ofnwZK6whhPU+8HN8p/LjPucHbNo6tCf4Gbt
O5JXGV5M3uV43HUsd6O9B9qBT3NqaXrv0bJ96attNzNiNLeodq5x4+MJYDm+xujh
svLjwmq72e2No/1DLCd3kS7e5OB0GZ7hrbvkoJpiDhEaRuzdxdsxEV/FYquiQWv+
mDdIvfcsbTdI/BlvxuHuK+9XHU3bNg61qri+kfXRr3HSjOkqXxhn4rhheQQnwauO
mOwW/lSPLU/NBNwUQY5KkqAYNBeGxzdW88eCaFxTPq4cj3NmOxt1lWm+YrQczGJS
6YVHpdObXs2VPn0pAxGXE1ayvOJRZanPYAwqIxH6/2uGb0wmxAijfx0l4wET3EVo
3ymMqEHhhSEjzU5tePQA9gL5s+jiyH8JXdAm+OjzEaNfgBwbJ6bRJytUXZBFnjIl
yZCayGklJyIn9PLiWCaJ
=W7qS
-----END PGP SIGNATURE-----

--nextPart1627545.XDBQI2q7e2--

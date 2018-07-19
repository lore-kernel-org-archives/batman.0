Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 19 Jul 2018 12:00:49 +0200
Message-ID: <2381904.QgVrOuYyfa@bentobox>
In-Reply-To: <DB5PR0301MB194454E1EE62744B735FF731E5520@DB5PR0301MB1944.eurprd03.prod.outlook.com>
References: <DB5PR0301MB1944EFA68543572CA670633EE5520@DB5PR0301MB1944.eurprd03.prod.outlook.com>
 <DB5PR0301MB194454E1EE62744B735FF731E5520@DB5PR0301MB1944.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3479584.BrvvzsDKzO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Issue with mesh network on different RTL chipsets
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3479584.BrvvzsDKzO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 19. Juli 2018 09:53:26 CEST Francesco Salvatore [fabbricadigitale] wrote:
[...]
> Do you know if there's any issue related to listed hardware chipsets? If
> yes, you know of some action I can take to fix that problem?

Yes, nearly all [0] wifi USB sticks are problematic. Please get in contact 
with the driver developers [1] because this (beside the symptoms) has nothing 
to do with batman-adv. If broadcast or unicast tx/rx is broken for a specific 
hardware in a specific mode, the mesh will look broken - nothing we can do 
here.

Kind regards,
	Sven

[0] no usb stick comes to my mind at the moment which is without flaws
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS?id=024ddc0ce1049298bd3cae60ae45d9c5f0fb8b9c
--nextPart3479584.BrvvzsDKzO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAltQYVEACgkQXYcKB8Em
e0bMaxAAiNup0G5018x2SarNOhdXj07OFDOf1YEEd7GFx5S3tXmdSUW8utYqxKoD
eM8OdYUmtUR+fl7Ki2vUmw0QoHp9xoKGT/EK8bEpwlyn6lo/NyTJ1RSqWxqfd0gU
dKMJzIdLiz2JosHYxQ4voBVKI/Ukjke1oOvsepsDPD1+JiGX8ejxCGVAiI0EL8VQ
C3vlBqRGXr7UERyrDL8m1wEck8I9SpQo065QUkp/jXET+dPPOd6e8iSvsBBgGpGQ
XcuYeD5xbOsUXj//TflW//BLZN/To7Tqt6zIPrQ0V4SvsNmBuqm1VxslxXfD5f4S
uKlPJggV0gMBvIgxoVqw/zJ2Rdf1uZLo8LdQlleeM/Lr67j0PJwgHlCxqyqa4mqo
bMt5ZzZdHsWgoCNMF1GMXrYeMBm4T5GHAxyp251+clcIIQNh1jXWtGiM3iqoh58U
bh+UNGRC2Lv8EgvJNUDqu0l2REYP9gcCNex9RwiGGsAps0wzNU1w7QYqmDU+JuDx
lzG1LbxosWaOMk781anWALQBbvjUiDkY9QJ2lR55DDd8Du+uiZ5BdYv9ICjj3KKx
e0U4IGoTGv4qNHWGcRq+4Btpun0TOScgAuGNnlHCgPMP8dOXMncYVbAisycPk1LP
Cg1kN4D4npCI3ci32jdCFWb1ksFa6p/avG3C+XUslw9V7PXMYSU=
=7ty+
-----END PGP SIGNATURE-----

--nextPart3479584.BrvvzsDKzO--


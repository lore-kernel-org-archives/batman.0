Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Problems with Multiple Interfaces
Date: Tue, 13 Apr 2021 14:02:54 +0200
Message-ID: <7463417.qeE93hC4D1@ripper>
In-Reply-To: <6830943.IaFvOplyQc@prime>
References: <3542676.qYy7ulQ77K@prime> <20210410003953.1234.9147@diktynna.open-mesh.org> <6830943.IaFvOplyQc@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3972202.uF3WI69yUZ"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: joe@careyhome.org

 
--nextPart3972202.uF3WI69yUZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: joe@careyhome.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: Problems with Multiple Interfaces
Date: Tue, 13 Apr 2021 14:02:54 +0200
Message-ID: <7463417.qeE93hC4D1@ripper>
In-Reply-To: <6830943.IaFvOplyQc@prime>
References: <3542676.qYy7ulQ77K@prime> <20210410003953.1234.9147@diktynna.open-mesh.org> <6830943.IaFvOplyQc@prime>

On Tuesday, 13 April 2021 13:53:16 CEST Simon Wunderlich wrote:
[...]
> Also "tcpdump" helps. For 
> ath10k, you may want to try 11s/mesh mode with TTL=1, while with ath10k-ct you 
> may prefer IBSS mode (I think that wasn't mentioned in your first mail).

Please avoid the ath10k-ct firmware. And for ath10k, please make sure to set 
mesh_fwding=0 on the mesh(point) interface.

Kind regards,
	Sven

--nextPart3972202.uF3WI69yUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmB1iG4ACgkQXYcKB8Em
e0ZdwxAAlr47F5cHJucuGu+mJA2nCdjAO3Ujlorsq73h0YmSwtG1rrWSzqqoMJGS
TX1E8l8I2B1Q1aBOP0Vt0zqkre8pO5jVvExt8lrY4j4Tdg9GsvSkILOKPKYjL+XR
1XbyW/UY6J2yfA+uEhRglf3coyRcQzeHj+XBr6w6CYR5VhAI49Dn612/U9tp/D8m
olrElhoX4TyVdEcpcoUaX75jLwsNwE0l77xgkhCqeNtTXVdbRrokhGgYMJA4X4wR
6hfhClennRK5AKQ84HiPYwO7KIVFAir91x3oJU7uvIA0dPNlUJX/+GuOGx0BAEzo
QBBJ2KFyqvb6KhM2WhOTAUc0wG5UUvVdH7YXJgf4M/VhX05HNo4o+QlUYYE9SW2i
5J/MtbXUE3BBPygV3NczWyvAgRpTrHF3z9h2EmOa6E3HreCONp2gU3XtpP+WJQ5j
1/fT1vpEyv54LOHfS1sGICggZObJ00d0gPFaGl5oEt9J0m4Ow2MPxJJAOXDNVGuz
qUW2MDVaO8iySSiyVqNgZu9wzorhz2VD1X6qL+ovlXNKi05hQHuzudWDOyFTYcMB
uyPISqzOyFJ6NKpFP3bSmujy+GjeT/alSYyWrDwE03HyakVJfFv90rBp4W71GNFB
/s1hEkeGyw46lwBNLr+x7x+ovJqRxid+HWUUIiSzAkj7VPAdniE=
=7YNK
-----END PGP SIGNATURE-----

--nextPart3972202.uF3WI69yUZ--



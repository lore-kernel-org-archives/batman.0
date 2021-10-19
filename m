Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: prepare for const netdev->dev_addr
Date: Tue, 19 Oct 2021 20:02:52 +0200
Message-ID: <33425786.lHEVMZF3NE@sven-desktop>
In-Reply-To: <20211019163007.1384352-1-kuba@kernel.org>
References: <20211019163007.1384352-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3738197.mCjuJMru3Q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, mareklindner@neomailbox.ch
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart3738197.mCjuJMru3Q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, mareklindner@neomailbox.ch
Cc: sw@simonwunderlich.de, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: prepare for const netdev->dev_addr
Date: Tue, 19 Oct 2021 20:02:52 +0200
Message-ID: <33425786.lHEVMZF3NE@sven-desktop>
In-Reply-To: <20211019163007.1384352-1-kuba@kernel.org>
References: <20211019163007.1384352-1-kuba@kernel.org>

On Tuesday, 19 October 2021 18:30:07 CEST Jakub Kicinski wrote:
> netdev->dev_addr will be constant soon, make sure
> the qualifier is propagated thru batman-adv.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart3738197.mCjuJMru3Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmFvCEwACgkQXYcKB8Em
e0Y5ARAAzLudn8YgxZr1hwMPId7eiSbHQAAuDyqwyaB8ktJvIULjzmLUcD4PsqzR
lrHIA2L1JGu5fmlKsCK+axL43zgYAnVYrFWAwdDgYEm3DLBR8B+Ntv7qcfb8NxuJ
8OrlUwyD8MfkaHMbXR5XRv2OcLFIMplT1qsEYiZvnK8mo3eFvQ3C33kDIL93owT0
+eyPZ0lsClVqpNiREngLv8TQ5NrxMhOWcm/LAQycWtk/JH2fLU1oEZkg6eZnPG8B
1hbqlz7TooVjJee99nL4EuFdg2KAfE6+0sgluTShLPf1qaq9AkK682qWK9o7JT65
qBmCA4yW8dDtZizOYDUWwl2wUDhMDDupSkIwIy//DVt3L9SFOujD/DmoEnTE8uV3
A3cNbtzF5Iv7GD0B4QfyY+hyTvvCgyodbNmL1bes70y8CdjnSDQSvpv9Ft31Ba8A
rPnD3xTcJ02OK8tB37bE6vqVpAWMKceIYz6mUnEXlxZ1zZb4gJY+emZmGSOkxklt
cmFcoJsz5gzqFkRbb23djPgrjp5675BsaiPNxNjXsTj1De5Pkn0bVDuckCrtZvGX
2MkyzivLQ8vTpBn1iQOv8kgr+i+87QbKmXo6gee33rwgubTDCKlY2YxpBz+R42Mg
WOLdSHNt/S7G+Ov7lPCsUEYdROfwLET0hf/g2oyWuneGq93onbg=
=rpsb
-----END PGP SIGNATURE-----

--nextPart3738197.mCjuJMru3Q--



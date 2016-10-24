Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 24 Oct 2016 11:14:34 +0200
Message-ID: <33577221.y7g3rr1A5V@bentobox>
In-Reply-To: <580DCF9C.6080906@yahoo.com>
References: <580A26A4.5030005@yahoo.com> <5413531.KRiKksbB9Z@bentobox>
 <580DCF9C.6080906@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3658895.BS7I8MJjnR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] High latency with batman-adv on ethernet
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3658895.BS7I8MJjnR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 24. Oktober 2016 17:08:44 CEST johnzeng wrote:
> 			What kind of "caution" info?
> 
>                          When i start ping hostb from hosta ,  i catch error info via dmesg , this is parts info
> 
>                          please see attactment of email about more error info .
>

Try on both systems to disable rx/tx checksum offloading:

    ethtool -K eth0 rx off tx off

Kind regards,
	Sven
--nextPart3658895.BS7I8MJjnR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYDdD6AAoJEF2HCgfBJntGzpcQAJ7O/UOTqqzw/fDO11URZT0O
NUb+0JYmtPxkDzMNbIjakcRfypDDcsbtEZ/7dphlK0Sv/7y6nA8BZ/UL/zxQ6+YJ
/p3LGeOkNn7+K9G74wHKdxWvdW8KfCqbBUlIhZNOwCVk49rWMnKsyywuEtNDTluV
qFl4DqX0h1SMj6Fa8sipxyA+rjEYWkG8lBHcPoYrJSdH+UoHr3CPQD12+/8QQ1bh
0oyPcehEPJGwYmcr+FLXdc9U/J0OuSU8UY7cMNnx1PM241VpDXWDSTeLhh2FWyO5
dZ6v7yS1fzQIzQPsT2Y3sKNS1wKa2pgGCg/OjkFWcy2U0SS35CasR8R237y/WQQ5
sG+NzmsSnxxA4SIWD53VWwWZUBygOri9LphlWdcXpMNsMrhGGTDq0ytXtCtwvfqa
udaIYYxckrfBqymYE44AYZeyqRyE5bGUIclN9K/CsUjgTmLx7nWBdk7/uO2r1y8z
rIsgmm5tBP2e/ytw+9P1EBJC8sa7TsZKP0vkfUVmWo07yQqgxQUEk2YQg57ojRqX
RTvYvkqPr+tYrondNPCZzriR7UU5BYGSVv1jSYeCX5DlVDNjxS1HJemt63o0Ajft
l4Z4P2/gF0OcEm654y3TP92j4nMo0CJOWTc4ipTbu3mGKajQ4wc9Ptum3I6AnXfS
gOoqK7z/MmLlpvDHCZgJ
=LCVY
-----END PGP SIGNATURE-----

--nextPart3658895.BS7I8MJjnR--


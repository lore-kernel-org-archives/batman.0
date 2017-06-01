Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 01 Jun 2017 17:12:44 +0200
Message-ID: <1510478.XXh1M6D72J@prime>
In-Reply-To: <20170601151126.20708-2-sw@simonwunderlich.de>
References: <20170601151126.20708-1-sw@simonwunderlich.de>
 <20170601151126.20708-2-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4578013.rxioT3ABBc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: handle race condition for
 claims also in batadv_bla_rx
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

--nextPart4578013.rxioT3ABBc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 1, 2017 5:11:25 PM CEST Simon Wunderlich wrote:
> From: Andreas Pape <apape@phoenixcontact.com>
> 
> Like in the case of the patch for batadv_bla_tx to handle a race
> condition when claiming a mac address for bla, a similar situation
> can occur when claiming is triggered via batadv_bla_rx. This patch
> solves this with a similar approach as for batadv_bla_tx.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

Whoops, resent accidently, please ignore....

Thanks,
    Simon
--nextPart4578013.rxioT3ABBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkwLuwACgkQoSvjmEKS
nqEdZg//YiN25+/sWwOGGCWQvn5h7j6eFe8WQmdkFKSdfE97i3DiyY2UCXswv0Pa
wmN4xfyRMn2k0dLFJxVXHuegKMbipVGJHQvwfdL4SBulgfxYi04TJAl5IGMyLKF6
BKGzK/SNSTZdV+lNHHEjpWHNk1y4ezfmKHfu8cUFempHJ9vXFzYnPoZnyfnpDch/
xbokXlKXjBBc+92TZxO7lRLgwlEe3BjnqPC+Q99ENV1rIyA5rza7Y7yZQlpwPWt7
pp1Yj6/52u+piBWyMmZoDi4UkpGy6mZ8LjIdN/ZiXjk+TSVNMgYL9aNnpTYqCY7q
5K0juvSjzp8oSoxSs9bJfzvs9ZUero5Qb/SvrxySjvt2UwWNRm0N6ZNvthXGU/3N
t+tr8dsA5KI2zmqP6JwnNMqyfA8qgE9ts9g6OVSNhvsNcOFLdx9M4B44ARS/1g6d
l3iC2W2rdgkIgX7ROhmooeS72R3JucE7A5Ee4h5hez/vgg5gevqD94NhuiZqld8Q
ca4kl1rzvP1Jsu9ufXpeyom/DS2/pdWnVH54tUn2lTyVtCN0itYcSKo9yRZ4pleF
FzH1i+pCFF1IaOL3wKR6k8Ua71ACnJFzZz9nCYtYjN+mDzBp0Lh0gqXg1YAGQy9X
Cyc0vlGoCDZdKroHxPZCg0RX2mYuYDCCKG74Va2QWwP/37KDm9o=
=ZrJB
-----END PGP SIGNATURE-----

--nextPart4578013.rxioT3ABBc--


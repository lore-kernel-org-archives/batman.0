Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 01 Apr 2019 11:59:17 +0200
Message-ID: <7264236.pZJWJxn9C4@prime>
In-Reply-To: <a5949349-69fa-7ef5-fd78-88af76749e24@gmail.com>
References: <a5949349-69fa-7ef5-fd78-88af76749e24@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2869393.WrYQOEHlWq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] About making batman-adv mesh network invisible
 (by encrypting Beacon frame)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Xuebing Wang <xbing6@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, hostap@lists.infradead.org

--nextPart2869393.WrYQOEHlWq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Xuebing,

at least for Ad-Hoc mode, you can't hide the SSID without changing the kernel 
driver (mac80211). Encrypting the beacon doesn't help here, as the SSID needs 
to be clear text eventually even if management frames get encrypted.

Cheers,
       Simon

On Saturday, March 30, 2019 11:50:27 AM CEST Xuebing Wang wrote:
> Hi community,
> 
> We have batman-adv + OpenWRT + ath9k chip + ath9k driver reliably
> running for about 2 years. The biggest batman-adv mesh network is with
> 100+ nodes.
> 
> As this is a closed network, we have a new requirement which is to make
> our batman-adv mesh network invisible, although the current SSID is just
> some meaningless characters.
> 
> One thought is hidden_ssid. But, it seems hidden_ssid is only supported
> for AP mode (not IBSS mode).
> 
> 802.11w does not protect Beacon frame (because it is before four-ways
> handshake).
> 
> As this is a closed network, what about encrypting Beacon (maybe all
> management frames later) using a hard-coded key in wpa_supplicant?
> 
> Thanks for your help.
> 
> Xuebing Wang


--nextPart2869393.WrYQOEHlWq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlyh4PUACgkQoSvjmEKS
nqHPZw/+Pc5rvlz+3wgw6qoTsaCgcK6Gej6yd2W2esQcLyJbRPUuQ85Npqguds8H
n9ur9ziBv7g07h24VD6aEJg2/jdfHqc1OFi4j3zssbNDjokB0CDaWFovhRbpTrEB
VAd9VQ8FyGIIHfo8IJ9qdgXS6Bsdr1+yRhqLK53Eqz9v6pl/wBLd4/mxu9ty82z/
TtpKwlx5G7lPIru4R3vrdQfsD2UE766eNifCVaPkKrRue8w3DEwS+Q+k91IfOv4X
SLQe/xRTseEKFOHXhDeqmWjLIOEGrl+7t3B4D3k8QonQsADM6EIAUkGPlJldnRT7
/OTAzkGcI5HfrecK5jItn5EWWO+3qEbuChd3Ug+/n3t/Fk4N4Rfe67kgvq6ePM2j
ZxYNXcITiOlIVYu8IBZJsPdQ+YV0oI+P6H+VXBHyiUsANXYxJYFo3Mf4pItA8Xqy
jIK7dBV/mNqd4noU1lakCb1qBFeO04zqUgn0rOtXcWXYH6kKuswM1INvCoPThrtV
m5YjnX0FAN6qMT8iDqfRuJrgNovTJA/fEaoGRmSGM0huhEMIfBtSEutvRTuVVB2Y
AWY7Q0GoWHFQC+PE4paxqn7nqN+8xCkzr0R4n0bMV+3VbbwbzN9GHAe8QPup4uOH
Mxpckmb4JFOvpq3GFZc99DPYCUu+uXo/N6D/etUjU/49SXY0fxs=
=REAl
-----END PGP SIGNATURE-----

--nextPart2869393.WrYQOEHlWq--


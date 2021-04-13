Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: Problems with Multiple Interfaces
Date: Tue, 13 Apr 2021 13:53:16 +0200
Message-ID: <6830943.IaFvOplyQc@prime>
In-Reply-To: <20210410003953.1234.9147@diktynna.open-mesh.org>
References: <3542676.qYy7ulQ77K@prime> <20210410003953.1234.9147@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart44955799.Kctvcl01Cc"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: joe@careyhome.org

 
--nextPart44955799.Kctvcl01Cc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, April 10, 2021 2:39:53 AM CEST joe@careyhome.org wrote:
> Linus and Simon,
> 
> Thank you for your responses.
> 
> I did try "batctl ping" and the adjacent device was unreachable.  I could
> see it with "batctl n". I did not try a simple IPv6 link local ping. 
> However, I could see it using "iw dev mesh_5g station dump"
> 
> I agree that it feels like a problem with ath10k reporting the data rate
> incorrectly (or not at all).
> 
> I am going to try upgrading to the latest release, but it will be a few
> days.  I'll let you know how it goes.
> 
> Thanks again,
> 
> --Joe

Sounds great! You may want to take some more measures to find out if the 
packets are actually getting transferred, e.g. doing tcpdump on both the 
sending and receiving side. If you see packets sent but not received on the 
other side, you know that it's a driver issue. Also "tcpdump" helps. For 
ath10k, you may want to try 11s/mesh mode with TTL=1, while with ath10k-ct you 
may prefer IBSS mode (I think that wasn't mentioned in your first mail).

Cheers,
      Simon
--nextPart44955799.Kctvcl01Cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmB1hiwACgkQoSvjmEKS
nqH7CQ//Sx9u/hnvcXuJu8P0Ga4KqXrVqk9ZpFGQVkJAmyWRopMYlisWsdQAA7On
PzxUnwvzMnyeOdddJNnBy9reVUooGL45/Blegbu3koH2CvYM/zMSNsarN1C7k1uE
N17Hta/068iu1kdxMnR++s+CwMEQH6QUyk94Y626xycwLWLzGAMlLQcAFKaOty6f
qjkNT7wc33p6m53TnZc+AkNM37VAjZR2f31KP4UpJr6ikFK7sU4Y51TYSbkcSkCx
W1NcsacnpaguPk1INOmc9z+3oFxnZhVobfNSmoiO5VT2Tf0yUxT+K8QoalnZOEll
gjgrKZsJOOtG4JaXhgzxNb6pqSkgmWs/6zn1N+dmlwGhKpbexbOfuoZgE/XIL+Nl
oirEO2VZwDrZGBnlz4RVUCDKBXFc8jbGgO4hstFUI9kZfi3RMIwD/oAg3r2+lXCA
Fi8Fza5t3UWE8+N89r6cUgHYLFQxBzjbGCwMpQr8hqvFhtBsUNjEHYycx5tFHrLG
+DFT2bDGGaG332ijPs4HZ9QxAWvlVnblWxRwZDVSGDQpaicOfqqp8+skFeiob+1T
KcrrDrkRemFbd2GLZfdlbRl2AzW9QlPOwrYRH+kOtP5YfFgQQ8Sa80cJ1U+vq/Lt
c4Htav9MYvcZ2mY0zSavle1nnzx9ltEyNCt/xsj7rti6kAdpyRA=
=4mOQ
-----END PGP SIGNATURE-----

--nextPart44955799.Kctvcl01Cc--



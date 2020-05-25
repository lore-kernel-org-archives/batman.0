Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Network stops passing traffic randomly
Date: Mon, 25 May 2020 15:22:35 +0200
Message-ID: <2567784.gV1U3syDZD@bentobox>
In-Reply-To: <CAL3ir7+RWLrYOzjNQh1VwiKg1sxSgHZMwwqx=9xSfXFnFjE_KQ@mail.gmail.com>
References: <20200525083512.832.13419@diktynna.open-mesh.org> <32459667.Id32LJz2i1@bentobox> <CAL3ir7+RWLrYOzjNQh1VwiKg1sxSgHZMwwqx=9xSfXFnFjE_KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3978634.na8LbQeXfl"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Daniel Ghansah <smartwires@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart3978634.na8LbQeXfl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 25 May 2020 15:19:22 CEST Daniel Ghansah wrote:
> Hi Sven,
> Yes I did ping via the IP, there is no response, I am using IPV4

Ok, when your underlying layer (mesh0) is not working then you should not 
expect batman-adv to work.


Btw. the `batctl dc` output doesn't look like your tested the IPv4 ping
on mesh0 but on bat0 - not what I've asked for.

Kind regards,
	Sven
--nextPart3978634.na8LbQeXfl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7LxpsACgkQXYcKB8Em
e0Y0yhAAlTYTug2ywa55d7AFRBnJuITswGs6JdiDNRfMpflk5Er/tOsV2smHyAgk
dlOzKBZ8mjYWGx0WgTuho6f72RCBamb2hR+8554R8AVMhJgsVkfKQ2apdB/GqYF9
HMPSClzIYPUvIkQv37FocLht/c7MkNlHFumMnyz3VDPYFcbZnrKA9QKRMutXGSoX
6+ei4mSqd7ArVwoDJdkSkdSaaASAGCa1HBzniXqIfRohdvPv4jSYnl4spZPTWVhD
lznaRpkrX4hRZOiUUSuTy+c/W85MVDYNxopqoon8MB90AvQt0Uvbhpx+nGLZHuoV
LwIlJQ3eNFNj0BMD/RliC22wqJwK9OAMd10mIMpchXPe0h5VaXNWXIsLbXbtOlf/
W/5OuK4IiZ8c3ZV5aheCcGVWi0YStdQ/Y2ylGmloQSqKNcPNY9ISDopo5COaj3uQ
2uiUs8Li7VcHV5ixZw5GSKmzcTz27wNGRf4t7Un4/EMgUqsAW8jPN+L9W7d74PaH
N16rZl5lGG4pHGAUidFzvDhVyKDMAMpCBumXa64Q7gQrDq4YuOSwaS9A3Kcc8RrM
MC++Tlcf6MAUt9kry/gNV32csiERwLZyiB3a97yYDciww9h45S5J52WxLQNvVMWd
SNxEgvUHgtQjmWZd29W1QvYon5BC/w0VbMYmW3kq0fpBXzBTTjA=
=RCLK
-----END PGP SIGNATURE-----

--nextPart3978634.na8LbQeXfl--



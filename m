Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Dec 2014 07:45:36 +0100
Message-ID: <1932663.nroHeCQuqZ@sven-edge>
In-Reply-To: <1417383237-15348-1-git-send-email-sven@narfation.org>
References: <1417383237-15348-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2110829.krEBcMtU21";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Check total_size when
	reassembling fragments
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart2110829.krEBcMtU21
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 30 November 2014 22:33:57 Sven Eckelmann wrote:
> The fragmentation code was replaced in
> 9b3eab61754d74a93c9840c296013fe3b4a1b606 ("batman-adv: Receive fragme=
nted
> packets and merge") by an implementation which handles the queueing+m=
erging
> of fragments based on their size and the total_size of the non-fragme=
nted
> packet. This total_size is announced by each fragment. The new
> implementation doesn't check if the the total_size information of the=

> packets inside one chain is consistent. This allows an attacker to in=
ject
> packets belonging to the same fragmentation sequence number with vary=
ing
> total_size information. The missing validation can cause a crash when=
 the
> fragments are merged because the total_size information is only retri=
eved
> from the first packet by batadv_frag_merge_packets. But the queueing
> function batadv_frag_insert_packet always uses the total_size from th=
e
> latest packet to check if the fragmented packet was transferred compl=
etely
> and is now ready to be merged.
>=20
> Assume two packets with the size x and y.
>=20
> 1. first packet (fragno 1) is sent with a size x and the total_size x=
+y' (y'
> < y) 2. second packet (fragno 0) is sent with a size y and the total_=
size
> x+y
>=20
> The fragmentation code would try to merge the two packets because the=

> accumulated packets have a combined size of x+y and the second packet=
 was
> sent with total_size of x+y.
>=20
> The fragments merging code only took the information from the first p=
acket
> with the total_size x+y' and created a buffer with enough space for x=
+y'
> bytes. But the second packet cannot be copied inside the prepared fre=
e
> space because it is y-y' bytes larger than the remaining space.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>
> ---

I think this patch should not be applied to maint because parts of the=20=

assumptions in the commit message are contradicted by
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-December/012609=
.html

Maybe I will prepare a v2 which is for master and not for maint. It wil=
l not=20
have the "omg, we will all die" scenario in the commit message which no=
 ones=20
seems to have checked (and ended up to be wrong). The main purpose of t=
he=20
upcoming patches would be to remove the skb parameter in the merge func=
tion=20
and make sure that the sizes are checked before the queuing is done.

Kind regards,
=09Sven
--nextPart2110829.krEBcMtU21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUfA6WAAoJEF2HCgfBJntGvnUQAJeEetmiw4JbByi7NsUoRWJJ
GwvToqoRTQ2mx32DLN3x97Re2Nc3rdLoHmfhcHTjYI6QOisMjIwo59cxThkJMjHA
JFl2enEkLED9Sr71jEF0sdN3Wu2KsOZX+8Bcg8QRnMtHbKotcSZO/cBfXuK4SWtS
baey8jV6KRwWwvywVzGvIAp0Cq3hJYQBemIB98Qv8QOGCJCwGSfDUJGtVhshQOQj
V0HYtJxrqTuYefS1QIzbLzYKfvVhzQ+m54Ezs6yNFKLmKBopGcG3dbBLOCCFTbtm
qj7RdHX5IH4wS1QEVLBYUEBbGsmpGQqT7MWRNzz33kMcFfPIIsmp8ewfl07ePyZT
5Ui1hPuN6YtfrtgwIvE8xwErV97e+bzdXCJTVIk1Mg/LHK4J48HOdx2haLwsVaxf
KeyI0FMRj8v3YNDnzkHU7sXW27ru5TEUqNGupizjhDLOfUPzXD8k2e9bWfbNVfVf
JRijM1IZJrouRBu6uJqoNprdvjv7OM2UUqs/tQtRn0PS3knyOA/q5dmtGOIRdYki
i6tJ21jDTVPyPs9hPsE+vr1y370xpVGn1SezR8gp/0nZJ01vCmhSRc9U+QNu6lTN
uT4boNq/S3VA0X8mWcI/jpuJjE6ulD+RGY/jJta+5qjPjUvz9D+b4IkD76RijNTs
B2YJ4EluHq2YaVMOf9Mo
=z/GU
-----END PGP SIGNATURE-----

--nextPart2110829.krEBcMtU21--


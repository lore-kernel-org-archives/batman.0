Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 05 Mar 2018 20:28:13 +0100
Message-ID: <2010709.fvC8HbtXRd@sven-edge>
In-Reply-To: <b0d20913-2ee7-499e-02b6-796d542c5951@gmail.com>
References: <b0d20913-2ee7-499e-02b6-796d542c5951@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4202079.LQ3ES6GMtR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Questions about hardware
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Paul Becue <paul.becue@gmail.com>
Cc: dries.berckmans@soundtalks.com, b.a.t.m.a.n@lists.open-mesh.org

--nextPart4202079.LQ3ES6GMtR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

[Please try to not contact me directly when it is about B.A.T.M.A.N. relate=
d=20
 things and at least Cc the official mailing list]

On Montag, 5. M=E4rz 2018 19:04:29 CET Paul Becue wrote:
> We are working on a device with a mesh network. We are doing tests with=20
> WiFi ad-hoc networks, and we tested last week BATMAN-adv and also babeld=
=20
> on a Raspberry Pi 3 with a Ralink dongle attached to it. The results=20
> were very good.
[..]
> Could you give me some hints where I have to look for hardware and what=20
> kind of hardware I have to look for? I have the impression that there is=
=20
> something that I don't see in the whole story. I hope ad-hoc WiFi is=20
> still a technology that is up to date. Or is there a technology that=20
> replaces it?

Yes, IBSS is becoming a problem at the moment. You can try QCA ath10k hardw=
are=20
with Ben Greears firmware [1] or Mediathek with the mt76 driver [2] when yo=
u=20
want up-to-date HW. There is still some ath9k based stuff around when 802.1=
1n=20
is enough.

Otherwise you might try to replace IBSS with meshpoint interfaces. Just set=
up=20
it like 802.11s but with forwarding disabled [3]. This works at least with=
=20
ath10k based HW and the official QCA ath10k firmware.

But HW which uses ath10k and other things which uses special firmware which=
=20
prevents you from using your "own" rate control algorith are a no-go when=20
you want to use throughput based metrics (as in B.A.T.M.A.N. V or olsrd2).=
=20
Then you should stick either with ath9k or mt76 compatible HW.

Btw. my tests of mt76 showed performance and stability problems in the past=
=2E=20
This may have changed by recent fixes in the driver but I don't know the
current state.

Kind regards,
	Sven

[1] https://www.candelatech.com/ath10k.php
[2] https://github.com/openwrt/mt76
[3] http://openwrt-devel.openwrt.narkive.com/Bieu1aRR/ath10k-mesh-with-open=
wrt-question
--nextPart4202079.LQ3ES6GMtR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqdmk0ACgkQXYcKB8Em
e0bmbRAAiIph3bIc0rs3emC6O+9ZvEjBwg+j5R+Dv9qZpQc6dCPMAo4eaUWtTpJz
R26VZazvPkaXEs455VNb3KaRXkb0VyfezPMegH8rpUjS4MMESbsRkAadDeLxTQU4
f/T5kFwj9WyPPquNGqOUY9ejAp0S6o9CNnDC9YXF8ai5iSbOVHaJrQFTsnuIu+p7
qsJGWywqr8n0DFYbIv3Cw86kLQvEFJbspHTjIxLgpnMgpsQYuJgFjBAwRGYpIeUu
GWwc2QsT9rhvlVLs0d+2IuvoVp3ziSCUfsKdI0b7oTZlSGUDbiNPfHUe4izia+BC
WxBPUiOcNO379MdnsKghptJs9gzGXabErIpVjAnDgBN8KrdnenhqaHJwsRlXrg0A
RIw5QLU6XxzYL0oDR8Kh3qVO0H3DysXGBNnjurouY9mYnOmxaGIGLb9jLdmik80I
v/uG8BEv1/5Tqn2KPfk+AlulaL/xGYKT3ADowRVG0zdwjNXV+fKyW5p3N+vTh9Bx
Ox2D3F6Zn4b1/gNxgp5F9k1jEnitlJIF1bk3LAhK84FQlxOEfcM/Arowy2hEOsoq
6dGYlOPDQAMe5fhcWhtGi6WOPZLV8hYKT+CKzxKKmG7O8dNDg5bLYrMAiYiXU013
b6p3YM3cvbDB42FGYHJu5tXA/FdTG4gaOw1Rtqa/EX7PSnnxNfI=
=Ib7O
-----END PGP SIGNATURE-----

--nextPart4202079.LQ3ES6GMtR--


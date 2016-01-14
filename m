Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 14 Jan 2016 18:05:44 +0100
Message-ID: <1876702.MVf7ZKuccf@prime>
In-Reply-To: <ff54fe803c7c44eda0b860c69983c5d5@W2K1204EX.c2t3.local>
References: <ff54fe803c7c44eda0b860c69983c5d5@W2K1204EX.c2t3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2005982.fT8gp6nptV";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Need help bridging Regular AP to Batman
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

--nextPart2005982.fT8gp6nptV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Andre,

On Thursday 14 January 2016 16:31:08 Andr=E9 Pouliot wrote:
> Hi,
>=20
> I'm trying to do a mesh network using the RaspberryPi and Batman.
>=20
> My problem is I'm using 2 wifi card on one raspberrypi one for batman=
 and
> the other one for connecting to my wireless access point.
>=20
> I already made my mesh network I can ping on layer 2 or 3 between 2
> raspberrypi. When connecting the Ethernet cable(on the raspberry with=
 2
> wifi dongle) I can use the bridge to ping toward the internet. But wh=
en I
> disconnect the cable I can't ping internet anymore.
>=20
> I already verified my batman interface and my bridge both seem to wor=
k

You are using your second non-mesh WiFi card (wlan 1) in client mode, r=
ight?=20
You can't include client mode into a bridge, because a WiFi client (nor=
mally)=20
does not support bridging. Actually your system should prevent it ...

>=20
> The AP is connected on wlan1, wlan1 doesn't have an IP address assign=
ed to
> it. The AP is configured with WPA2. When trying to assign a address u=
sing
> dhclient to the bridge interface the system can't seem to find a way =
and
> the command is waiting.
>=20
> If I want to connected my batman network to a standard wifi AP do I n=
eed to
> use a bridge or the functionality exist with batman?

If you want to connect your Raspi to your WiFi AP, I see the following=20=

options:
 * Use Layer 3 Routing and keep the WiFi Client
 * Configure your Raspi as AP and your WiFi AP into client mode (if it =
supports=20
that)
 * Connect one of your Raspis to Ethernet and don't use the WiFi AP at =
all.

Hope I got your question right .... :)

Cheers,
      Simon
--nextPart2005982.fT8gp6nptV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlaX1WgACgkQrzg/fFk7axawPgCfWrWNbo/4HGX83BYNd9Zz6cGS
uiUAoNde/+ljYcXURPF8Too4Hcoxev4i
=gnzT
-----END PGP SIGNATURE-----

--nextPart2005982.fT8gp6nptV--


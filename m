Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Dec 2014 08:49:34 +0100
Message-ID: <4472936.imSdHEx948@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1896525.BSymqLgUTY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Fragmentation and padding in batman-adv
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>


--nextPart1896525.BSymqLgUTY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I've just noticed that the padding by the underlying network protocol seems 
not to be handled by the fragmentation. Maybe Martin can correct me. I will 
now use following assumptions:

 * the fragmentation code is sending first the last part of the packet and
   tries to fill the complete skb (max 1400 byte)
 * the mtu of the underlying device is 1400
 * the minimum packet size (user data + eth header) of the underlying device
   is 70
 * the packet send by the user would end up to be 1401 bytes before
   fragmentation

Ok, then I would guess that the fragmentation code would try to generate 
fragments with the max_fragment_size 1366 (+headers of course, not sure why 
the code assumes that the ethernet header is part of the MTU). This would mean 
that the 1401 byte packet is split into a 1366 byte fragment (+header) and a 
35 byte fragment (+header).

But the 35 byte fragment containing the first part of the packet is (even with 
the headers) still smaller than the required packet size of the underlying 
device. Now some extra bytes are added as padding to the last fragment 
(containing the first part of the original packet).

The receiving node cannot merge the fragments anymore because the length of 
the last fragment skb will be too large and therefore the
total_size < chain->size.

Even when it could be merged (because of some bug in the size check) then the 
resulting packet would have a padding byte in the middle of of the original 
byte.

And just in case somebody has something against the imaginary 70 bytes padding 
(802.3 has 60): I had to work with virtual devices in the past which had a 
fixed MTU of ~1400 and a minimum packet size of ~1400.

And yes, I am fully aware of the workaround of using an extra virtual device 
between batman-adv and the actual device which only adds a header with the 
payload length and restores this length on the receiver site. This (or at 
least something similar) was used by me in the other project with the MTU/min 
packet size of ~1400 device.

Any comments, corrections?

Kind regards,
	Sven
--nextPart1896525.BSymqLgUTY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUfB2SAAoJEF2HCgfBJntGS70QAJtzDLSvCOMJS7KvKWnGSexD
74Cc26gtHyGoH/msWoOm8g5bpb6Q1N7GCY1zkd5YmdW4vgS4UwF+LPljn7GZOOq9
00nLommdOEt7uYxxMV2HvAwLLY838V7TI8OVRMa5bUFahD3oonR5/uZSQ1Iy0Gri
Vbip8Rg6dIl0uzVq2Lj22nMZ++QmXXtEeCLmu0ohaQU8XkYnhRvUkeTPqSbA0dzu
6nQ4MtIYmN1Zp62+ojnH0LIt+V74CDGS8V0stgzP46sxVxCmLN79p7ssaOsxqRiy
uZdMrgnCBdgsuxBB1V3y6PYTdbd0PZrbsa42TDoX6XMMceBOQnye5umoN/k/Z4yz
83ua4q1IoTrn6btQCAlVc6f4sIDmuSPcW3kdMmoaquO/NGEPqbE7bn/TOpSX+2IS
9baZ12EmC1tEEjM20r9L+EVnr+rAoZm2t0T06c3EZD8iZDjwh0WydGhddou6uYrx
2VDJuhUMR+3841LCiB4Ie/exaPranPp13Nbyb32+G+PGNeKH0d8WmY7xTf/3FGcA
yj5lvbrkx9qgPtyUzylOLdfCIYI7vyY42y2SBBQzePmK6NYzkuPl3KrNxyBSIcMv
uhpsg0yTCEkZ448IAVf1b9ndZp17tFOSFxIA+XnDNWPnd0yRkvCv2S3qXOU2kXO4
RJ+lXXYhmSWtHNG1mU12
=79RS
-----END PGP SIGNATURE-----

--nextPart1896525.BSymqLgUTY--


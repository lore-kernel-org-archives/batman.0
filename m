Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Aug 2018 15:20:16 +0200
Message-ID: <2117465.v8Cqqng2MF@sven-edge>
In-Reply-To: <20180831130844.5434-1-sven@narfation.org>
References: <20180831130844.5434-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1714210.kr6FJ4U4oz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Avoid probe ELP
 information leak
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

--nextPart1714210.kr6FJ4U4oz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 31. August 2018 15:08:44 CEST Sven Eckelmann wrote:
> The probe ELPs for WiFi interfaces are expanded to contain at least
> BATADV_ELP_MIN_PROBE_SIZE bytes. This is usually a lot more than the
> number of bytes which the template ELP packet requires.
> 
> These extra padding bytes were not initialized and thus could contain data
> which were previously stored at the same location. It is therefore required
> to set it to some predefined or random values to avoid leaking private
> information from the system transmitting these kind of packets.

I was just able to extract (passive) real information from a system using 
that. Here is some example with non-compromising data:

    15:14:32.930238 02:ba:de:af:fe:01 (oui Unknown) > 02:ba:de:af:fe:02 (oui Unknown), ethertype Unknown (0x4305), length 214: 
        0x0000:  030f 02ba deaf fe01 0000 0000 0000 0000  ................
        0x0010:  6574 7479 206f 6e20 7474 7953 302e 0000  etty.on.ttyS0...
        0x0020:  0200 0400 1080 0000 4143 5449 4f4e 3d61  ........ACTION=a
        0x0030:  6464 0044 4556 5041 5448 3d2f 6465 7669  dd.DEVPATH=/devi
        0x0040:  6365 732f 7669 7274 7561 6c2f 7474 792f  ces/virtual/tty/
        0x0050:  7474 7973 3200 5355 4253 5953 5445 4d3d  ttys2.SUBSYSTEM=
        0x0060:  7474 7900 5359 4e54 485f 5555 4944 3d30  tty.SYNTH_UUID=0
        0x0070:  0044 4556 4e41 4d45 3d2f 6465 762f 7474  .DEVNAME=/dev/tt
        0x0080:  7973 3200 5345 514e 554d 3d31 3836 3500  ys2.SEQNUM=1865.
        0x0090:  5553 4543 5f49 4e49 5449 414c 495a 4544  USEC_INITIALIZED
        0x00a0:  3d32 3237 3830 3933 3900 4d41 4a4f 523d  =22780939.MAJOR=
        0x00b0:  3300 4d49 4e4f 523d 3530 0054 4147 533d  3.MINOR=50.TAGS=
        0x00c0:  3a73 7973 7465 6d64                      :systemd

Kind regards,
	Sven
--nextPart1714210.kr6FJ4U4oz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluJQJAACgkQXYcKB8Em
e0ZICw/+Jl3oVg5gN3B3W2abth2tvm2sUBRh8/NKTyKW1hUAYzOUO43BU1El/8mU
JqrUyFZInds5dvqM7A1G1Kl3kJLxfQuVE/mAxczG44FoW+gT/4kJ1cSfCJ1ZaXFv
qZv6G0lKfvA3tBDsGMugLmtt8mWh4qkAGCp1PhG9p3BuMklQF+v5YBoDF9tc4Wj0
ChIUjAbKbtTGa3NWazyrU9hhEMIHbqSyC5qUrGeyfdKRIyrmg7Xbw4Gt2kaAv4g1
zHrJGnrAz2yZ4LnfivBkjs3wfMQ6i2LgBkh+6/3IjvpACnuOIt1TKiqcFMGUR5Pz
TzxmRGwA4xfR9YP/yi8sj3HluwZtnDIrgT31fBPz33E5tPRMUdaderoDmZrrA5PP
5Ku6JuYah4z8ahTjJxtM/32mdMf+PO8LEESWwgBuvdQwxkpa1EwGxTDjDNj9LHyC
18GBpz5f1j/+1ShkjMzY9RMfKBypC7lsya7dp7rB2AjywVRLji7Lht9yaVcCb7Wr
bF/2fqxDX3eTJ1IJSTvmdsBILyVCjLHY/h49u0xwrnV3Ru55/1Ci6l6vc+E80sRM
+8hryHKWLgeBqmuYzQPVsoQZXaNRiDZ6j8VXHErNUkWEPP8ehx5h5Mt+vudAkYmm
3wJ4VnPkR2dziKgvjtR+c+bu0I9Hn0k3JordP0NFoQ/yOxYCWng=
=0G4n
-----END PGP SIGNATURE-----

--nextPart1714210.kr6FJ4U4oz--




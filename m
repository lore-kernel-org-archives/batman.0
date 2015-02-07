Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 Feb 2015 08:27:29 +0100
Message-ID: <54743686.1YRlhzGWHK@sven-edge>
In-Reply-To: <54D4BF9C.5010409@meshcoding.com>
References: <1423153373-17033-1-git-send-email-sven@narfation.org>
 <2688831.HMc8mZG1gy@bentobox> <54D4BF9C.5010409@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8324965.ScaOfvSGbS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use safer default config for
	optional features
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart8324965.ScaOfvSGbS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 February 2015 14:20:28 Antonio Quartulli wrote:
> To me this looks like the caching effect of DAT: bat0 is likely to
> change MAC address everytime you recreate the interface (unless you
> statically assign the MAC) therefore I presume that the other node (the
> one which did not reboot) was still caching the old bat0 MAC address
> (each entry requires some minutes before being invalidated/refreshed).

Thanks for the explanation.

So you are basically saying that DAT cannot detect when some nodes found a 
conflict in their ARP table (when receiving IP packets with a different MAC 
for an IP or similar things)? And there is also the problem when no local 
information is stored and only a conflict with some data data on another 
unrelated node is happened.

The first conflict (the conflict in the local ARP table) is not detected 
because David wanted that batman-adv isn't accessing the ARP table?

> This means that any communication willing to contact the rebooted node
> was targetting the old address and therefore the two were not be able
> talk until the cache was refreshed.
> 
> Can this be the case?

Yes, unfortunately I hadn't the time to analyze it further and have no logs of 
any similar problem. Thats why I cannot check if this is contradicted by 
anything I've done (or not done). So it is a very plausible scenario which 
you've described.

Maybe Marek can tell me more why he chose to disable it.

Kind regards,
	Sven
--nextPart8324965.ScaOfvSGbS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJU1b5pAAoJEF2HCgfBJntGIVoQAJvtUb13HmbTUfnjWV9DkX0Y
eWL3NdhpPl03+njtCK/s0Yj4eFLdjCNTg5nvApC0baR36V8V8ezh1t1FTEMh098z
OO2wDptOb+TyZT4oz3UkOBaxq3VXJtRYzS2q+KRONpCJG0jxz0urv24mqVssFaqk
BwJfVtX/LOf5weUFs3ltmJ/YTo/6j/IW8soA/YgwfuB7DdS8Grk7PR3BAzEpjfnV
O3zjhq7fmLF/QoiVFrCdkxRGSqjaMuY/EsaEANPAdGi0xNgESKJiTEabKyB3JiMk
SPsC943iTYUGQH8q7K9aaR3RSqJDvAIizIW8Nt0028t9AEF5cTWDb3qZpOMWDRJT
WacX5ooip7ZIBmwNKVBr5MNC/ERnuUG7mb0HomTHMhevBG/rwRPjUyTyeDDnAz1a
4cT/BpvfrHaJxhPROkFwwRGjLK4lYCxvyB0htzcp1bXSZ1baWOThXTQ3zIzlgCGN
mveA8J5ZsL7FcFXt7UcOvk9BhiaHZY5k3QUqVG8fmrVPksKrpvZHi3lkMFHCCOEg
rz3KdX2Kcdl8Y/5BoyOfeCly0RMeLSECUaKgxYgz7cHcrqjsySKJN6sBP8EqvP6W
UGjVR5EMBrjGt971hi/vF7mKNSTksih+tvserPEjbNUX3MuW/kEvZDtO5A5h54OP
kDiVLyoWBo+xaU2D+6fX
=7dF8
-----END PGP SIGNATURE-----

--nextPart8324965.ScaOfvSGbS--


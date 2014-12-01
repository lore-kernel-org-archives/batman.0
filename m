Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Dec 2014 14:31:05 +0100
Message-ID: <10739765.2rCRvcyX7s@sven-edge>
In-Reply-To: <4472936.imSdHEx948@sven-edge>
References: <4472936.imSdHEx948@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5251359.KzN9Xk4nOD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fragmentation and padding in batman-adv
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>


--nextPart5251359.KzN9Xk4nOD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 01 December 2014 08:49:34 Sven Eckelmann wrote:
> Hi,
> 
> I've just noticed that the padding by the underlying network protocol seems
> not to be handled by the fragmentation. Maybe Martin can correct me. I will
> now use following assumptions:
> 
>  * the fragmentation code is sending first the last part of the packet and
>    tries to fill the complete skb (max 1400 byte)
>  * the mtu of the underlying device is 1400
>  * the minimum packet size (user data + eth header) of the underlying device
> is 70
>  * the packet send by the user would end up to be 1401 bytes before
>    fragmentation
> 
> Ok, then I would guess that the fragmentation code would try to generate
> fragments with the max_fragment_size 1366 (+headers of course, not sure why
> the code assumes that the ethernet header is part of the MTU). This would
> mean that the 1401 byte packet is split into a 1366 byte fragment (+header)
> and a 35 byte fragment (+header).
> 
> But the 35 byte fragment containing the first part of the packet is (even
> with the headers) still smaller than the required packet size of the
> underlying device. Now some extra bytes are added as padding to the last
> fragment (containing the first part of the original packet).

The calculation of the fragment sizes was unified in patch
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-December/012620.html

My knowledge about the fragmentation code is now a little bit better and I 
have to correct the numbers above. The max_fragment_size is now 1380 (after 
the patch). The split of the 1401 bytes packet would be 1380 bytes and 21 
bytes. The size with all headers would be: 1414 bytes and 55 bytes. 55 is even 
smaller than 60 (minimal 802.3 frame size). Therefore, splitting packets into 
fragments for 802.3 devices with MTU <= 1400 bytes is problematic when the 
batman-adv packet to split is larger than the MTU but less than 6 bytes larger 
than the MTU. For devices with 1400 < MTU <= 1405 it is problematic for 
batman-adv packets larger than the MTU but smaller than 1406 bytes.

There are even more problematic situations possible when the batman-adv packet 
has to be split into more than two packets.

Just for reference: An unicast ethernet frame (with ethernet header) of 1514 
bytes would end up as batman-adv unicast packet of 1538 bytes. The underlying 
device must have at least the MTU of 1524 bytes (The 14 byte ethernet header 
is not part of the MTU) to allow batman-adv to transport the packet without 
fragmentation.

Kind regards,
	Sven
--nextPart5251359.KzN9Xk4nOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUfG2dAAoJEF2HCgfBJntGJ5oQAL69qtOgDwZZZNXKnk0WZbBx
TSHKfJM8wnP375syWZah2XTCGArxTerxBf9VZsKghctTG1DTJjwQjbiw6NjEwyM0
S+VJDanaBdvHz9IkP/5qqlY6FxcfjJtCi9kElUBinvt92YxHOyRmTjIGLapiW3UQ
ySApW/Xs4H3pH9D2dPy7d0856tWt1sYgFsDXUMUgaE+RB1rQfmjtJEzHNCS9PDUH
VnGqyYd6kdWOJeRXXokLRuQdPDMe8Aglc6vqa1LaBvljgtLlyUw9WgGD7ZokCk+G
Y6D+KThAVy68oAN2u3YqhM9vqtDljUg+Cjjslss/zQl2m1yjf8qwHhHDRCr6uxzK
jeW/GDV1QvyLfk3ADB/ya5nQ8TzDFlgZOstIISu88RYMeZS+DpqDz/xVYADyuHTq
viptp+FNLCgHWXu452buKm2QV/Qva8fjw2c1NtgVYbCuz5okQDUrl3vg2YmlOxeV
yHDq6iugX1a+j5jQm6dax4WzWmZX4APfuiLWhoPUGhzcHAUXcpabupChQrVSke+4
sP5tSDbHK1/Zo5HTmGFzFXR1EOYp9eW1fdrh+dwCJ9IyJQDXQrzlXzDdea/Q9StZ
7CntMg8jzypFEMa4uTVMoo71BmxHIH5jTgz22JpDuifmLB8b2/M4Gp5ifSdGwGw0
/iWr8P5y7c27Ex1lc1rJ
=Ll0r
-----END PGP SIGNATURE-----

--nextPart5251359.KzN9Xk4nOD--


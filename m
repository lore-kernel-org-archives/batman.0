Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 07 Aug 2012 19:33:37 +0200
Message-ID: <1625636.DQU7MN2I4b@bentobox>
In-Reply-To: <1344359893.8678.YahooMailClassic@web162701.mail.bf1.yahoo.com>
References: <1344359893.8678.YahooMailClassic@web162701.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1496047.3QOahYWN1P";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] trouble setting up my mesh
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


--nextPart1496047.3QOahYWN1P
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 07 August 2012 10:18:13 adam wiz wrote:
> I am having some trouble setting up batman-adv for my mesh. I can get each
> access point to see the other using "batctl o" but I am not able to route
> messages between my client devices. I think there is something wrong with
> my bridging.
[...]
> In setting up batman-adv, I run these commands:
> 
> sudo modprobe batman-adv
> sudo batctl if add eth0
> sudo batctl if add wlan1
> sudo ifconfig eth0 0.0.0.0 mtu 1528
> sudo ifconfig wlan1 0.0.0.0 mtu 1528
> sudo ifconfig bat0 10.50.0.x (x being a unique number for each access point)
> netmask 255.255.0.0 up

What brigde? I don't see a single bridge here. Only an ethernet device, wlan 
device and a batman device that contains both. The bat0 device has an ip... so 
I would doubt that you added it to a bridge.

I would guess that you wanted to do something like this (I just assume that 
br0 is already created through hostapd and includes wlan0... you have to 
ensure that this is done):

sudo modprobe batman-adv
sudo batctl if add eth0
sudo batctl if add wlan1
sudo ip addr flush dev eth0
sudo ip addr flush dev wlan1
sudo ip link set dev eth0 mtu 1528
sudo ip link set dev wlan1 mtu 1528
sudo brctl addif br0 bat0
sudo ip link set dev bat0 up
sudo ip addr add 10.50.0.x/24 dev br0
sudo ip link set dev br0 up

Kind regards,
	Sven
--nextPart1496047.3QOahYWN1P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQIVFxAAoJEF2HCgfBJntGfKAP/A543kpVOMrbF3VfsyQ6aVZG
tgAf5trER08FL5md18+u3K/Q89w1BwNJ3SY6tUFpqXo7jNZ+xecA6saDdREOvhLA
sKJYbnHyQbMlDXmHh2MTBiod0BebUrB1uIhmO/aKTwa3BR3JGewTyJnmwxdX62rd
TRwYLcMX10sCtXy5gg5a9dXfXrUUZBcGQUUfMatif7sSv8TcT/gbMHNkN8xH7SQI
UvXnu2KpOqZKFtirsFKFqGtPyrY1dU0Q3r5UsLUvBt0zJYm5UGn3+WOfgIpCCYIk
6GuGYkD/DU9DFqTH4oW/1qD0rW+QG6D3U6hmNBLAcoASHIDaWAyiew9CQvCbIKfL
wmtKWYEnRNXfcTsmlt5FjRdj+qRoHoQKG8QXkYlXPJcG/Op7jrgN5KtC2Ix2rspq
jNEUNXNYTdk5gWgFtMGBrKV6HAbV7jpWiyuT3a+RtjJlqH0vKnHxYLkmJCJr9q6V
jCG0A5KpX5M1kJBSUmnrPKorFgRT6r6mZEXOgcKGNYF302Y8o4CVNXMNb8htfqs5
j8GVCl5TAzrCDh3U5oiXr3uHzsjFpuqQjLxCE6VHm6P2tPE+4ABiNwmjtU4W3s6L
GXF7WiwlZvmdNpcBIqh2JNVIKBxnHgu9XbFhPCOJoYhpG9n3nrfMj8pNm7lhbJDB
fI5UlSssYX8vsK7b10Zh
=lAKp
-----END PGP SIGNATURE-----

--nextPart1496047.3QOahYWN1P--


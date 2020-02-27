Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Node AP's
Date: Thu, 27 Feb 2020 17:11:23 +0100
Message-ID: <5758265.JSquzJLQuT@bentobox>
In-Reply-To: <CANdV1hR-=nwrXkZTAh7C9LjW7MRbxEPeCpV4V7odiUV2dk0QcA@mail.gmail.com>
References: <CANdV1hR-=nwrXkZTAh7C9LjW7MRbxEPeCpV4V7odiUV2dk0QcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2279995.2Smy5gWWIt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Zach Barnett <zacharyc.barnett@gmail.com>

--nextPart2279995.2Smy5gWWIt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 27 February 2020 16:13:48 CET Zach Barnett wrote:
> I looking for clarification about the following question
> 
> How can I connect non-mesh clients to my batman-adv network ?

Bridge (easiest way) or route the traffic from non-mesh interface to the 
batadv interface (and vice versa). [1]


> Does this mean that for an existing batman node to allow non-mesh
> clients to join (I.E. cell phone, wifi camera, etc..), then 2
> interfaces are required?

Not necessarily but in most situation you want to use different (operation) 
modes for sending batman-adv and non-batman-adv traffic over wifi. But it is 
possible to use the same link layer interface. This is often the case when you 
want to use ethernet for transporting the batman-adv traffic and the client 
traffic.

Just keep in mind that you cannot directly bridge an interface and have it at
the same time as batadv slave interface. So you have to split this interface
up somehow.

For ethernet, it is recommended to put the batman-adv traffic in something
like V(X)LAN on top of the ethernet device.

Other option could also be to use a macvlan on top of the ethernet interface - 
your ethernet interface just needs to support promiscious mode for receiving 
and allow to send with a different mac address. Then you have basically two 
virtual ethernet interfaces.

But you could even create fancy things with veth pairs. Put one end in the 
same bridge as the actual real ethernet interface. And then add the other end 
as slave to the batadv interface. And then you can put the batadv interface in 
the first bridge. You should most likely add some ebtables filter for 0x4305 
ethernet frames at the correct positions. But I would call this
"experimental".

Just keep in mind that all the bridging will not work with client mode
interfaces (non-AP STA interfaces in infrastructure mode).

> For example, if I have a pi-zero W in a wooded area, and I want a
> camera to connect to it, then do I need to add an additional usb
> network adapter to the Pi.  One Interface for the Bat0 Mesh and One
> interface an an entry point for non-mesh clients.

I hope you are not talking about wifi usb network adapters. Because they are 
(often/always) quite shitty in non-infrastructure modes. And also often
shitty in infrastructure mode in the AP role.

But regarding wifi PHYs under Linux - they usually support multiple virtual
interfaces on the same PHY. Just check the interface combinations
information from "iw phy"

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Faq#How-can-I-connect-non-mesh-clients-to-my-batman-adv-network-
--nextPart2279995.2Smy5gWWIt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl5X6isACgkQXYcKB8Em
e0bHxg//TyF0wVGBO8GqVfvg/bYT9KlPNYMZif3p9Q+Q791JjU1iRu5cx560ZeCG
jlkLAWggTrwZu42YYSYh2zE8XD9pKPk4K8gzT7oc9lYNEOxjRTXiFu+6ub1Sh+KN
k4dSsBBnFlXMM5lHr1lklxiRw3S1qXs8Qv9t+0i5WtEaJdc1YZhuuYp0h2zZO5bJ
AxIieRju9WLe6FTNoJUOVrbjKHWcWX5DSMLpm3LMYkSxOAM1KOvWK59SYt84Nwh0
EMxkyWeepFvDkyFj0dl4GVGfbDAq2niC1G4KEb6+m+yR9YSgWaij/srQYgsFQ4a3
8uu7raUS6BQyPhT/+eGeZ5StXDuw59A2NKodlBCiSe6mtrGCTEjAdjiTtDSxfCmM
/WIWEr/KuN1ITEdDM4K/4j+Cj+LCq0kI/+oR3SjJVVwGULUhUDNnz21I+QjGN5UM
ZQneS7oQ1menYLX2SnEsaZEAtcLcMkCvRyvHhkWYoK1rRYyzwpt9vV0yirGTGIZs
5u1lMy4NeQMNi2ZS3LKlNi131VNpR1bu2XuI0xZhVEO9fQ+LJpmkgTwzJo60/MnQ
Hjeh85EnINX4KRi0gfiZcbWuBvWk/QHMOlBtksQ8dHWgmue81fCmbQltpAlp1d5k
7DmYuRuZc56f7mfHSmT5gSzvGqzdG47Giqg6yrpmDo0fKULfOag=
=V0ZV
-----END PGP SIGNATURE-----

--nextPart2279995.2Smy5gWWIt--




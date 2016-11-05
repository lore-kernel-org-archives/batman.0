Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 05 Nov 2016 11:14:50 +0800
Message-ID: <2562442.4W30obIVjL@lafayette>
In-Reply-To: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2611375.FFshLlMIPT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2611375.FFshLlMIPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

> I have take a look to the configuration of our gateways.
> Inho there are some points which are not OK,
> Broadcasts are rebroadecasted on a wired connection,

please note that batman's payload reboradcast behavior is unrelated to the 
batman gateway feature. The effect of the batman gateway feature is explained 
here: https://www.open-mesh.org/projects/batman-adv/wiki/Gateways

Rebroadcast on an interface depends on the interface type. Generally, batman 
runs on 3 different types of interfaces:

 * WiFi: payload broadcasts are transmitted 3 times to increase the chances of 
a successful transmission
 * VPN / wired Ethernet: payload broadcast is transmitted once as most sane 
VPNs don't experience packet loss

Guessing from your interface names you are running VPNs and not wired 
Ethernet, is that correct ?


> this seem for me to be an issue.

What exactly is the issue ? 


>       Gateway      (#/255)           Nexthop [outgoingIF]: advertised uplink
> bandwidth ... [B.A.T.M.A.N. adv 2014.3.0, MainIF/MAC:
> ftun-q1/12:e8:ef:7f:0d:c8 (bat0)] ca:b1:f2:63:f3:cf (251) ca:b1:f2:63:f3:cf
> [   ftun-q1]: 50.0/50.0 MBit
> 
> [B.A.T.M.A.N. adv 2016.4, MainIF/MAC: mesh0/92:fb:53:11:44:f1
> (bat0/90:f6:52:11:44:f1 BATMAN_IV)] IF             Neighbor             
> last-seen
>      mesh-vpn	  aa:ff:ca:ca:fe:03    3.342s

It is recommended to run the same batman version on all nodes to avoid 
unexpected behavior. These 2 versions are separated by 2 years of development.


Cheers,
Marek

--nextPart2611375.FFshLlMIPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYHU6qAAoJEFNVTo/uthzAgyUH/2Gzl0IBMfMJ/eKE9ovUQeBa
0963MoCjMOaMD5HO35slb6mL5jEupmXHqF5iC8xhZKJRLZmojKz6AW0JuA1hWR6N
hh7fnEMG7JgRnTKwQ4qDePoHP7AkwDy6Ztt3QJwe9ihFbbOWJZP+m0FyyDjzTEdO
ILv5+0C/irMEb+q6uyusEf6SJy4v5kFRtXF3fqpncaLHx08epJN5hEhoUaP0tZ9A
5vMMoEvu8w2pd4ck2dvUKOrNTfLg8l5VvOtMlWoNOnb0v3pM2E/Otq3gU6HSi8Pq
Gp7lyL4nhOjKGLhvhYzimcN1I4i/4+5GvN5e1Oxl2/h1CqbL0eqSMiHMYdHc0tM=
=x+S+
-----END PGP SIGNATURE-----

--nextPart2611375.FFshLlMIPT--


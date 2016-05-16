Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 May 2016 20:40:50 +0200
Message-ID: <6364601.Bz14dhQNGF@sven-edge>
In-Reply-To: <mailman.206.1463421948.23655.b.a.t.m.a.n@lists.open-mesh.org>
References: <mailman.206.1463421948.23655.b.a.t.m.a.n@lists.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1739921.ocl15IT1DB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Node movement
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

--nextPart1739921.ocl15IT1DB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 16 May 2016 19:05:26 Andrei Palade wrote:
> I installed batman-adv on 4-Raspberry Pi Model 3, and I now want to
> emulate an out of reach situation. Instead of physically moving the
> PIs into another room, I want to use some mechanism that will do this
> for me. I ran the following command on node D:
> 
> ip6tables -A INPUT -m mac --mac-source XX:XX:XX:XX:XX:XX -j DROP

This is the wrong layer. What you are now doing is to add a layer 3 firewall
based on layer 2 addresses. The batman-adv stuff happens in completely
different layers/headers because batman-adv encapsulates the traffic in its own
headers.

So batman-adv is below this IPv6 firewall and thus the firewall never sees
the packet on the intermediate node. The mac address you used here is the one
directly below the the IPv6 header and has nothing to do with batman-adv. And
this address will not change when batman-adv forwards packets. So your rule
will drop any IPv6 packet from XX:XX:XX:XX:XX:XX independent of the path
it took to reach this node.

But your rule doesn't block any batman-adv traffic (OGM, ELP, ...) because
these are all send as ethernet frames (layer 2). But what you want in your
test setup to filter these messages

> Did I approached this correctly?

Unfortunately, this is not correct. You have to modify the layer below
batman-adv. So for example add an ebtables rule on a "wrapper" bridge only
containing your original ethernet/wifi interface which is then added to
batman-adv as interface (this may require some tinkering with the wifi driver
to allow adding of a wifi interface to a bridge - search for IFF_DONT_BRIDGE).
Or you should look if your ethernet/wifi driver allows mac filters. This is
not the first time this was asked. Here some example search terms:

 * http://search.gmane.org/?query=ebtables&author=&group=gmane.org.freifunk.batman&sort=relevance&DEFAULTOP=and&%5B=1&TOPDOC=30&xP=Zebtabl&xFILTERS=Gorg.freifunk.batman---A
 * http://search.gmane.org/?query=force+topology&author=&group=gmane.org.freifunk.batman&sort=relevance&DEFAULTOP=and&xP=Zebtabl&xFILTERS=Gorg.freifunk.batman---A
 * http://search.gmane.org/?query=blocking+ogm&author=&group=gmane.org.freifunk.batman&sort=relevance&DEFAULTOP=and&xP=Zfilter%09Zogm&xFILTERS=Gorg.freifunk.batman---A

You could also try to use netem + ingress TC filters. Ingress shaping is a
little bit tricky but there are examples available which use ifb to map
ingress to the ifb interface's egress (which then can be used like
normally).

 * https://serverfault.com/questions/350023/tc-ingress-policing-and-ifb-mirroring#386791
 * http://tdistler.com/2011/06/10/netem-wan-emulation-how-to-setup-a-netem-box
 * http://andthatsjazz.org/lartc/mac.html

> Basically what I want to do is from
> A, B, C, D, to be able to route packages from A to D through C,
> instead of physically moving D out of reach of A. How do I do this,
> and how can I check if it works?

You have to check via `batctl o` or `batctl ping -R ...` to find out over
which neighbor the target is reachable.

Kind regards,
	Sven
--nextPart1739921.ocl15IT1DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOhQyAAoJEF2HCgfBJntGo8gP/1l/YG6ZnaU5uIg5B1oYOY14
LYPjbes6gCNQrLJIzz5NQWcVnLfmqEer29gvziECxCvZczS/HOSDaKPSGL2dbIUb
vZOBPxg1BxiYOGpTTn0rfrMkSF/dHyh0omqAU8sQyBWqUpBHuVKmWjQKPOrLd3WO
t8kXKel5ocVtOFDpcAuS+1ex6kMpjn/Tkirf4XeQ0VAlAT4Tud9VPr5hSfMBWJRx
qsASxUMyCoKH1WHXOIRfhMX99ljGmk+DsKJmxiOWIKdljBBlBug4rVvJErACgiJd
0X9PUb9JBGezzc2JGLeabkHPRuxyzXWPtphFydT4MFzqNS1mYbSPFJZwMM+8M23A
sJLT5YBvTr1s9mhICI82Qtp4YxPXmuPn+gnycYOxIeAQRR8GeRlWlHCiXz/LvO+B
h8dXZ3cZnb5rpSmjmLQaiLIjO8c+59pqspbNOVEppf/KO2psQah6k/ETiJp8OY8s
AOuu0N3ebrjZzxQyruvhIewf+fgzTTOZ5VnbZSPkLtmlB6f8b9r8HHZavLK0oX0H
gjksmC9CqWoYkeLYUlfAvvp7YezvvwczJZcVGHC90EhGRe5T2lgGHwq2OFHmWQWe
g8E3R3g6xcOlVUuUWUozdvejfQLl/izvuHtojCiy5933TIHqdeZEwjfeEWJPE1K7
/4oc/J7CWMzVNwTXTWav
=4iW+
-----END PGP SIGNATURE-----

--nextPart1739921.ocl15IT1DB--


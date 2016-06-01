Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 01 Jun 2016 10:54:34 +0200
Message-ID: <1832776.WWitf2ljLt@prime>
In-Reply-To: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
References: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1853608.PJE3ekAZPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Non-batman Clients
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

--nextPart1853608.PJE3ekAZPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jonathan,

On Friday 27 May 2016 22:25:46 Jonathan Haws wrote:
> I've followed the quick start guide, but apparently I'm missing
> something when it comes to non-batman clients.
> 
> I've set all this up using vagrant and VirtualBox.  The mesh seems to
> work perfectly, however when I put in non-batman clients they cannot
> communicate one with another.  I would expect that they would be able to
> ping one another.
> 
> I've given IP addresses to the bridge adapters on the 192.168.1.0/24
> subnet.  The clients I've given IP addresses on that same subnet
> (192.168.1.121 and 192.168.1.142).  When I tried pinging, I don't get
> anything back.  Sniffing packets in tcpdump shows that it is never
> getting anything back, though I did get an ARP back once with the
> correct MAC address, but still couldn't ping.  Never got an ARP back
> again...
> 
> I can ping from each client to the IP address of the bridge they are
> connecting to, but cannot ping anything else on the network.
> 
> Any thoughts?  Hopefully someone has seen this before and can point me
> in the right direction!
> 
> Also, is there a separate list for alfred, or should I use this list for
> alfred questions?

You can use this list for alfred stuff, there is no other list.

> 
> Thanks!
> Jon
> 
> 
> Here are the commands I used to setup:
> 
> batctl if add eth0 (eth0 already up)
> ip link add name br0 type bridge
> ip link set dev eth1 master br0
> ip link set dev bat0 master br0
> ip link set up dev eth1
> ip link set up dev bat0
> ip addr replace dev br0 192.168.1.102/24 (and 104 on the other node)

This looks good as far as I can tell.

Do you happen to use the 192.168.1.0/24 somewhere else? Do you have some IPs 
configured on eth0 or eth1 by any chance (best to remove them).

I guess, the best way to debug is to check with tcpdump on each interface 
(eth0, eth1, bat0, etc) and on each machine where you see your data is lost.

Cheers,
     Simon
--nextPart1853608.PJE3ekAZPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXTqLKAAoJEKEr45hCkp6hmfMP/jhDO2yBGGRytHmkxYP2he5y
6OIknlVkKf320TSOTCE+/6LgbJNm3X+b65uCx3W8NvofjkyQTezs/GmF/LU/nWjt
csOY0Rd+jMSR5UKYucYZ9MUxn8pSALsFAz8oN0ho6L4pBIHSnZAkdFdkOp3D8z2Q
bZlixVaOT9+b8OO1XleB3PFYdrZKraynYwDQQJH58/Kt36/koi3Ugn9rxlJ1OJqJ
uN91zyR5O7+8zvL5n2p9qWJJudkNUADMPAHmUghrpL6Syr5e5kCVYHxy1c+jJjXJ
9PUH2xbKrT4YvYzHQDV4rrWvsOJHygJLSyTYGE0CI/fhxph7jTnqexVdu6dm4ngT
bE/hv7NAl1CMtsDx+eKlOf8EbSmwVnuM5UPMJhLB0zFpb5RVxR3yYWq/ulrX+vcN
JV6iDhAz5fhrUdTFGxWwMhbAT5Jk7guGCWR9E06T5lZhiIYc7zVZB4TwFZsUsDgU
VCFXQaulEYynL+pi9u5MGD1eUR2nCSGrhCpB3xyJrl0XVYIZqEGDzgcGnfXzbTqa
TOCO0muBbmfcymbpqyj0fSAeZRvUH5LTMCLzCSctF7gKi9342PTvcF+z+Om3oxlY
GdJTOUnzpvH7NQ0ktbyEbXZlFli5283MD3l1ttFqb/Xi7rbZi0EA18y/iWCxb52O
k09tvNPhSPiWXgIuZZuC
=qnWr
-----END PGP SIGNATURE-----

--nextPart1853608.PJE3ekAZPT--


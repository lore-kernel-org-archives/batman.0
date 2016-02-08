Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 08 Feb 2016 13:29:55 +0100
Message-ID: <4917381.eeOl7B1qNb@prime>
In-Reply-To: <OF64B7E443.53DA160A-ONC1257F53.003E4656-C1257F53.003FAF34@phoenixcontact.com>
References: <OF64B7E443.53DA160A-ONC1257F53.003E4656-C1257F53.003FAF34@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8315973.S4zztbaPDS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Looping unicast packets when using BLA
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

--nextPart8315973.S4zztbaPDS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Andreas,

On Monday 08 February 2016 12:35:35 Andreas Pape wrote:
> Hello
> 
> I have a problem in my mesh setup which is quite similiar to Bug#216 of
> the bug tracker.
> I'm using batman-adv 2014.4.0 in a BLA setup consisting of 3 Mesh Nodes
> (A, B, C) connected to the same backone network via a common switch and a
> mesh node D connected to an end device E. I ping that single mesh node D
> and the connected end device E from a PC which is connected to the same
> switch as the three Nodes A to C. BLA is compiled and enabled.

First of all, did you test v2016.0? v2014.4.0 is pretty old, the bug was 
created and closed in 2015 after all ...

> 
> From time to time I see looping unicast packets in my backbone network.
> This unicast looping starts directly after one of the nodes A to C claimed
> the mac address of my PC. The looping telegram is then the ping request
> sent by the PC. I have a wireshark recording made in my backbone via port
> mirroring of one of the switch ports where a mesh node is connected to
> which shows this behaviour.

Is it really the ping packet looping? If yes, which nodes are part of the 
loop? Normally we only see broadcast packets looping. In #216 it was also 
broadcast packets where we have seen duplicates, and this was more a locking 
problem leading to creation of the same packets again and again.

> 
> I am not sure if I understood bla correctly but isn't it nonsense that a
> bla backbone gateway claims MAC addresses from its own backbone (i.e. the
> one it is directly connected to via its ethernet port)?

Yes, that appears to be nonsense indeed. Do you happen to have DAT enabled? 
There were also some problems with that which are fixed by now.

> 
> A simple change in batadv_bla_rx seems to solve this problem: add an
> additional check before claiming a new mac address: if this address is
> already known from the tt local table (via command batadv_is_my_client)
> don't claim it.
> 
> This seems to solve my problem as far as I have tested so far. Any
> thoughts about that?

This will prevent roaming from on of your nodes connected to the backbone (A-
C) to the mesh-only node D.

I would like to suggest to upgrade and test again, and try disabling DAT if 
the problem is still present (you should still report it if DAT makes a 
difference in that case). If you still see a problem then, we probably have 
something unsolved, and then I'd like to understand which nodes are part of 
the loop.

Thank you!
     Simon
--nextPart8315973.S4zztbaPDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWuIpDAAoJEKEr45hCkp6h+qYP/2WYkxrwrIsJSWcwqQ4VdCAP
1ZinJISiGAID4G9+5QBWYzKpHs6pp02TJom9LERps/pifGVVEYdaLtK80sSmdmyQ
FcJvsP0ftYGlbpOEdkrT3fbn+A2VKiP8wJYFiev7zKRk8xxadQWvx8+o6eLaE1Xl
OvhYzi5T6+Gk0EmmU10oMve6uzxa4Nsz5L9P5frVYiAGU4Y8w/HmqmgU9MLK/vBg
HJD/mTPu2RYhmLdGUABhmlw35hD08pbQVWxYfBD4muy/Fdr2Hc/x7/n9TvDEA54N
SHDJZ6ahZj3LVB1MNEk0hbVlqIBGRkJ1ei9qcmv8v0RT+8EsaVJLIfGVDOsXfCJG
CophavTLd07t8NjEZ3hzQsBBbNNBoosH5/PcCHLmfpY6EI6GlT3dbuLDCNIab8dB
wQnGe0/rdIAIhm4SOfmEAhP0V46O1S0Ov35jPtkUNIe8g0NoiSoAOhsgcxmOIZS0
nCzUA7nM6R1zmJIISlBIjmplAxnj6HA1hz3vRRPpYlhYIOXGS3Q5/vEuCn5eMeG4
GkJGkeLgRvfyiGah6uo3wcnivhTEg/lahyBjOP0l7wXNKNICat7jx4cJgf8QFlcE
nBOW1CGXrfSuGtgSwDq73VrsP0hUEo4FrQE9q6UBEOXgCcmOuDnaF2oNcY6Akusg
0WgK8r+XGrj3sO8U4P2D
=zSxk
-----END PGP SIGNATURE-----

--nextPart8315973.S4zztbaPDS--


Return-Path: <bjo@nord-west.org>
Message-ID: <4BB61A71.9070702@nord-west.org>
Date: Fri, 02 Apr 2010 18:25:21 +0200
From: Bjoern Franke <bjo@nord-west.org>
MIME-Version: 1.0
References: <201004020054.08840.clemens-john@gmx.de>
	<201004030000.16637.lindner_marek@yahoo.de>
In-Reply-To: <201004030000.16637.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Problems connecting VPN and WLAN with Batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

> 
> I have been reading the other mails but I don't fully understand what you are 
> trying to achieve here. Nevertheless, I'll try to write something. If I got it 
> all wrong, please let me know.  :-)

Thanks :)

> It is important to keep in mind that IP addresses are totally irrelevant to 
> make this setup work. I mention this since you seem to have experience with 
> layer 3 routing. Even if the tap interfaces had no IP addresses batman-adv 
> would route the traffic through. Unless you need to access services on the VPN 
> interfaces via IPs you can safely run them without.

We have a openvpn with tap running to connect our clouds.

> If you IP networks don't share the same broadcast domain (e.g. 10.18.1.0/24 vs 
> 10.18.0.0/24) batman-adv won't propate IP routing entries because it assumes 
> that is what you want. To resolve this you have 2 choices:
> 
> The easy way:
> Move all nodes into the same broadcast domain. All nodes will be able to 
> communicate with each other without problems. Disadvantage: If you have many 
> nodes (100+) in close range it will create considerable (ethernet) broadcast 
> overhead.

100+? It would be just nice if we would have 10 ;) We had the /16-setup
running with olsrd with a big overhead.

> The routing way:
> Let your VPN nodes know how to reach to "other" IP networks by adding routing 
> entries. Naturally, this will reduce the broadcast overhead but requires a 
> mechanism to distribute the routes (as batman-adv won't do it for you). There 
> a couple of standard ways you can choose from. Depending on your setup & needs 
> one or the other might be more interesting to use which brings us back to my 
> initial question.  :-)

Which ways are you thinking of?

Our initial problem is:
- - several node-clouds, connected via openvpn
- - these nodes also use the vpn as a gateway in the world wide web
- - the gateway also monitores the nodes, so it must be able to access the
nodes, but it runs in openvz VE, so the kernelland-module is not usable

tia
bjo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAku2GmwACgkQazwuXcm17aqtmQCfaBtn1YuBsbBW3+QEufLvGIaS
9IUAn1MtA89jCa0NlpeyZQRSltQkiGNF
=POZN
-----END PGP SIGNATURE-----

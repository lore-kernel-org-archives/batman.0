Return-Path: <bjo@nord-west.org>
Message-ID: <4BB73808.8080105@nord-west.org>
Date: Sat, 03 Apr 2010 14:43:52 +0200
From: Bjoern Franke <bjo@nord-west.org>
MIME-Version: 1.0
References: <4BB70C4B.5000909@nord-west.org>
	<201004031154.19191.sven.eckelmann@gmx.de>
In-Reply-To: <201004031154.19191.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] running batman-adv in a openvz VE
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

thanks for your reply!

> I have never used openvz, but adjusted some protocols to deal with openvz 
> aware kernels (which means that they used and checked their namespace - so 
> nothing really fancy).
>
> What must be done for device drivers to make them work on OpenVZ? Have you 
> tried it and where have found you problems?

OpenVZ-Containers use the same kernel as the host system and I can build
and load the module on the host, but I don't know how to access
/proc/net/batman-adv from within the container. The container uses a own
proc-fs.

> There was a proof-of-concept version of batman-adv running in userland. This 
> work was abandoned in favor of the in kernel implementation (better 
> integration/better latency/less overhead/.... - stuff which is even worse on 
> embedded systems - see Linus comments on the tinc vpn throughput on DIR300).

Ah ok.

best regards
Bjoern
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAku3OAQACgkQazwuXcm17apu4gCggYD8pg+Spx8XIgRmB3MDa8c2
vV4Ani8LgXUXInXRm0pOZd9g9jtslE7J
=fu2x
-----END PGP SIGNATURE-----

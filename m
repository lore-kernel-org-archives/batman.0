Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 15:33:48 +0800
Message-ID: <3583975.lz5Xt4SSRR@voltaire>
In-Reply-To: <1423153373-17033-1-git-send-email-sven@narfation.org>
References: <1423153373-17033-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5047189.lHEJWBdUH2";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart5047189.lHEJWBdUH2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 05, 2015 17:22:53 Sven Eckelmann wrote:
> The current default settings for optional features in batman-adv seems to be
> based around the idea that the user only compiles what he requires. They
> will automatically enabled when they are compiled in. For example the
> network coding part of batman-adv is by default disabled in the out-of-tree
> module but will be enabled when the code is compiled during the module
> build.
> 
> But distributions like Debian just enable all features of the batman-adv
> kernel module and hope that more experimental features or features with
> possible negative effects have to be enabled using some runtime
> configuration interface.

Interesting point. Based on what you are saying we definitely should review our 
policy and agree on sane defaults.


> The network_coding feature can help in specific setups but also has
> drawbacks and is not disabled by default in the out-of-tree module.
> Disabling by default in the runtime config seems to be also quite sane.

This feature requires the wifi driver to support promisc mode. We should keep 
it disabled.


> The distributed_arp_table is in theory a good solution to reduce connection
> problems in large networks caused by ARP packet loss. Unfortunatelly, it
> seems to also break ARP resolution in simple mesh setups. The only solution
> which seems to be used by AP firmwares seems to be the deactivation of this
> feature. Disabling this feature by default until the problem was understood
> and fixed may help new deployments to create a working mesh. Tuning of the
> mesh can still be done by them in case DAT works in their setup.

I vote for keeping DAT enabled. 


> The bridge_loop_avoidance is the only feature which is disabled by default
> but may be necessary even in simple setups. Packet loops may even be
> created during the initial node setup when this is not enabled. This is
> different than STP on bridges because mesh is usually used on Adhoc WiFi.
> Having two nodes (by accident) in the same LAN segment and in the same mesh
> network is rather common in this situation.

Agreed.


Cheers,
Marek

--nextPart5047189.lHEJWBdUH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5EBkAAoJEFNVTo/uthzA1Z0H/23hmXNHVqbwSs7XiwULjWDH
vqlplSD/pCni2s8pz9940HWC1e4ks4M8WO40RNndpzcNwKywjeuMlmz+5TdysvAp
4p8QzabG1Xky61Hq2LoTTwSdgWxZWIjCrthgtXWyfYyeqkJDE/P0J9A24+53Fjc+
YEtFz5ppUh/QG58tXUGH0dKS3eMHEFDLmNr9kZpce9ORgvuEuYYvaUWHqM7TKu4/
hq8RcG9HS44L3QjNMZ/bxgCl12xy9jOqoAxk+1XxtGQ2ppp8b6lkiteLVrMn+WcR
f7E8SxXXxv0P2ZzCS33zKItBDE+kjJFRXHZpsnBXbeYlDXEf3PFN+a1rHeeDiF8=
=4ufe
-----END PGP SIGNATURE-----

--nextPart5047189.lHEJWBdUH2--


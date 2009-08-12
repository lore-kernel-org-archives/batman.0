Return-Path: <linus.luessing@web.de>
Date: Wed, 12 Aug 2009 19:10:22 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20090812171022.GA4435@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] inconsistent vis-output in batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi there,

I'm having some trouble with the vis-output in batman-adv 0.2 beta
- compatibility-version 7. It seems like the 'From' part gets
substituted with the mac address of a node's primary interface,
while the 'to' part does not. The result is, that when I try to
convert the dot-files to png/svg/etc. with neato from the
graphviz toolchain, I get two seperate graphs.

Of course, the easiest way might be to substitue the 'to' part
with the mac addresses of the primary interfaces as well, but I'd
prefer something differently:
http://www.graphviz.org/Gallery/directed/cluster.html
Those subgraph things from the dot-file-format would be a great
way, to have a more detailed image of how two batman-nodes are
connected, over which interfaces they're connected with each
other.

I had a little look at the batman-adv source code and noticed that
the structure vis_info_entry in vis.h does only have a dest and
not a src entry. So the vis-server only gets to know, the node's
primary mac address but a primary or secondary mac in dest so far,
right?

I'm also still trying to figure out, where such a src information
could come from... dest gets that stuff from orig_node->orig and
there is a list of interfaces in orig_node->batman_if and also
a neighbour list in orig_nodes->router. What would have to be used
for the src address?

I'm also wondering, what those hashing functions are for exactly.
Would I break some of that stuff by introducing a src address in
the vis-packet?

I'm not that much into reading the batman-adv source code yet, but
I'd like to get a little more familiar with it. So please be
considerate :).

Cheers, Linus

PS: I'm having a router with vlans here, so two seperate
LAN-ports, which batman is using, are having the same mac-address.
Could that cause any trouble?

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKgvd9AAoJEBKw7u43QNpfskcP/jqXYUDh02+em6DgCtjBCyYh
82FreUC/fFAvBOEpE4lWVjStMRgwUZWg+pA2hhKb9fzqW681tY/8H97wO+MwPAoc
sRLlzvP9EjK74sa1Noac+RZf4As+GbFV/67Vic1ouW9H8eFom0LDwXbY8m8/iJDY
oAxU8o+IEkiEVsrOTOzQ0oWwkJZwssFi0dOKt2BycnKhAdc7/HRNE1KnROMGWA5J
QCcdIAZN68qCFWI+0zvJSd/NOx6c58f8C2Wq/IijzmkZmy4DFRJ2cVAaCDjO1UzV
wZG+MMyYWbQuc1CLb7woITwdhh+MvpwdMb2gFP9o5bpvxRv2/6gyY/5rh1DDpSHP
7SffKxZURoMLFl5onvppFwccioRT8XJLsFbrut/BdVGqoTBrgzQ8i4vioy1zCixL
hKveTTydkqx7YVgWzV1NEiucFPQI8Au/njY1wpMh22MPuOnm7MC+eR8SZd9HF7VV
wt4rqIkQeRdSHezLrezQqP6iiVAuKRhbeR6DaVW4S3pHbWIs6lc/aWqtXUGEcdIH
ACOoaOJNBfcA9mtoTd6xmcBthT346CmyBJy27RtwKqyn6GDCX68595i2K5gNiR9c
g1B2UW9NsmZF+0pD61Ygj684+Ijno1S35acGMM4qC6vf0ukk4grjbeuioLFQu1Py
fowFpC012oXpWFzDEziI
=vu9n
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

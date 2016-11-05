Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Nov 2016 23:25:38 +0100
Message-ID: <7866334.t3BPe0EmV2@sven-edge>
In-Reply-To: <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <2562442.4W30obIVjL@lafayette>
 <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1965912.nshPCKIYAe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1965912.nshPCKIYAe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 5. November 2016 22:29:19 CET Jean-Jacques Sarton wrote:
> Am 05.11.2016 um 04:14 schrieb Marek Lindner:
> > Hi,
> > 
> >> I have take a look to the configuration of our gateways.
> >> Inho there are some points which are not OK,
> >> Broadcasts are rebroadecasted on a wired connection,
> > 
> > please note that batman's payload reboradcast behavior is unrelated to the 
> > batman gateway feature. The effect of the batman gateway feature is explained 
> > here: https://www.open-mesh.org/projects/batman-adv/wiki/Gateways
> > 
> This seem to work but for IPv6 there is nothing and the client get
> RA's from all GW.

The important message from Marek (we already told you this multiple
times) was:

"batman-adv gateway feature" has nothing to do with "rebroadcast".

So please stop mixing these things together in all your messages. It also
doesn't help when you now start to bring up IPv6 RAs. They are not IPv4
DHCP requests and are therefore as unrelated to the "batman-adv gateway
feature" as "rebroadcasts".

> > * VPN / wired Ethernet: payload broadcast is transmitted once as most sane 
> > VPNs don't experience packet loss
> 
> This what the interface type used. This mean that the gateway send
> a broadcast via wire and the node get it as if there where no VPN between
> GW and node. rebroadcasting is not OK here.

This can be wrong (as explained in my last mail). Gluon only sets the
no_rebroadcast on the Freifunk router because it doesn't have to handle
distribution of broadcast to multiple fastd endpoints. It would be
completely wrong when set on the fastd server (handling multiple clients).
See my other mail for details.

Kind regards,
	Sven
--nextPart1965912.nshPCKIYAe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHlxiAAoJEF2HCgfBJntG++IQAKAfCSGQ7gKw7ngcJrM1YFX2
eCcgNlXuqk/+tQBEvBbUmSO2DbXcXsURhT2xXq/zIeij6Xk/52MZTDGVF+SzfijD
WCzaRZAC+TwLcf+1gd8Ez3eKLnBji0oBehgkJJJejM4rFtgtF3+r3PdZ+vhYY05W
c7DTbQXW0c0GViTfX8rMINEp6s05TJ5s4OHE+CcX2x/QzmAbj0fg+MvlmsBCPUGj
MLYrQ6vqytv5o141tWQBs8w0tY/sChi9qY+e3Em78mf21eirNLxPwpmNIojN5Iz5
GEiY1xP9ZqtTCk2rIWadYUZnId/avuPQtLqVLSS65zqzjOH2b8DRiAX7XSqEghMy
U3dq9GRXxZqqiBd1hZmVyS0LBcO/0MirpEYpZW3RQevbGa4S2oOVmusSBIMm9lpC
r5EczCB5USh59VbZYg6UUtceubqxzn1Mbxb7H7+VWwx/nxn4XRswyM2tAPzyJrP5
z9Ej9GHa9CPfmN2Z/yGAQGUOGIGaHhnnmfaOm0nutMRHyKBY79lepHK4Wh/l1NwP
AmIR0TfH9FT1PegRPJp2jiCHvloSzU4CEKgNbryK7r9kvMi25GjnjMyfAEMYc/pH
EcvQDJ+6+FU0r7/Nb6ar4v/pi8bktq6Idxgeqn9Qk6vGvQA9tZgK69o9OmvL41Yq
5MmjJr3/AU8zlMfmekDs
=YINw
-----END PGP SIGNATURE-----

--nextPart1965912.nshPCKIYAe--


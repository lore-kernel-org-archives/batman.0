Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 25 Aug 2015 23:12:17 +0200
Message-ID: <1835271.k3x2n3oEZQ@prime>
In-Reply-To: <55DCB3E0.9070402@meshcoding.com>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
 <2860695.DF0VuzRtbN@prime> <55DCB3E0.9070402@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8050220.ir5yghYSPg";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 4/4] batman-adv: detect local
	excess vlans in TT request
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net


--nextPart8050220.ir5yghYSPg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 25 August 2015 20:28:48 Antonio Quartulli wrote:
> On 25/08/15 17:31, Simon Wunderlich wrote:
> >> batadv_orig_node_vlan_get() returns NULL if we don't know this VLAN for
> >> that Originator, therefore the CRC check fails here.
> > 
> > That's right, however it only sweeps through the VLANs announced within
> > the
> > TT-TVLV. However, my addition tries to check if there are any excess VLAN
> > locally which are NOT in that TT-TVLV. I think this patch doesn't take
> > care of that, or am I missing something?
> > 
> > For example, think of having VLAN 6 locally with a couple of global
> > entries at the originator, but the TT-TVLV only announces VLANs 3,4,5.
> > Then the fact that we also have VLAN 6 is not detected, and these
> > (probably wrong) entries are never cleaned up.
> 
> Right, this check is required, but what about just checking the VLAN
> count in the tt packet and in the originator struct ? if the number is
> different it means that there must be an excess in the local struct.

You are right, just counting would be way simpler than comparing for the right 
VLANs (since we don't use that information anyway). And this patch also did 
not unlock the rcu-lock properly ... I'll resend this one with the simpler 
method.

Thanks!
    Simon
--nextPart8050220.ir5yghYSPg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXc2jQACgkQrzg/fFk7axa2swCffGfNI310agtEFSxrl1/CC+2A
048AniJOZh6agKTNgDexEM4yycrDNhxd
=lV6r
-----END PGP SIGNATURE-----

--nextPart8050220.ir5yghYSPg--


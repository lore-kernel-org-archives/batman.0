Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 12 Feb 2014 01:40 +0800
Message-ID: <27300725.U6R9joZBFU@diderot>
In-Reply-To: <52FA5F12.5090406@meshcoding.com>
References: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
 <52FA5DE6.8050005@hundeboll.net> <52FA5F12.5090406@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2620660.QdgtJJSsdt";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix potential
	orig_node reference leak
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2620660.QdgtJJSsdt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 11 February 2014 18:34:10 Antonio Quartulli wrote:
> true, but since the orig_node has not been returned yet there is no
> other component in batman-adv which is using it.
> 
> Otherwise, we may want to define and invoke a free_now() version of this
> function (like we have done for other objects). But I think kfree() is
> safe here.

It may be safe now but will surely be forgotten later. A guaranteed source for 
trouble. That is why we have cleanup routines for everything.

Cheers,
Marek

--nextPart2620660.QdgtJJSsdt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS+mBzAAoJEFNVTo/uthzAHIwIAJAGtyppnq5ACzaELSPt8doB
kxvT8aBFsC6n3ZF91WnOBsPZUeyJy2ARK8w4bnEVUuGaLvNwpwN19/QoW8/OPl2p
oZL/z3bb1Voazqcxqwl4n/AaLgivh90uzHNSZQeJfdsU8syLz2Kh1z6C1KItERz6
yWIvpmRDPSkaCxQsOwmdOzTCPUh5jjHWQB5eO8DQbY4w8b4Tt+F6ds+1pn0+hDbw
8ROAaPJuLlJOllizuK9D+ZIchbsM2Fgce38piHyMsNbVdDY4fPRst7anBJ8ovh9Q
Icppt9F84/K//Vcp4vlDNWmTKbaVzGEUv+xuX/7dEbp6n2tRHYxt0mB/daPGSl4=
=xwFM
-----END PGP SIGNATURE-----

--nextPart2620660.QdgtJJSsdt--


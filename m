Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Jan 2014 10:37:38 +0100
Message-ID: <32326825.BW0GZpyDjI@bentobox>
In-Reply-To: <52D84B0A.10208@meshcoding.com>
References: <6312194.LhI8hzXjyH@bentobox> <52D84B0A.10208@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2458117.8GPLsz0Z9U";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/3] batctl: Use libnl(-tiny) for netlink
	communication
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2458117.8GPLsz0Z9U
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 16 January 2014 22:11:38 Antonio Quartulli wrote:
> I think that it may still be the case that we want to compile batctl on
> an host without libnl.

We == "I have this use case"?

> In the end batman-adv can run on Ethernet and we may have an embedded
> system with no wifi which has no libnl at all.

(Now a little bit sarcasm): batctl can also run without batman-adv, please 
allow to drop the useless sysfs/debugfs stuff ;)

> I was wondering....what if we check if libnl is installed or not and in
> case it is missing we disable the address translation and vlan operations?
> In this way we can add the dependency to libnl and avoid code
> duplication but at the same time we keep libnl-free users happy.

I agree that it is possible but would like to avoid to provide a "fallback" 
because it justs adds more complexity without an actual use case (please 
correct me but I don't see it right now).

If you still think it is necessary then please feel free to add it later.

Kind regards,
	Sven
--nextPart2458117.8GPLsz0Z9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJS2PniAAoJEF2HCgfBJntGSqwP/jtZbBQVaRb+xsvkA4knyl75
3wTgSNlaSuT+SUsLD1IDdRUKbozHPE/D/tMlWyPy4KGiDpFAJs6MEVwBkF8zpg53
rXyo2SGTZVPPWVVE5LBtsd1rpSB1aYe9AMsxur0xx8ixxGm63Pm5PfuyWZbJCID8
usBOSh/60pvCxhLcVWXdO7pxiZfUaX+QZyRNSad1Gz9aY9mGsy5EQfxRnsA2Mj2Y
rPpMgLreaJaZSe2MIWh+Zcaja9K2vQwdSIiKb4wu8FZrn1es4pFOdT3JPlqkJkn9
feOUZC2EaclBNBG28Bx0FVJbEd+EwHWAbHQ8qGabdHj/D9M0ct4XsBn2iW3EzYnS
TSu40Y/E/Lf0EpR+xFaVB8sKueTQ3FuajISD+C6VsHcdKaGOX/nPnIfvqeuEdR7k
d0AvTiHbpJIUl88O/R1xQAZmmDUR2M7lrAc2htsiwA1OefTotLRaWL3omK6xzihr
Lt/SBTcXGXjUnpaDj6J500wXfeKZ2wlWvdP6LQkTBHtQdMENHZ4S8uKe9juh2L2F
rCuuU4OXsjiac2GDz2mXiZvYPCn67Tx0S+iZShkGFljMtTixGjal4pGrTreJjCoj
IEyru/QdFZEuJ0t2b/WMMGR6ruOS+n/MF+4LywRLg5Kud0jUNtNLLqs+1RtPmpDh
nXwNrJ993R3vWZrBgIZW
=3yB8
-----END PGP SIGNATURE-----

--nextPart2458117.8GPLsz0Z9U--


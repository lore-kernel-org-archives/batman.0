Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 01 Feb 2016 09:44:39 +0800
Message-ID: <4194875.ui2pi6v3zm@voltaire>
In-Reply-To: <20160201004826.GL22112@prodigo.lan>
References: <1454257280-19649-1-git-send-email-mareklindner@neomailbox.ch>
 <1454257280-19649-3-git-send-email-mareklindner@neomailbox.ch>
 <20160201004826.GL22112@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8410141.Rf6EbNfV6x";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 3/3] batman-adv: fix misleading
	default throughput warning
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

--nextPart8410141.Rf6EbNfV6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 01, 2016 08:48:26 Antonio Quartulli wrote:
> On Mon, Feb 01, 2016 at 12:21:20AM +0800, Marek Lindner wrote:
> > The default throughput value represents Mbps and not kbps.
> 
> Isn't this a bit confusing? The default throughput is expressed in multiples
> of 100kbps, not Mbps.

Prior to my patch the debug message said:
"[..] therefore defaulting to hardcoded throughput values of 1 kbit/s."

With the patch it says:
"[..] therefore defaulting to hardcoded throughput values of 1.0 Mbps."

FYI, I changed the text to "Mbps" because that is what batman-adv prints in 
the neighbor table as well in the originator table.

Cheers,
Marek

--nextPart8410141.Rf6EbNfV6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWrriHAAoJEFNVTo/uthzAdogH/RkSBeSuOJ2uxzvCBqYLmtqd
iMUMNjLwIx1sOSZjthL3bsHxuCa7BXF1urtKTJHZcj+sSu90pvdeWikytvLIQDwz
dHvLJN80HC/GdtiwknKAuViwCOebsl6bKrjpXJJV9fw46WCdoz0f1fI77KiEV/5R
SZ8gmNO5SOGT2WTT6hfkJVffUMRU364RexxgZV0ecH4pP6sAP0G52/BWYVfN9Hes
bEgM1mFej/TvB8X83J6EaOOM3cE1EvoFAdT6XB+0bO8x6RmHJ9dHKfhgu2f8wgzw
7GSgfRu3/uq0h4LlCNN0vFQPd3mko2IW5MWiLlBngjoJlcHGwFBU9d0cmG+MWkw=
=a3M0
-----END PGP SIGNATURE-----

--nextPart8410141.Rf6EbNfV6x--


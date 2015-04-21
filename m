Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 21 Apr 2015 11:41:48 +0800
Message-ID: <1834679.g60VTMDq3l@voltaire>
In-Reply-To: <1429292430-30883-1-git-send-email-sven@narfation.org>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2029658.IY51TkWUq8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/4] batman-adv: Remove explicit
	compat.h include and split compat.h
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


--nextPart2029658.IY51TkWUq8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 19:40:27 Sven Eckelmann wrote:
> The current approach for the compat layer is to include the compat.h file at
> exactly the right time to provide additional functionality and to live
> patch the batman-adv sources. This has the problem that the compat.h file
> becomes harder to read over time. Also live patching and adding of missing
> functionality partially conflict. This becomes obvious when the include
> order in some files is different compared to the one the author of an
> compat.h entry expected.
> 
> A different approach is to inject intermediate header files which add
> additional features. This allows to reduce the size of compat.h and only
> leaves the live patching part in it. The compat.h can then added
> automatically to each compile run before anything else is included.
> compat.h has therefore the control which headers must be included before
> the live patching of the batman-adv source can begin.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 8746f0f.

Thanks,
Marek

--nextPart2029658.IY51TkWUq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNcb/AAoJEFNVTo/uthzAFgQH/iLiavvZBqTdGIb9hrCPiLzV
W0mSkVSmfJZ9gkkaKKtQTtgK48vwHhDS3xV2EAW3be2Aar04nnI/2OH03ZjNc3u8
izGB/3wheqPneBAwu38aIFm0sUzkvXuza9Lo49SGeNBiSbvZ2ieIZiCE6jXpXNIm
sWcer1VDPa+iAwUn4lnzXRO6htZfdbZzuidizeH7iBqBJX/0oClqDsNTsMErn/Jr
1O8Sd8pMimsaERbcEtIuQZRV3kqomb24aac0AdILYGcXiL+sp1Bxn0UH7+I887wz
4iidU631USVV3G/oW2y0FXlu/gZ/cY4uZvYtZpIsoDy3eG96JcoxXwC9/XwUm0Y=
=ygnz
-----END PGP SIGNATURE-----

--nextPart2029658.IY51TkWUq8--


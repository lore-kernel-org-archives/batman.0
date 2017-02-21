Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Feb 2017 18:13:00 +0100
Message-ID: <1535884.R2pzemgNJL@bentobox>
In-Reply-To: <20170221162435.GC25818@lunn.ch>
References: <33547cb0-a540-e0b9-ffc7-99ac67c3d516@viisauksena.de>
 <20170221162435.GC25818@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6279379.XGQ2V9HTqp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Interface limit 127 in bat0?!
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

--nextPart6279379.XGQ2V9HTqp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 21. Februar 2017 17:24:35 CET Andrew Lunn wrote:
> > |Error - can't write to file
> > '/sys/class/net/gre127/batman_adv/mesh_iface': Cannot allocate memory|
> 
> As the message suggests, you are out of memory. This is not a BATMAN
> limit, it is a limit from the amount of RAM you have in your device.

contiguous kernel memory to store the per-interface originator data - to
be more precise. See batadv_iv_ogm_orig_add_if and all kmalloc*/kfree
references with bcast_own/bcast_own_sum

On Dienstag, 21. Februar 2017 17:19:42 CET jens wrote:
> i observe a limit of 127 interfaces which can be hooked into bat0
> where do i find this limit, or does somebody can tell me more about
> this? Or, if it is a good idea to circumwent this at all? Or, if its
> even possible in actual protocoll structure.

And we had this discussion before [1]. Not sure why you are now
pretending that this never happened.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2017-January/016824.html

--nextPart6279379.XGQ2V9HTqp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlisdRwACgkQXYcKB8Em
e0ZN8A//TYVXL5YGw5LlkJKpvDMttyK9TE1Ktyjq8EyVXGCj3XyDHIwAqyodRvRK
oe4nqfI+UwN6Xsqmfi0/kM5FaPzszWimD7V0ZN+PtQw3TKQvYSYFBkO1uOlsQ/4W
LQsYQVuNwuYNlNDg/vu5AZWe6WdOfEsxXkDRvJcKhKv0tSVVdW/prAkPUONVVGlU
09BU3NriO2pWCVwhm7NKRuHJXSV0KqFz4C6spBck49Ulwf3RFVc9ZKlXxQ01g3uE
6vr73jX0J8Cc1re4TuqaYUVzRwO28sTIYNjchCp8ZhwuExKnGhMdijYiPf2f3V/z
D3s0mb/D2NP1K8z5ieNXv3ymLBRIch/Urmyl5xI2s9qdW3gv2vAsSnNW4ppr8YZo
LpXW6GHexhsL4jc750fzz29Vh5XjXPbVQ3Yh5vJKAJCuT2Tbv+3S3H6UvMZLqUUM
MRIGGn8oPTaNxUTVBTJOaHgSNT3zvk7L+/7B9TEm4OuaXgYPSLOLbDHZ2SwSti/w
6DOmdey9AOYYXlELgrnqOfwVVnr7R4i+clwdgcN2ZoJMGIWqv8FdjoGbbvIv86wC
Mo2rD8sGEBrj8iQKXGBGFVn3XSnqXoxhhP2kIV/3GUiPmJIMXCVIAi1SxINhBmW9
8gc3ScBUDwXaTBOBNVYPuDSTAsnBESwEje5OKvPgYgDptVWEJSQ=
=1BaN
-----END PGP SIGNATURE-----

--nextPart6279379.XGQ2V9HTqp--


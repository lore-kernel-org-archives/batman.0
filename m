Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 18:36:45 +0800
Message-ID: <4401390.jOtbv3rCCK@voltaire>
In-Reply-To: <OFA96D7726.B38F8A68-ONC1257DF1.0038B77B-C1257DF1.003988B0@phoenixcontact.com>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <1485649.labZ4ZGvMV@voltaire>
 <OFA96D7726.B38F8A68-ONC1257DF1.0038B77B-C1257DF1.003988B0@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1587201.5zdPyy5nRS";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Antwort: Re: Antwort: Antwort: Re:
	Antwort: Re:	Question concerning batman-adv bug #173 "Mesh
	packets on bat0"
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


--nextPart1587201.5zdPyy5nRS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 19, 2015 11:28:24 Andreas Pape wrote:
> I started with a freshly unpacked source code of the 2014.4.0 release and 
> applied only  your latest patch. 
> 
> As expected from the tests done so far with the old kernel effectively not 
> calling netdev_set_master allows the usage of the latest batman-adv 
> version in combination with older kernels (at least the 2.6.32 I tested 
> with).
> 
> I think this patch is worth to be integrated into the next batman-adv 
> version.

Thanks for testing! I'll stage the patch for inclusion.

Cheers,
Marek

--nextPart1587201.5zdPyy5nRS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5bzAAAoJEFNVTo/uthzADTMH/0QolX2tmbdztNTo568jV1SB
e6RahS6L0yxzuEBTX1ODozrroPMHm8/HQQ0dZJFOIZPnW9u8SSkzKXHPbJJwnGZV
VT78sGyBJmdDXc5PUA0lT7DdfslhYQr8c/PoU2qqzkXZgGrgl64Mr9eFEXXRm4wd
ZIYpAlaErhfwAcRT76HP5AKiNA+zOPDQ1Ro9c4m9qREWlzdk7rAtHNNqQ/X0RW8M
uwYMy2df2Etj796Q3oKnY0Yf2Vs5qGEZCJ7eR2AvE7YAt2SSaR5v20DhAbC/05E1
W6dMnCrtkHcRMRO5F8+Xjn6QGju1VOJ5UMKe33p6r1T7gQc0Im8fy+9t0KkOntc=
=Lioc
-----END PGP SIGNATURE-----

--nextPart1587201.5zdPyy5nRS--


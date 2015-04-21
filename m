Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 21 Apr 2015 16:53:18 +0800
Message-ID: <3995188.NSgX7Lqqna@voltaire>
In-Reply-To: <8826381.MUao5dBNO2@sven-edge>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <2849660.eB6RnOYSlL@voltaire> <8826381.MUao5dBNO2@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11258618.edMe0jPaLm";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 3/4] batman-adv: Remove unused
	IFF_BRIDGE_PORT live patching hack
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


--nextPart11258618.edMe0jPaLm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 21, 2015 08:04:41 Sven Eckelmann wrote:
> > The macro is used in compat.h line 55, is it not ?
> 
> IFF_BRIDGE_PORT appears in this line but here is the context:
> 
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
> 
> HERE IT IS *NOT* USED
> 
> #elif LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
> 
> HERE IT IS USED
> 
> #endif /* < KERNEL_VERSION(2, 6, 36) */
> 
> 
> The IFF_BRIDGE_PORT (which I call unused( is only required in this other 
> compat hack when the kernel is >= 2.6.36 and < 3.9.0. But the one I want to 
> remove is only for kernels < 2.6.36.

Good point. The patch was applied in revision 312ea8a.

Thanks,
Marek

--nextPart11258618.edMe0jPaLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNhABAAoJEFNVTo/uthzAbUoH/RJVwEsS+sWFYeKxfgrdErM+
TvOQ6fgQ1ETtKhdzWKCZGSpq0HYfgRC2f5tgvxhS58RuVRSNGPP5dZxtf7xWuceq
fbN2iOHrw76Fu2cpsFyNYYpMwlBNDp1ADtWCTV8444/JIeguSwPuBqnMXd7Mo/kw
rr+9JOr8gu1udq7jxnGrUy0lhsGaLS7YHZpyzV55CocPdWRDFcH691QDyOH5BFH9
kVqR4V94o4pABxlascVJo3DvQWjV0zNRRXRAVKsSRfcN2CAU9GH+XR97GHDkqPnY
nanTzjSSN8QCmnurKSyp/vBnsiAKHCN8GgXdyO6pc+O9mfNtxVcyiXNrRFWy8DI=
=wnQg
-----END PGP SIGNATURE-----

--nextPart11258618.edMe0jPaLm--


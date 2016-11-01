Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 08:31:10 +0100
Message-ID: <3669673.gKaFvKQAYj@bentobox>
In-Reply-To: <20161029120749.5847-1-sven@narfation.org>
References: <20161029120749.5847-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9662251.7sY0Unf1Dt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Add module alias for batadv netlink
	family
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

--nextPart9662251.7sY0Unf1Dt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 29. Oktober 2016 14:07:49 CET Sven Eckelmann wrote:
> The batman-adv module has to be loaded to fulfill genl request by the
> userspace. When it is not loaded then requests will fail. It is therefore
> useful to get the module automatically loaded when such a request is made.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/main.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied in 8ff77a6061bb7669e1332115b29e4eb26c2666e3 [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/8ff77a6061bb7669e1332115b29e4eb26c2666e3
--nextPart9662251.7sY0Unf1Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGES+AAoJEF2HCgfBJntGLxcQAI7HU6Oe1r530pBbJR7cGD8Y
Zv1SI+9mC6VsKqnVHMXMYTOuk25AIB6gDwFfguKOR1BFmEf2+G7Iy8YUvRpDKkq4
mIrGckiWlYi/fnv+Csm2KvqlyqoDR8X8pxhmw9ljVf0HyXogAdSap9k4JSf3CHEU
HYjO2FMnkfxqSNa5Nyc4FPiEwXajZxksQNyW7/hlAEZs2NiMgin3H2AQpqLLdPfO
LEomJNTpQJ0287HCIxvQCLnDpR09s7NIWnQb8EgDmkUlEXHW4r+/tWoug857cP/N
DyptUEnwwvFIFLxs6fDSwFi/AcackWmldtCwl6fRr16I/Do7McJ8zF+2tlq6wdf8
xxeu/82ZCvz1+s3PJr0SsfEW30od+f2iK3kpTGF3f9Sg1BkJSJ7/CAbzBcDIdCzt
4m23kKpr87J98C0pgKASzkTKKSQj/VCexSfhbx+K0hMOmLZwbyNIamvfUIX0Pkh+
lS/CIX8Uf/yBUU2J3Xo7r5YG3MgTx1yfpW+CCoUpOV98ceo16NtmsLiuKGhqR87r
TA+SSyri8jzFWiJ5Sx3aAj6nvLveja0dsFY2tNsVF+SH5LN+ZbyGvexQSN6qW//+
8CCsMuFgEFmbHy1mpxiYpLgoL2MXokxar5Fpf4wBEfDIcPj89Byh85ud/q93RgxL
cUOYZPZXCt7zodqiH25l
=TEsG
-----END PGP SIGNATURE-----

--nextPart9662251.7sY0Unf1Dt--


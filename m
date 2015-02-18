Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 23:45:04 +0800
Message-ID: <23381002.yeogTpj88W@voltaire>
In-Reply-To: <OFC2424D81.A822433D-ONC1257DF0.005393B1-C1257DF0.005470B6@phoenixcontact.com>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <OFDE6F3C6C.B8D7D72A-ONC1257DF0.0050412D-C1257DF0.00521AC2@phoenixcontact.com>
 <OFC2424D81.A822433D-ONC1257DF0.005393B1-C1257DF0.005470B6@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1994053.MmbfdVIdCv";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Antwort: Re: Antwort: Re: Question
	concerning	batman-adv bug	#173 "Mesh	packets on bat0"
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


--nextPart1994053.MmbfdVIdCv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 18, 2015 16:22:18 Andreas Pape wrote:
> good news: the sum of the three patches you sent solved the problem as far 
> as I have tested yet. Now bat0 works in combination with the bridge and 
> also ethernet traffic is bridged into the mini-mesh setup I use correctly. 
> Furthermore there are no ogm messages visible anymore at bat0 (with the 
> command batctl td bat0).
> 
> Do you see a chance to add these changes to the compatibility code for 
> older kernels (I guess for kernels < 2.6.39)?

Sounds like we are on a good path! Glad to hear that!

Ultimately, we want to fix the problem and support the older kernels correctly. 
We still don't know what exactly created the problem. Can you try the patches 
one-by-one and let me know if a single also fixes the compat issue ? The first 
patch you already tried - remains patch 2 and 3.

Cheers,
Marek

--nextPart1994053.MmbfdVIdCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5LODAAoJEFNVTo/uthzAtxEIAKhXUvJ4hfqpoxxv8R28Q4YL
RmEbL7tuZuStvDZ8xS+FLxBAdRn3mO9jpV8qGf1Ywq5dPsYqDxjj20am0EwWTLAB
kuJSPVgfTa4515klWLB7RQ+uSdQ/r/hcnjEFe7mDcrGY0JJA46yk+1jt57rzIbkx
ZTUV6qTOoFFYV8anuiR743FNvyHxVObcSSxktnBUDPbxaHgQidWep7FlqMGzBM7u
7ysZLSNz02LBesTMr07Aanmv2uic1O+foapaUR2h8QSAZfzyUuElG7fIaidbnHNE
V9ggyYVYkY6H6Qytu5wwm5mJH2ZybW6hmM/43hx1WpOni5z+Qu/7Xw1iOZZymYs=
=Ccjm
-----END PGP SIGNATURE-----

--nextPart1994053.MmbfdVIdCv--


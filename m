Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: Batman-adv packet retranslation
Date: Mon, 25 May 2020 15:34:51 +0200
Message-ID: <4309595.MtDqpTPQ1e@rousseau>
In-Reply-To: <CAOVt3fG9AbAEMP+uKLy8Hsnub6=hAJG2Ekg3vrC__AqVJAdZHw@mail.gmail.com>
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com> <2164745.TYCVdmGlQZ@sven-edge> <CAOVt3fG9AbAEMP+uKLy8Hsnub6=hAJG2Ekg3vrC__AqVJAdZHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2484156.u8uEVRVafc"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

 
--nextPart2484156.u8uEVRVafc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 24 May 2020 23:53:05 CEST Alexey Ermakov wrote:
> Summary: If I don't set override throughput, batman doesn't switch
> back to ster eth0, but if I set it, retranslation doesn't work
> properly.
> I believe, I should tweak batman and I whould be happy if you say how.

To give advice on what to change, please provide the batman-adv routing tables 
which allow us to understand how batman-adv sees your network. Please refer to 
Sven's email with various examples.

For starters, we can focus on a single setup with originator & neighbors 
tables. then you can explain what isn't working the way you think it should.

Kind regards,
Marek Lindner

--nextPart2484156.u8uEVRVafc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl7LyXsACgkQU1VOj+62
HMAT8AgAiqjQ5WasOtdBtoc16guL96EEsefj/xgTa2eIOPKdA/TfPzx4t3GkknEy
7cdgOFhJTIJOrJ8S+jFnZhrL+22/W99LWw51KOzPPtG0bn71tE+7OOi02pHY8Em1
khjs8IUY1LiNd0vkpe3BwVfFQH4QRcTwJEJDgsTKaD6ZtE1QyjNGRkTdM86sJR/U
eqH2dnF2heGknPiaNck3whMWWKNOXgYEbGz2k9jgvAYdy3djYI1CyyC2INI3Dgn2
h75594Mo+v+byqOmA2z8SAEw8R80iDwDv/4Fo1q3ugQGIEyqexOcbbQO2G6absGs
exZ9arB0DHdaSdKlLSedtoyvXeq9hg==
=xuM1
-----END PGP SIGNATURE-----

--nextPart2484156.u8uEVRVafc--



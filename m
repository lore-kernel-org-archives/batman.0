Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 2/2] alfred: Simplify calculation of fixed size IPC TLV
 length
Date: Wed, 12 Jan 2022 17:11:06 +0100
Message-ID: <1842756.Lh0aRYJY5D@rousseau>
In-Reply-To: <20220104091103.162365-2-sven@narfation.org>
References: <20220104091103.162365-1-sven@narfation.org>
 <20220104091103.162365-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5473470.eyY3ROyXAo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

 
--nextPart5473470.eyY3ROyXAo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: [PATCH 2/2] alfred: Simplify calculation of fixed size IPC TLV length
Date: Wed, 12 Jan 2022 17:11:06 +0100
Message-ID: <1842756.Lh0aRYJY5D@rousseau>
In-Reply-To: <20220104091103.162365-2-sven@narfation.org>
References: <20220104091103.162365-1-sven@narfation.org> <20220104091103.162365-2-sven@narfation.org>

On Tuesday, 4 January 2022 10:11:03 CET Sven Eckelmann wrote:
> Instead of copying the same code to calculate the length of fixed size
> TLVs, just use a common macro.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek

--nextPart5473470.eyY3ROyXAo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmHe/ZoACgkQU1VOj+62
HMDy3gf9HmSb/QqVrMqOOfbS2Nj3+aYkyf++Hfu2U4D1DqKuaymlyoAruD/mj7FV
r8T+cJbc2ysWU1Ud2WjmcYRQdFxnGSd41hTuTYL4OnbN3ZASFmWmk7mVdoFd1Qzz
2PDh3ivoTwSd/hJHk00SzYDKlKLxy5LUadQI4Ej8RYpktufT4uN8bJF+GJF6vXM3
q5HRY8ccSIrOWZb3JyL2uFiL886wy/ZxFq2R7P7o16U5Hh4e7yx/GWEOAxjPAIGF
P/UYsd7Z0Ge4ki4B/4l4pkKMHlnWZ5hsZuw9BHywxfdQIWlUFap3yan+WFmjCNEH
RRX8314cnk9pfHUfF1U1sSE4mfLwKA==
=zhQi
-----END PGP SIGNATURE-----

--nextPart5473470.eyY3ROyXAo--



Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Mar 2017 12:44:59 +0100
Message-ID: <1615223.p23g8khHDd@bentobox>
In-Reply-To: <20170308114359.26916-1-sven@narfation.org>
References: <20170308114359.26916-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5377389.NsRLCbqjcT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use __func__ to add function
	names to messages
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

--nextPart5377389.NsRLCbqjcT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

this should mute following warning from checkpatch.pl:

    WARNING: Prefer using "%s", __func__ to embedded function names
    #876: FILE: ./net/batman-adv/tp_meter.c:876:
    +                              "Meter: batadv_tp_send() cannot send packets (%d)\n",
    
    total: 0 errors, 1 warnings, 0 checks, 1502 lines checked

Kind regards,
	Sven
--nextPart5377389.NsRLCbqjcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAli/7rsACgkQXYcKB8Em
e0bKiw/+O2YUVuw1VZnnV+mT1U2okwcXUv6t2CayV7mZc4UK9+kmVzVF/6BxBYK3
gOXzdJfo1mRRAAHbeVV0IdFfs1H+uuUD925efzG9/kTa3QBib3ckJck6FyE8hlRb
MxMGeQVQAAiAsbBkZjMXNBpbRLTKZhAL4XahOU/Ain2g0GEZEpcsIiluNBKMPD26
nhAJs86T8j0nnQhnGkDd4uJ3amY76OmH84hy/4DRm3ggWvdLjRAAE/ojI7F5R3Zo
+lYuc3uq+b6z68zY3WXrgb1zZLarH2EB+CXWnOBs4+5b/KPf+kyCe81npWg+skCV
iU9JJ+Rf645qgTMknpOpMtc+bikV36lcbFyzlPiicO25V3R59GGa66FQHJh0mLlZ
WNejGHzZcxJXKgj7Gh46gTAWVJKbEiazFuEulTvSI861mqpaViTAaFvW1/noAPTk
+90njtsE21PdOA7PlUto5nNH03vVjAoSBk1K9YDPrZLSn4W97Tf4FpiLkiR4FJpI
Nwma1btCiwCw1+s4201Cns9uw7KdJ+RZU4Am6IlKG9dwiS3unZO6irSBa7nmwQRu
KWLGM3bPOuZcHZBS3YQ8RJsmyenw0+EnHVNDB1+xxhf110wvVlIY6u7k+J2YyWNM
rWejxoSikJWL7mceeFquOPNxRpickDdrggjhtaLHzUBNlgYyZz0=
=1J5u
-----END PGP SIGNATURE-----

--nextPart5377389.NsRLCbqjcT--


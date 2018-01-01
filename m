Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 01 Jan 2018 13:12:53 +0800
Message-ID: <2542365.bvxhBZAykN@lafayette>
In-Reply-To: <CAL3ir7LUCHfyxegLn7qbx8cQ_H73V6AnTtBBN2eUPg7Wwn3j+A@mail.gmail.com>
References: <CAL3ir7LUCHfyxegLn7qbx8cQ_H73V6AnTtBBN2eUPg7Wwn3j+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart60604854.MCaNsgUNgo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] 11ac throughput on mesh links
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

--nextPart60604854.MCaNsgUNgo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, December 31, 2017 8:41:03 AM HKT Daniel Ghansah wrote:
> Throughput: 13.61 MB/s (114.15 Mbps)
> is this inline with what everyone has seen. That data rate established is
> high however the throughput is very low

>         tx bitrate:     6.0 MBit/s

Is the tx bitrate field what you are wondering about (vs the measured speed) ?

This is a known bug caused by the QCA WiFi driver firmware blob. The exported
TX bitrate value is utterly bogus. Only QCA is in the position to fix that.

There have been attempts such as this one:
 https://github.com/torvalds/linux/commit/c1dd8016ae02557e4f3fcf7339865924d9357f76
Not sure this fix addresses your case. Sven might know.

Cheers,
Marek

--nextPart60604854.MCaNsgUNgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlpJw1UACgkQU1VOj+62
HMAFcggAorQtlYdB7bgYrRHGkMqyo3QgyYUuVawAt3WldW7kMRyzpLs5jSJBFhSS
/Td1L79y2i2yE44rRgCZJUJqilzVRTpQ/RMBFrrH23aVURv9z3nkQgx9N16EsJdY
JncZ7UNQ5aiNBXErrD5hE+a4Bty6+JJAdzjSpcoi45ISPykV4yyrzPrfJ7kOhR06
qxUYef4ufQtBu+85cXnbtozBYj4QAPlNCnESEjaOtJvEeb24d4B9LOWa1jLnMw/o
rF7udlf4tCKjcI0LAmkQ3l/5jc1XhldWEtonNSnUAZ8YAGPoVykf9Quogbc3aX33
mqJhGk+I37h/lDLN2jCDi888Bo/d0w==
=q7Yr
-----END PGP SIGNATURE-----

--nextPart60604854.MCaNsgUNgo--


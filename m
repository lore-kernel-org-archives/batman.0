Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 16:54:06 +0800
Message-ID: <18772369.TCV0Di1s1y@voltaire>
In-Reply-To: <54C4EE81.1050902@jluehr.de>
References: <54C4EE81.1050902@jluehr.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19813488.hUGWEksKG4";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Understanding MAC-Adresses in iptables-Logs
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


--nextPart19813488.hUGWEksKG4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, January 25, 2015 14:24:17 Jan L=FChr wrote:
> there appears to be some misconfiguration in our network. A gateway i=
s
> blocking unknown ip-addresses:
>=20
> [658047.514011] FORWARD DROPPEDIN=3Dbat0 OUT=3Dbackbone
> MAC=3D3a:81:5b:64:fa:32:08:fc:88:9b:8a:60:08:00:45:00:00:4f:6c:b1:40:=
00:3f:06:
> b8:8e:0a:a6 SRC=3D10.166.28.69 DST=3D173.194.65.188 LEN=3D79 TOS=3D0x=
00 PREC=3D0x00
> TTL=3D63 ID=3D27825 DF PROTO=3DTCP SPT=3D45173 DPT=3D5228 WINDOW=3D91=
31 RES=3D0x00 ACK
> PSH URGP=3D0
> [658047.519455] FORWARD DROPPEDIN=3Dbat0 OUT=3Dbackbone
> MAC=3D3a:81:5b:64:fa:32:08:fc:88:9b:8a:60:08:00:45:00:00:34:6c:b2:40:=
00:3f:06:
> b8:a8:0a:a6 SRC=3D10.166.28.69 DST=3D173.194.65.188 LEN=3D52 TOS=3D0x=
00 PREC=3D0x00
> TTL=3D63 ID=3D27826 DF PROTO=3DTCP SPT=3D45173 DPT=3D5228 WINDOW=3D91=
31 RES=3D0x00 ACK
> FIN URGP=3D0
>=20
> I'm somewhat confused by the mac-address here - it's very long.
> Can I somehow derive, which originator or client is propagating or us=
ing
> this address?

If you posted the iptables rules with which you generate these logs we =
might=20
be able to help you.

Cheers,
Marek

--nextPart19813488.hUGWEksKG4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5FMxAAoJEFNVTo/uthzA5fIH/A2aJ/hD3y5wqrUkAhnwh0wO
aBPItO1pqeAZd/f+0G//cNSUZFttDgL4NRhbir1jJJ3tPmvCf6US8OS2Ys5XHNnL
m6+3NIFyEuq0HET9YVW3JrXcf5IDkci14irhCdK2AVEURHIYYzmGnasBNPqTXk0b
WNTB+Qc/kG4i9BKnNwPebjDcZhPGjx8H9hv8GiyuBHVvEYqn9/FBgq9PAy41iiSM
k4uQcmjzBq2MqtSaqO06NkxZvu1pCxAZkNIuS/LrWHrPyFZQRMb5QuUOi9zFQ5ub
Ro1SgrYOBnaHBSeDdTzA36quirxddsJWRrEJBkzJcWsUR/j9W5H/z/BqTH7liKQ=
=xtBm
-----END PGP SIGNATURE-----

--nextPart19813488.hUGWEksKG4--


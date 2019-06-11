Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v4 1/2] batman-adv: mcast: detect,
 distribute and maintain multicast router presence
Date: Tue, 11 Jun 2019 07:44:12 +0200
Message-ID: <1705254.clgQh6sisM@sven-edge>
In-Reply-To: <20190610231414.GA10498@otheros>
References: <20190610004535.13725-1-linus.luessing@c0d3.blue>
 <1984348.Q8u5oXqQmF@sven-edge> <20190610231414.GA10498@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2678157.XC5bmeGSN8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart2678157.XC5bmeGSN8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 11 June 2019 01:14:14 CEST Linus L=FCssing wrote:
> I'm currently unsure when we would need that. Are you suggesting
> to interpret it that way, just in case we might need it some day?
>=20
> Note that this would also be a "soft compatibility break". So old
> nodes would still interpret 0x1f the same way as 0x07, meaning
> they would send all multicast traffic to nodes announcing either
> 0x1f or 0x07. It'd be a "soft break" because it wouldn't cause
> packet loss, old nodes would just overestimate.

I am just unsure how we could/would interpret this in the future. Not that =
we=20
need support for it in the first version.

Kind regards,
	Sven
--nextPart2678157.XC5bmeGSN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlz/P6wACgkQXYcKB8Em
e0Yb1A/8CfKHmrUCURf7MNCFJzoYxC1wddIHjEwpNWJhC1ubzxgXMPk5HRBxT07K
TV7O6N25zUFdRjt/4OPqlepdE82f8sUiezlvcQSoEBpEMN1DYnjHvpo39umDDf8Z
HtHozA5ZUkYFd59CskyavkvopY2ENkdgrQSw1C9qwLKDaRhB0aWAqXAGA1F5uNS7
N6NRM7dv/ShKaomjbZwbcUo6O/GTvajGmIyJViaVr790d6d3BWeU8OkYPA4yFF2l
Kg27/YguXjv0ywpx++sDQV73ezrzNH59yBTQZ4nQI0aDTMwr3ZSENwl4ZKGfCPHZ
UgzbVxCrezj15F4VlsomzQSKHlAOvIXT+FZ4prYS7O97AOWc/xd78jDMctJWpzhV
tB/EawT4j4WjMRC6qt6ftwE9R+4GG0x92DspQKf7xmqbBx4EAJ8OtP1Y47jpqYMG
8oKeTq+mGNHx/hwGPPz02ixy5WbF4Ljwzf/hkzPN4eP1d/F4bRY5+8mDlOP+n4v1
ji9mCJm8qjr4KhiFFx6EB6E31t6P5gO+znPo9JDO6umHZjtCQY23xZhwWTggeXdU
Z6NIDzWrNTMns88YWQTBZ0fmZb49pSTHI8mHHYAf+t8kZIp/crAp1IdyF1TDtOcm
wJRh6ZEyQ1WBi/fHy0I00BkPaham9fG8MsLaQuSklYBrXtDKJOQ=
=8aS1
-----END PGP SIGNATURE-----

--nextPart2678157.XC5bmeGSN8--




Return-Path: <a@unstable.cc>
References: <20180831130844.5434-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <88b5cc09-8844-d306-000d-927beedbbb28@unstable.cc>
Date: Mon, 3 Sep 2018 00:08:33 +0800
MIME-Version: 1.0
In-Reply-To: <20180831130844.5434-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sHHn7RrJ2XeHfeUBpIcJXOdSP6icI2jm8"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Avoid probe ELP
 information leak
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sHHn7RrJ2XeHfeUBpIcJXOdSP6icI2jm8
Content-Type: multipart/mixed; boundary="twD9QEOREYEIzrSil6GLMth2Jxr2ux2PU";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Message-ID: <88b5cc09-8844-d306-000d-927beedbbb28@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Avoid probe ELP
 information leak
References: <20180831130844.5434-1-sven@narfation.org>
In-Reply-To: <20180831130844.5434-1-sven@narfation.org>

--twD9QEOREYEIzrSil6GLMth2Jxr2ux2PU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 31/08/18 21:08, Sven Eckelmann wrote:
> The probe ELPs for WiFi interfaces are expanded to contain at least
> BATADV_ELP_MIN_PROBE_SIZE bytes. This is usually a lot more than the
> number of bytes which the template ELP packet requires.
>=20
> These extra padding bytes were not initialized and thus could contain d=
ata
> which were previously stored at the same location. It is therefore requ=
ired
> to set it to some predefined or random values to avoid leaking private
> information from the system transmitting these kind of packets.
>=20
> Fixes: bedcadfaa92b ("batman-adv: ELP - send unicast ELP packets for th=
roughput sampling")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>

Great catch Sven!
It seems like the leakage can be fairly severe, therefore this patch
should definitely be shipped to stable later.

Cheers,

--=20
Antonio Quartulli


--twD9QEOREYEIzrSil6GLMth2Jxr2ux2PU--

--sHHn7RrJ2XeHfeUBpIcJXOdSP6icI2jm8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAluMCwYACgkQB6U8WA7y
zXQoLRAAwFOH1d2iWgiTQeOw3FiAm7zv3NXqGhJsMVGqiA9hj2FvQB/K9F9dxruz
j8WI4W8JQNLTxKEeqmkEaYk4/ZU8t7RgNbt3hOySByGT2JOJTdqV7xAaD0Bl05TL
buaWatK8jBRVMWG5yKFoepBQb/RLRhSytH/YP8N5yYJ1iuAA3QP+XUolTQCN/OCR
iF8tqw17h2EaZGkVNoOLeLEEtgQgI46Ao30q4A2KTRcbIFgptbBrcBZwo0x9+Gwy
Ya8dCHukkFCOWYaPbL9/Hsn4o3jX7IOGtoQ7q49txsmKjKzx82yJefdGMC0ttXoD
joz5QB8aJAIlow11rJMMddQMZHZGFTEMu2YYYHr9YXMyQc1Pfw33WxeCo5q5vhoZ
UpwB1Wm1hjGKizZ9TCRM0POq1sUy4c3vLEQq7Q1445siMv7Q4SnzxefJ8iMfN/e7
MY27a7ivZrKXQZkdjD7OzPDyLP7QVR4myHCp5wIthFy/40SJziT2jgHJuEcBLL0t
gumNKiOKv9e9syDVTcpI/lL9RTr4knhftEAawV0zSscb+t+kHER1SDGVeeL9/9vh
h5OIEO9y8w310f16W4xQd2J8s4ZIsFezd4rVVl3fy9fNRpU48PsSXiG4YR1PkD4L
Oo9wtdBaXI+mksNb0WYlyByD4qoViyiNu/lWO/8vhPMfkfL5o/E=
=waEN
-----END PGP SIGNATURE-----

--sHHn7RrJ2XeHfeUBpIcJXOdSP6icI2jm8--

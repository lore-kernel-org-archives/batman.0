Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 10 Feb 2016 18:21:31 +0800
Message-ID: <3730234.4K1dvT2BxX@voltaire>
In-Reply-To: <1454308474-23211-2-git-send-email-mareklindner@neomailbox.ch>
References: <1454308474-23211-1-git-send-email-mareklindner@neomailbox.ch>
 <1454308474-23211-2-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1816329.tFKW2ituQp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 2/3] batman-adv: convert wifi
	driver throughput to multiples of 100kbps
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

--nextPart1816329.tFKW2ituQp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 01, 2016 14:34:33 Marek Lindner wrote:
> The expected throughout returned by the cfg80211 API is expressed in kbps
> while internally batman-adv stores multiples of 100kbps. Ensure the
> conversion is performed properly.
> 
> Fixes: 5c324517 ("ELP - compute the metric based on the estimated
> throughput")
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/bat_v_elp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision c59b8c7.

Regards,
Marek

--nextPart1816329.tFKW2ituQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWuw8rAAoJEFNVTo/uthzAL+gH/jEL6oM+iH2Y6C5+Fq8Y0qUh
B9joaVES1LHX9D2juT22673dPyIBCyTKzUfIs8oBVDv/Dd/bEbv75ARPuA+EtV4n
mREvN07FE1kNq1OQQpAg2sukjA1K/OxmP6Wnp10LD7bghoVK4uIH4mQRUIKctgZh
2NDURKtz5NuGR9OAnlu69DPAO9/IVx4gjZ0scddjHUFUKag7kIIMuNkNrGX0Fwwt
6BMrWLw9ugSlEQGDoXNxLH1hCFk/KpuL7ZVBsjYMI0mV8Hr8rYyPunlmEQct9nrU
IAnkGwLLchAW1buTpNXuorYAAJObFEEK0VsHtA7NiIR/rS27cqv4SMARL2EAd2k=
=HJNy
-----END PGP SIGNATURE-----

--nextPart1816329.tFKW2ituQp--


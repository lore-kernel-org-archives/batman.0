Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 18:00:58 +0100
Message-ID: <1748353.QbLSAN5R7v@bentobox>
In-Reply-To: <1363583397-4800-3-git-send-email-linus.luessing@web.de>
References: <201303071427.27817.lindner_marek@yahoo.de>
 <1363583397-4800-1-git-send-email-linus.luessing@web.de>
 <1363583397-4800-3-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1760988.BhDAFFbagb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Fix a potential
	bcast/ogm queue purging race condition (1)
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

--nextPart1760988.BhDAFFbagb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 18 March 2013 06:09:55 Linus L=FCssing wrote:
> - Perform queue list addition and work queueing atomically.
>=20
> Otherwise we might potentially miss waiting for the re-armed task on
> interface removal, leading to freeing packets with the re-armed tasks=

> trying to process them afterwards, therefore causing segmentation
> faults.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---

It looks like this patch and the other two don't apply anymore. Can you=
 please
resent them or mark them correctly in patchwork [1, 2, 3].

Thanks,
=09Sven

[1] https://patchwork.open-mesh.org/patch/2798/
[2] https://patchwork.open-mesh.org/patch/2812/
[3] https://patchwork.open-mesh.org/patch/2786/

--nextPart1760988.BhDAFFbagb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4ahLAAoJEF2HCgfBJntGLkAQAJMNvWY9EUfNom3tp0RnYQRd
b/kJmbeDV45XXZkear3NAedXM7ilfhcyMLRxq3PyfD9f5qu2E9k0OTBiLAj1nTDi
x13dpCkj+Zf7oXA6AF6x2Dcivlru6zYtHoOGXYSIggYg/2UeghraQ9S0rSqSoP2V
RVkDeicVhefWF0NJBMYEB2VXOmAtjsdIMSbXGAOuMLjqKL7O99heZUr0MGvldPeY
7KM12ewCFP/AY/1jSULfxN/Z9dogg4VXooodT0X++RvNSYS6+mC1r/mQLHh4VlhM
YaATiPrFyyWviAht3trk2JsOASi1o/8tbXb5sQABAeEzO5I2syzMgqvOQ/jMFKxF
zN1N2Uo2XfVaIZ1EeatIOkm5ONmOANbLfFD8dQBMHWEGYXvbHMEk06E/kAcRciY7
aP9MzaXW6sJFOuFKzI8xepQotUQLzrgyOjCuKXGq8EaLSHsrx7POMbpBO+34WxqA
kn8KvB43eLHXdjLS0HC3PjucmPt5qpSIv5pa5w1FIh/c4JXqu1EnU72as1jK3RJF
D80JduUSIuAbWnKjAW6DjyOkgZh2ryz8aX01/pcMjhGfsamNIH2x1GgUJcrEYp3O
DHvEJJ4W/P0HZX0U+zYKRiPt/HHXBikuKOU65lwtVyBoapsu0HFD3kNiLkXg/2+L
0SRCr1n02tQOjUFhBZVE
=K6cv
-----END PGP SIGNATURE-----

--nextPart1760988.BhDAFFbagb--


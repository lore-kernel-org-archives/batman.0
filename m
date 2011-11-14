Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Nov 2011 10:38:07 +0100
Message-ID: <9935980.KTPM4GpO8u@sven-laptop.home.narfation.org>
In-Reply-To: <1321261892-6401-1-git-send-email-bug-track@fisher-privat.net>
References: <1321261892-6401-1-git-send-email-bug-track@fisher-privat.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5529968.oTBt6NFWhF";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] add make install
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: lindner_marek@yahoo.de


--nextPart5529968.oTBt6NFWhF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 14 November 2011 10:11:32 Alexey Fisher wrote:
> Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
> ---
>  Makefile |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 5762721..44bad88 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -42,3 +42,6 @@ all:
> 
>  clean:
>  	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
> +
> +install:
> +	@cp batman-adv.ko $(shell dirname
> $(KERNELPATH))/kernel/net/batman-adv/batman-adv.ko

NAck: Sven Eckelmann <sven@narfation.org>

Please read in the current linux sources Documentation/kbuild/modules.txt

+install
+	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) modules_install

or to override the old version that is included in the kernel

+install
+	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=kernel/net/batman-adv/ modules_install

Kind regards,
	Sven
--nextPart5529968.oTBt6NFWhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOwOF/AAoJEF2HCgfBJntGGBoP/2moqpAR91NIkiYm7zCsW7R2
WvgkxNoLd2k13V59OxQkdvRr3o2qNf8rmLlmfEX9996aiv15l5HzqI8Swm7FzWnm
DpiNYkVEWHKr4XaVeKTHWbb/tHRJZ0h0YXG16nEC6Q09Vfz4EW9Xs26HV3gI52Ad
hMgOUs9XuItpWTpBYZsIdnlx8QZS222Tghe4FD+wkDAFRGT3xD6KcdI+ycgRqOie
OAJcwfKxyedKPeubH90hUyiKi/aGsunhjsOP5wG3Qq8JGlDCLbPM6K5LFXOZxv46
eSq/OH92ak12qF/nhb7Nyw1zftaau0ZTGhTTGEeXLrHFQfbMP5BK4KOnkQvDDKre
pFYMVbtVD04RqAu3CRO7ZGxvAEv6+7CMnAK8NK5GFN7xvM8jrluJxh79ClQEhOVh
EMfkkQ2n8SsTE0J0wBNfWw5MdB3dms5eDIe2zZO7d7weak8a45qQqVblqIwVO7ix
ewkaozuWsb13t+zPak5AaQXLltCaHyjEFV2ycjGDvBwizBrdgPfp/WgCD9cKYPlD
h786Ihd+s47yWjSzCow37UwHeg9jy+CIU2CVwV/W5GECXNvJZGaGPfADECfqNMx5
OZSt2j6VCwi/nCePtrpVQLk8OTfoNpNMji8xpM7OM7DWZDqHTNgqaMbFI/d1EUo2
e2QkEDft00CLwdUPSiiT
=fd6k
-----END PGP SIGNATURE-----

--nextPart5529968.oTBt6NFWhF--


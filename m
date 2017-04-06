Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Apr 2017 11:27:10 +0200
Message-ID: <2195040.ykU6RrkfU7@bentobox>
In-Reply-To: <56f44583-9cbc-d3eb-20c2-b8243a7889a1@gmail.com>
References: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
 <2383073.8lvV2lGcs0@bentobox>
 <56f44583-9cbc-d3eb-20c2-b8243a7889a1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1777374.xPIVrjfcGD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Does batman-adv works perfectly?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Xuebing Wang <xbing6@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1777374.xPIVrjfcGD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 6. April 2017 16:05:26 CEST Xuebing Wang wrote:
> Hi Sven, Simon,
> 
> Thank you very much for your help. These 2 patches are not merged 
> upstream? I did see a similar patch merged (as you 2 are the authors, 
> you know it very well):
>  > [1] https://patchwork.kernel.org/patch/9433619/
>  > [2] https://patchwork.kernel.org/patch/9433621/
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a34d0a0da1abae46a5f6ebd06fb0ec484ca099d9
> 

The deaf patch is not applied upstream. But yes, the deadbeef patch was 
modified by Felix and then applied upstream (the commit you've listed here).

And these patches (in patchwork) are much newer than Chaos Calmer. So I would 
not expect to see them in the Chaos Calmer mac80211 package.

Kind regards,
	Sven
--nextPart1777374.xPIVrjfcGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAljmCe4ACgkQXYcKB8Em
e0a/ug/+N7YIq0zX6yeigj6dtRF+4IWRmfmu0etWCV7ebpJVnTCNh8s8hHwp9qMI
nS/p/pCpgPzX70e70jYsBwFK/ceHn0E6HyAzFIz0hhmmj2oirWHHo9DDRq/HhpTz
zQQQuxsZ+palveE3v3kGNbYJP5zs+v2Vi4bUL7yPb1fVcaHUZuNFaNfM51aZAAuR
Kq5MOD3eVfn7gpFk6UuL4x/G4JvVDUcC0iq9QfqlGaC/3fStXF3knaL6hOQ/Xirq
xRQjgGvq852ONlkKWSxbYSyetBo4IMzaddrKLbvXv9F3J+Ce3rb1uNcYMVI29j2I
Qo9k49UoUwcrmY2IafZLapVSDRa/oVu4tQIDWX2XgKwkMPoA5l3u6Pj5rURsr6Gx
4VfKdPjv9gw1vkpbKAQKmG/dMSvUMRnWZ9g5UkVRY/c6g/FF4fOO+GCe54/tVlPy
HcIxLIjmHH8lbk/uoOjeP1LofZmuifm/cLyksNGAKMF8rkBJFwRfN+UagEA+A0Fc
6kiQcPgjrVCncM5tT4ggtWf3PUikrkuT7Z6DskG+69k8X19yEhaXMX5mniE2weMj
3ivx1FjGQwWPjhJt8Dim3D5brbPgU7b6M/BZdAVLkHMo1RuZy29mm3QYxTENLO32
Ho4q+QkBppBfin/jv2LfBEwpzbBncqB62CONrq7cjNitYOoCBZg=
=mpa+
-----END PGP SIGNATURE-----

--nextPart1777374.xPIVrjfcGD--


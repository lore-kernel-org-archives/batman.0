Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Feb 2016 12:43:27 +0800
Message-ID: <2259545.lEtA3AoCDO@voltaire>
In-Reply-To: <23488110.8Oiix784PY@sven-desktop>
References: <23488110.8Oiix784PY@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6562614.BLmEXTe76o";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Patchwork on open-mesh.org
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

--nextPart6562614.BLmEXTe76o
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, February 21, 2016 16:39:22 Sven Eckelmann wrote:
> I've used my free time in the last week to look over the 5246 patches which 
> were sent to the B.A.T.M.A.N. mailing list. These patches were categorized
> as
> 
>  * Accepted:
>    committed to the respective repository at git.open-mesh.org
>  * Rejected:
>    Either rejected by the Maintainer(s) or withdrawn by the Author because
>    they turned out to be a bad idea
>  * RFC
>    patches which were just posted to get comments
>  * Not applicable
>    patches which were not really for a repository at git.open-mesh.org
>    (for example patches which are forwarded to net-next.git/net.git)
>  * Changes requested
>    Patch had flaws but these could be fixed but the author of the patch
> hasn't sent a new version of the patch
>  * Superseded
>    New version of the patch(set) was sent which makes the old version
> obsolete
> 
> The result can now be found at https://patchwork.open-mesh.org/

Thanks a lot for doing all this cleanup work! I doubt any mere mortal could 
have reviewed the state for 5000+ patches on a rainy weekend ..  :-)

A few questions as to how this works:

* [PATCH] MAINTAINERS: Add patchwork URL for BATMAN ADVANCED
 -> Manually marked as 'accepted' as it won't be easily detectable as merged. 
Correct ?

 * [B.A.T.M.A.N.,2/2] batman-adv: Split batadv_iv_ogm_orig_del_if function
 -> Merged patch today but still shows up in patchwork. Should we wait for the 
auto-detection or did I do something wrong ?

 * [B.A.T.M.A.N.] batman-adv: Fix integer overflow in batadv_iv_ogm_calc_tq
 -> Marked as opened but has been superseded by '[B.A.T.M.A.N.] [PATCH] 
batman-adv: Fix integer overflow in batadv_iv_ogm_calc_tq' that was merged 
today ? Shall I mark as 'accepted' ?

Thanks,
Marek

--nextPart6562614.BLmEXTe76o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW0nrvAAoJEFNVTo/uthzAdPMIALSnYlmiCBtFRonxr6K+iayD
V1H4p+Vthhb8Tlr2DaRYDTXrGHFB4bt7YPZIJeY9xQzPki/qaMhSqFfht5uQhDt7
ZBIfbKtK0yUxuISjQri1c+SpGPTkAtaNfImg5OIRehOkSGwNNyjcFFbqlMR+HkKJ
N5PbjxdwvnOwhC40rsMyzIUHHnWP0pFXQzpVHPIIb/SZn/+SvAb8BuOxD79eQ6cu
Jxmc++8L0wi/wreZXminWKZ/mniuXSbK2sNVLpHHKlKh2Rb5saXiPHcLiG1HVHbO
0WsBlQKAU4td9UURebN45QmknqaLCpGe23zJVpwvRq1coJfpxaYCuJUEUY71R00=
=MTCV
-----END PGP SIGNATURE-----

--nextPart6562614.BLmEXTe76o--


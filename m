Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 18:58:30 +0100
Message-ID: <1975129.lAUTKuDbYb@bentobox>
In-Reply-To: <1385039865-7570-1-git-send-email-sw@simonwunderlich.de>
References: <1385039865-7570-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart53989086.rlnTqtoFIg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix debuginfo macro style
	issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <simon.wunderlich@open-mesh.com>

--nextPart53989086.rlnTqtoFIg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 November 2013 14:17:45 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Structure initialization within the macros should follow the general
> coding style used in the kernel: put the initialization of the first
> variable and the closing brace on a separate line.
> 
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---

It looks like this patch doesn't apply anymore. Can you please resent it or
mark it correctly in patchwork [1].

But for the cleanup:

Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks,
        Sven

[1] https://patchwork.open-mesh.org/patch/3668/

--nextPart53989086.rlnTqtoFIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4bXGAAoJEF2HCgfBJntGuCAP/RZrtWelYqGBRiS67+XyRH+f
+M+jXKkkuP+EEzHlhdMUHJhkamo+A0qndVka1LQKTQXXZCbU5B2a0l3JNhd8HQ0A
4rXtsqeO3ePqdUqFWhFBP3x3nwVcsL4U6UatJw2q6U3wU2pWfu7nrvXu2Un7XMag
OjBbXbYqr9jAjFgcXjxnmqhYjQJKj1dySZ3LT/LWoEMqLoMpUSr/8ZSsNYpKk0/F
Qt4/M6vm6Sn1e1hRXdbD3tRgsambxcoDivA+wp9xy8SYTo4Hv8pZaspkzyBwEHKK
seDwwEKsPm4I8ScPBKB5aokUFDV2qf7G+/7kYMFYNS4nDImI1sVPC0GSeUEFSEMi
ZbBUxjMoyYx5ems6NkuY2QUTUlq5bWuAhkmJ4EgdFnkmatzXd6BPth7GhywjlBIy
J+Bw9lthrQiuy50Rq6D8jUTB708wtsUVr/+gLaNfQURlF+NENHPMNTkImItwWb3V
px5eq4RcqLswOwOaM1C+Uw3nkc2yiVfaFgMfkKgh+UU/SwXOVcgkZrL9EgvgbWOP
h6Gpx/csiRZ/Pabe47ObGA98FRKW2IHO5gHeAbo+hOrDf3qUf+fydz5/uLAdd7T0
nAFdwN/JD3Eatxa0daBg43Uv96CJs2nCfJQyEjHuLtEZDhRUES8a77dSBsMnZh+g
U4auRe+5bVw1WZ+JK8tt
=cg+V
-----END PGP SIGNATURE-----

--nextPart53989086.rlnTqtoFIg--


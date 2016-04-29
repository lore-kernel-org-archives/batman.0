Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 23:07:37 +0200
Message-ID: <5873283.ggJnZknB2g@sven-edge>
In-Reply-To: <1461875848-11720-11-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-11-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1974902.MnFncqALXL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/10] batman-adv: add B.A.T.M.A.N. Dump
	BLA claims via netlink
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

--nextPart1974902.MnFncqALXL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:28 Andrew Lunn wrote:
> +       hlist_for_each_entry_rcu(claim, head, hash_entry) {
> +               if (idx++ < *idx_skip)
> +                       continue;
> +               if (batadv_bla_claim_dump_entry(msg, portid, seq,
> +                                               primary_if, claim))
> +                       *idx_skip = idx - 1;
> +                       goto unlock;
> +       }

This is buggy and will always jump to unlock after the first entry. Please 
enclose the "*idx_skip = idx - 1;" and "goto unlock;" with { ... }

Kind regards,
	Sven
--nextPart1974902.MnFncqALXL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI80ZAAoJEF2HCgfBJntGTacP/3UCYdp1CLii2kGvp3rrnZuU
mfND0kadXZal5hX/o7FRoAYfNfMoAcBr9+Qw3+zLXMgFPTEoGxuiC3+/gDcWCBwB
ptqWbzANhoASIU8fDXSKG9YqkiiH48UW/iYHYtDf7qQO5G8QpDyjXgm9ywH1Nvb+
2S68FiERCCUc4rUo3cRl6jb5emtZDFZYN4CQRZvqbnoCz5Nsa7xwjtbg3Gl7Esce
1du4pwJdyxeso6sp5JpqX9iqGo32ghPg6CP8Z05FfWnc2B4HXeXEqwssL0UniwWJ
YcBSYg5B2QuwPjW4w4jAxE6hoqO4SBNgXwxdiNrpFLlRkBvZUrqLHSnk7yawgI4a
ZQYhtSlPuARatafTfDCBbbKMDrPwaG/ih+XFVisPkgVLW11vliIaOwMoLssO3C0E
ljGSa4y3RrdEfC3ABxGXQOScE5cmxntSuBlcFOCgpGhqjuvJZvj5VwhhJDbcBnE2
8y5a9x3hfFctTmz2UqhhQuEeWPdfEHnJ0BfdGz2XTlkJlDyQBq5I50Opgy9mBT0K
KTezbkgoQpyjshiv4bysT8f4LWE8cHWTPcbVFF4wf9XAMJFsnnAuCqF6etXFFHr6
ZwdykREXMiUaj2u/sN8wdkFpmcBsVtgkvl/pWINF4nXDyhbg3dvXlHyj16c89GWD
NGnjC2z0tQzY3oV8PnL7
=Mmkv
-----END PGP SIGNATURE-----

--nextPart1974902.MnFncqALXL--


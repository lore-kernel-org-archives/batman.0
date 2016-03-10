Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 19:39:57 +0100
Message-ID: <10414369.gAzLYdsft7@bentobox>
In-Reply-To: <1388921809-4005-1-git-send-email-antonio@meshcoding.com>
References: <1388921809-4005-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2477452.4eYbXj11fN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use batadv_compare_eth when
	possible
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2477452.4eYbXj11fN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 05 January 2014 12:36:49 Antonio Quartulli wrote:
> When comparing Ethernet address it is better to use the more
> generic batadv_compare_eth. The latter is also optimised for
> architectures having a fast unaligned access.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---

It looks like this patch doesn't apply anymore. Can you please resent it or
mark it correctly in patchwork [1].

But for the cleanup:

Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks,
        Sven

[1] https://patchwork.open-mesh.org/patch/3769/

--nextPart2477452.4eYbXj11fN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4b99AAoJEF2HCgfBJntGB9YP/iwGX0GEHpWiPKOL6+3B2phz
05UD11F8gJPYl58Th5DVPht3/FuvcOcfKzRwkG0FoD1GLaVsVJSlzey4g4hJ4Tnq
CDT+bSZyZUEGgKaTB5D4OagI0NcKKci48eiPRiOLEOV6ai9146r+tc8zHNuy4gR4
qubhR4igIXDzyJRcitzPM7SgO7OO3TT/1lMAJwKc06ALgWbJRAtwLAmI/sAGvXDJ
eF6kAFUEyHjN3kOVxSZcoXjgmURGwr8AfMNwuFrj3F+iGB4TBeHKferzlQ6Qn36W
qlKQ2J4Ow0Skr3Iics+yeRKyHYpFwdEmGDZBTPys8RPNuCoqPaHcCAlUD9YWulUn
ElXQK86xAm99OjpuU6gSTmCJ8N8Z/PC9eynKpN+hPNPsD7pUpqNnS2ErzjWK7skV
Sn4l4m6+ZYNoQLhS05EpIjYPI5fKfGX60uJnAjoRClE/kvZwBmTlCbPgpI4zYdvn
ZVLFk80vlJoS5Dcqvc/cx9drxOpHZSdhXLAlmNE6h9VED/kX9QrGdibheXg93L0W
XJj4IU5VE4i8UtEzYJdR4tAoqlzGUC1f75deyCQl/ymYI/yA87Jf0B8NN66hUANc
phI5AmGX2zIcYNLLH6matk4nVKRcyst9c+luQIgHLYcN1yRzU5rapyrZpzSsPWNK
F1+whSAGm0rX2CbqF4DE
=995A
-----END PGP SIGNATURE-----

--nextPart2477452.4eYbXj11fN--


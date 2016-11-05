Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Nov 2016 09:32:32 +0100
Message-ID: <1697924.LOXfUT59a6@sven-edge>
In-Reply-To: <b861d75b-1ece-c8d6-a7cf-1b26b2c47bfb@t-online.de>
References: <b861d75b-1ece-c8d6-a7cf-1b26b2c47bfb@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7583789.uzNvsA1TdJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Alfred not working within network name space
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jean-Jacques Sarton <jj.sarton@t-online.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart7583789.uzNvsA1TdJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 1. November 2016 20:07:24 CET Jean-Jacques Sarton wrote:
> This patch shall allow to use the debugfs as previouly, including
> the check for valify of the interface used.
> For netns the check seem to be implemented within the function
> netlink_query_common().
> For netlink we check if the originators ans transtable_global
> informations are accessible through netlink.
> 
> To: b.a.t.m.a.n@lists.open-mesh.org
> 
> Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
> ---
>  batadv_query.c | 14 +++++++++++++-
>  netlink.c      | 27 +++++++++++++++++++++++++++
>  netlink.h      |  1 +
>  3 files changed, 41 insertions(+), 1 deletion(-)

@Jean-Jacques: What is the status?

Kind regards,
	Sven

--nextPart7583789.uzNvsA1TdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHZkgAAoJEF2HCgfBJntGR1AQAMsKRG+34EgBk2Iqa5K+oFE6
P6OpdQWpuUus6ppMi2n5WzWXV1API9Y1FA0hV8hiA18aBAj7C2Oqx1baGcTuTdko
KA2volPozU11KiSMyiGvXs+QQR2a1Wj+sm+vP8pUm80X1aiOrQl8CPXD6BImZFnu
vgsI0uU7RHAkc8ZiwfkSBPfEW7u9yAGezgQs3AHL/qGJNiHp5nKquUR28SVul6OK
ESKaamGOC6uSAtd0PH9Y6YtJiLVHReGbP6OU6Nd5IUDZg6yQnJtQmZfAeFcJpo0m
4rYtbMT76jTGgO9Z13bspo4Tgq4q9LlIXECEsn3TIF/cfGpzZgl802tjNb+Dhqip
6TAFsohwrsMEuEeRUbm9A3IHoE8LGY08UA2VMg2Y0/WICZ9uaBw8NmNQMWMTbOy+
QPdnrZG6V0x+luWmY7Y2eKT+EYPRJ5DH0NNE6fZ8CDuUQuwA88/wedbQFVRZoCIW
VM+SFEaO/LhL31+CxI4IXQjEEAcW7LAkcW22ASca5ObatNAmrs7uy++490QsObcs
qEskKxc84qR44N2PCndKigrLGO7fBDlROLwClFQg0z/Anj/ToahrFY8HIKjOKJO0
oDGs8lGh3/DynxCKT+Urdr/lR6hthxI6K8qVkg1Nr86h7lI5isNTogZfMqsebLE6
Sc66Iur04saQ6v3w0ctN
=NICZ
-----END PGP SIGNATURE-----

--nextPart7583789.uzNvsA1TdJ--


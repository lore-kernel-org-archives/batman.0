Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Nov 2013 11:34 +0800
Message-ID: <7989682.kegn5kvAK7@diderot>
In-Reply-To: <1384599832-3959-5-git-send-email-antonio@meshcoding.com>
References: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
 <1384599832-3959-5-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1472723.ZtpRVWVzNq";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 4/6] batman-adv: extend the
	ap_isolation mechanism
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1472723.ZtpRVWVzNq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 November 2013 12:03:50 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Change the AP isolation mechanism to not only "isolate" WIFI
> clients but also all those marked with the more generic
> "isolation flag" (BATADV_TT_CLIENT_ISOLA).
> 
> The result is that when AP isolation is on any unicast
> packet originated by an "isolated" client and directed to
> another "isolated" client is dropped at the source node.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  translation-table.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied in revision ae95c4e.

Thanks,
Marek

--nextPart1472723.ZtpRVWVzNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSiDkoAAoJEFNVTo/uthzAelQH/3kVSroiScLs51DEceX+5h8A
NlcXEXeh0nhOulMESo7akglmQlwacRAY9g+q0hMsPKP7UlyVe6osBwzQycff1sHI
Tz7FvZ4sPNOHIyA2pcLo/zVMHxTgju469kFE12HHwP7HQqWaXX79LIRFYSqlXEyU
bNkiai8oxFBvvH13YYuGmj57xLUrjKoZCVlp1bZBopLHUf9APdtan9oKM12wBMVQ
kQb6Q9z1RRpidwU3T8pipt4GqWPoB+vI/G0KdA1Swgc4UB/f8AIwkoIkBX+s5ctG
rZNOHqDipM/fMx/72LWmoxpLWQWfl3+lJIIbwj4R3+2GkMughBB8VgOthuuyEEA=
=iVkD
-----END PGP SIGNATURE-----

--nextPart1472723.ZtpRVWVzNq--


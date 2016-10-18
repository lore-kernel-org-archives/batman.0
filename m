Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:46:41 +0200
Message-ID: <1527828.SI8UVEeSSk@bentobox>
In-Reply-To: <1469615468-9261-2-git-send-email-sven@narfation.org>
References: <1469615468-9261-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2629962.XaBcu0d23V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [2/2] batman-adv: Use proper name for gateway
	list head
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

--nextPart2629962.XaBcu0d23V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 27. Juli 2016 12:31:08 CEST Sven Eckelmann wrote:
> The batman-adv codebase is using "list" for the list node (prev/next) and
> <list content descriptor>+"_list" for the head of a list. Not using this
> naming scheme can up in confusions when reading the code.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c     | 6 +++---
>  net/batman-adv/bat_v.c          | 6 +++---
>  net/batman-adv/gateway_client.c | 7 ++++---
>  net/batman-adv/main.c           | 2 +-
>  net/batman-adv/types.h          | 8 ++++----
>  5 files changed, 15 insertions(+), 14 deletions(-)

Applied in 21643310f1918758d22367ff5c81d34a49c3645d [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/21643310f1918758d22367ff5c81d34a49c3645d

--nextPart2629962.XaBcu0d23V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhmxAAoJEF2HCgfBJntGqqcQAJe9SHs3uA7HLcuYi85T+9IS
0D7+eWxyIvWRNCtExpG2N4W4ouUZtVvSEt1DXi0RyayNhHXecTWqhmxoaXh55Hih
nNkCdGpX02+oEUyqta0x96HPHWnzbmmcoezxipaZU5FrGpvvWsLkdIzcHM5V9+V2
6g9VvdTFxyLORamjpCdnTi8sohZGKGCCsVQga0Xwf0ec44L4iekBdrET/mASh+WT
s8U0qQBLjy9EhVAJ6oiRdTW9SW2v6P+Nv7HbKyR0rVF5AcI3fs2U4qB6P9WNDbC3
4pwsrJrmtbkmQ2bjVpMQyunOr0V8Py6C4ijN6GJi7EEIoq5k0U0RRpLI7KAyBSLa
hbCgy/+zvMOV/KWalIk942OP/nCwqCB878Bu7jBm+gOaEefhdCMQtamOm0JuoXLo
UXwfIToafugp/t0l7FJr4cSkcWA5/DAmEoSzVO/HUm/Yq8n/j71Hv6MxReN9Tmx/
kgIRUkj5U60tqgdwzrhtxtLL28v5YHwBGBs5x+ZIpyNPv//qd9qcql21GuyEU/61
I0eosX/FJI5jOf+1oo5V7bTkIHemofPUedfhXN5Hz02upDy3jiK4Afc6nCT3qeYS
m/DzO7F0eCHxbnDNsx4AnbKRMuQYmNK/yTZ3fhBcMXMRzStWLBQ4THMXce4fN4W5
TROJbx9IcQAsYOG9Vh44
=K5aP
-----END PGP SIGNATURE-----

--nextPart2629962.XaBcu0d23V--


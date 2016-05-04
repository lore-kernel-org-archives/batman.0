Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 04 May 2016 23:20:37 +0800
Message-ID: <8527725.33hqUeU5d6@voltaire>
In-Reply-To: <1462211134-8169-1-git-send-email-a@unstable.cc>
References: <1462211134-8169-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4595466.mJB9fLThfJ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove ogm_emit and
	ogm_schedule API calls
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

--nextPart4595466.mJB9fLThfJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 03, 2016 01:45:34 Antonio Quartulli wrote:
> The ogm_emit and ogm_schedule API calls were rather tight to the
> B.A.T.M.A.N. IV logic and therefore rather difficult to use
> with other algorithm implementations.
> 
> Remove such calls and move the surrounding logic into the
> B.A.T.M.A.N. IV specific code.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
> 
> Changes from RFC:
> - batadv_send_outstanding_bat_ogm_packet() renamed to
>   batadv_iv_send_outstanding_bat_ogm_packet()
> - batadv_iv_iface_enable() moved back to its original location (was moved by
> accident)
> - code has been tested in qemu with one node
> 
> 
>  net/batman-adv/bat_iv_ogm.c     | 68
> ++++++++++++++++++++++++++++++++++++++--- net/batman-adv/bat_v.c          |
> 10 ------
>  net/batman-adv/hard-interface.c |  3 --
>  net/batman-adv/main.c           |  2 --
>  net/batman-adv/send.c           | 61 +-----------------------------------
>  net/batman-adv/send.h           |  3 +-
>  net/batman-adv/types.h          |  4 ---
>  7 files changed, 66 insertions(+), 85 deletions(-)

Applied in revision 0d84685.

Thanks,
Marek

--nextPart4595466.mJB9fLThfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXKhNFAAoJEFNVTo/uthzADToIALKnFeU2YAihXGxhO82Mid7u
bJcC7OBIKRfRIfAAt7E24mzwyJJ//IYJwtt3a7XgH74TuBB92bKPo+SUgu8mbgy0
EyNxoaukVklly7LZXuq4hHWLGu7URDlIIB77ITMTozMX4puL/fPRJIkvuXt2pve/
H5dDgOZMW9zSbOwvwSyjFGJ/10A0eZpNeZYisc8Y2TwzGQaqGxdeCemJwRU3GI5y
wNCZScLEi5b7S+SKjLcZ+Aioa+c7z+d9NuGxg4DxKJxtTs50xI18FntQh72xJrnR
uTscJqq2KydqiDAcTTLOw4Cfd5L0955ncIzzrel1DDjs3Pv3IudY4DJ3BWXh/k0=
=BeyW
-----END PGP SIGNATURE-----

--nextPart4595466.mJB9fLThfJ--


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 09:06:06 +0800
Message-ID: <4949775.TBFu6vBemq@voltaire>
In-Reply-To: <1462474003-25279-2-git-send-email-a@unstable.cc>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <1462474003-25279-2-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2195420.d9pFxRnUW1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: move GW mode and
	selection class to private data structure
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

--nextPart2195420.d9pFxRnUW1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 06, 2016 02:46:38 Antonio Quartulli wrote:
> To reduce the field pollution in our main batadv_priv data structure
> we've already created some substructures so that we could group fields
> in a convenient manner.
> 
> However gw_mode and gw_sel_class are still part of the main object.
> 
> More both fields to the GW private substructure.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/gateway_client.c | 12 ++++++------
>  net/batman-adv/gateway_common.c |  6 +++---
>  net/batman-adv/soft-interface.c |  6 +++---
>  net/batman-adv/sysfs.c          | 10 +++++-----
>  net/batman-adv/types.h          |  8 ++++----
>  5 files changed, 21 insertions(+), 21 deletions(-)

Applied in revision 6435277.

Thanks,
Marek

--nextPart2195420.d9pFxRnUW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK+3+AAoJEFNVTo/uthzADpcIAKWgOzGTqbD/bRomvByxVEBu
KkxKcrQrzyH1wU3vNZTs8KYZkGeEANO10aG3CFkqD7eUkazLXtthtDvkJuEHhHw2
HpTq9UbLM+QaXMO+uWi+aLgO79tZlQfHifDjkB43m/Rs433BrW2SjukUn/ANe0pu
WzGC2ro6P0/PnrWeS0TxvB4/+6PmxOljH5pTcyBbP3SXYOVOjYCnfCOJdUL0MzFa
sX7+bVVsEkl3IEe2WZ44wd/4AepEcim4h4zi/vdkP63ko7G7vszwDRIhENW2qmVf
LgWdpkl/JUZgI6htBXu7BaVtedem/1OaNk4cfKAYTZwMZUU8B4CkFFF9DOxiSl8=
=Enic
-----END PGP SIGNATURE-----

--nextPart2195420.d9pFxRnUW1--


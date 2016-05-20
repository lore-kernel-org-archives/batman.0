Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 17:08:24 +0800
Message-ID: <2891254.x3iL9Ftxqu@voltaire>
In-Reply-To: <1463303266-25979-4-git-send-email-sven@narfation.org>
References: <1463303266-25979-1-git-send-email-sven@narfation.org>
 <1463303266-25979-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4671463.rXXrBmX72X";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 4/6] batman-adv: move bat_algo
	functions into a separate file
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

--nextPart4671463.rXXrBmX72X
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 15, 2016 11:07:44 Sven Eckelmann wrote:
> The bat_algo functionality in main.c is mostly unrelated to the rest of the
> content. It still takes up a large portion of this source file (~15%, 103
> lines). Moving it to a separate file makes it better visible as a main
> component of the batman-adv implementation and hides it less in the other
> helper functions in main.c.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - introduce this patch
> ---
>  net/batman-adv/Makefile            |   1 +
>  net/batman-adv/bat_algo.c          | 140
> +++++++++++++++++++++++++++++++++++++
> net/batman-adv/bat_algo.h          |  12 ++++
>  net/batman-adv/bat_v_ogm.c         |   1 +
>  net/batman-adv/debugfs.c           |   1 +
>  net/batman-adv/main.c              | 105 +---------------------------
>  net/batman-adv/main.h              |   4 --
>  net/batman-adv/originator.c        |   1 +
>  net/batman-adv/routing.c           |   1 +
>  net/batman-adv/soft-interface.c    |   1 +
>  net/batman-adv/translation-table.c |   1 +
>  11 files changed, 160 insertions(+), 108 deletions(-)
>  create mode 100644 net/batman-adv/bat_algo.c

Applied in revision c14a11a.

Thanks,
Marek

--nextPart4671463.rXXrBmX72X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPtQIAAoJEFNVTo/uthzA418IAMVetNpI5QN1VrfCLvc9lfb0
dgqFynYga6mEvlv4M8XNCy0VrbThKrAo2alpfU6kISk2Yo3fJTb3g7YbcjVGxdZf
q2yejsW0u2QecSpUuWlbkD/hF6UnTThbKbBC8eKzsp/V0BvNEQ0jJeTt8DWxjdE2
ZHd7AeWDoxvTLJpUirL60HfoJyXC5m6QNtIFBdP3VL8AB7WEw4xorfbMGzJH1Uvs
u3tj7HTr6ogXgRnJxdEvxTpaznyX3zesotvumFu1O6UFr8+8aGtMed0OsOzGVFII
K6QnHDESh5xSuCLENUQI+cQ23Fqox1tkfeD4eoGubgl/KbicwSiQJCbBvg4cFWg=
=tjYD
-----END PGP SIGNATURE-----

--nextPart4671463.rXXrBmX72X--


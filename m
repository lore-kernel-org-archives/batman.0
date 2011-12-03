Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Dec 2011 15:27:50 +0800
References: <1322835344-23077-1-git-send-email-martin@hundeboll.net>
	<1322836747-25204-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1322836747-25204-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201112031527.51151.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Rm trailing whitespace from
	is_my_mac() in main.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Friday, December 02, 2011 22:39:07 Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  main.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/main.c b/main.c
> index fb87bdc..71b56cf 100644
> --- a/main.c
> +++ b/main.c
> @@ -170,7 +170,6 @@ int is_my_mac(const uint8_t *addr)
>  	}
>  	rcu_read_unlock();
>  	return 0;
> -
>  }
>=20
>  module_init(batman_init);

I don't have a trailing whitespace space there and you are removing an enti=
re=20
(empty) line. Not just a whitespace ?
My checkpatch also does not complain about your first patch. Where did you =
get=20
your checkpatch from ?

Regards,
Marek

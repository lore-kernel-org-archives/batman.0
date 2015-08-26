Return-Path: <martin@hundeboll.net>
Message-ID: <55DE0498.3010806@hundeboll.net>
Date: Wed, 26 Aug 2015 20:25:28 +0200
From: =?windows-1252?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1440577911-16107-1-git-send-email-sven@narfation.org>
In-Reply-To: <1440577911-16107-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Use chain pointer when
 purging fragments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 2015-08-26 10:31, Sven Eckelmann wrote:
> The chain pointer was already created in batadv_frag_purge_orig to make t=
he
> checks more readable. Just use the chain pointer everywhere instead of
> having the same dereference + array access in the most lines of this
> function.
>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>

> ---
>   net/batman-adv/fragmentation.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentatio=
n.c
> index 700c96c82a15..20d9282f895b 100644
> --- a/net/batman-adv/fragmentation.c
> +++ b/net/batman-adv/fragmentation.c
> @@ -71,14 +71,14 @@ void batadv_frag_purge_orig(struct batadv_orig_node *=
orig_node,
>
>   	for (i =3D 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
>   		chain =3D &orig_node->fragments[i];
> -		spin_lock_bh(&orig_node->fragments[i].lock);
> +		spin_lock_bh(&chain->lock);
>
>   		if (!check_cb || check_cb(chain)) {
> -			batadv_frag_clear_chain(&orig_node->fragments[i].head);
> -			orig_node->fragments[i].size =3D 0;
> +			batadv_frag_clear_chain(&chain->head);
> +			chain->size =3D 0;
>   		}
>
> -		spin_unlock_bh(&orig_node->fragments[i].lock);
> +		spin_unlock_bh(&chain->lock);
>   	}
>   }
>
>

--=20
Kind Regards,
Martin Hundeb=F8ll
Frederiks All=E9 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net

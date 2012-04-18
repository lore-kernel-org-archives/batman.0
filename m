Return-Path: <martin@hundeboll.net>
Message-ID: <4F8E777A.5010901@hundeboll.net>
Date: Wed, 18 Apr 2012 10:12:42 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
	<1334701645-25862-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1334701645-25862-2-git-send-email-ordex@autistici.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: don't delay OGM
 information announcement
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

Hi Antonio,

One minor/trivial change below.

On 04/18/2012 12:27 AM, Antonio Quartulli wrote:
> In the current implementation the OGM is built and filled at the moment it is
> scheduled (1 originator interval before its sending). In this way, all the TT
> changes happening between OGM(seqno=X) and OGM(seqno=X+1) will be attached to
> OGM(seqno=X+2) (because when changes happened OGM(seqno=X+1) was already built).
>
> The result of this strategy is that TT changes are not sent within the
> very next OGM, but they are sent within the second OGM since they happened.
> This mechanism will introduce a delay for table resync which could lead to
> wrong state in case of multiple roamings.
>
> This patch delays all the operations so that the OGM is filled and ultimated
> just before being sent.
>
> Signed-off-by: Antonio Quartulli<ordex@autistici.org>
> ---
>   bat_iv_ogm.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>   send.c       |   75 ++--------------------------------------
>   types.h      |    6 ++--
>   3 files changed, 99 insertions(+), 90 deletions(-)
>
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index ed743a4..377ee04 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -558,28 +558,97 @@ static void bat_iv_ogm_forward(struct orig_node *orig_node,
>   			     if_incoming, 0, bat_iv_ogm_fwd_send_time());
>   }
>
> -static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
> -				int tt_num_changes)
> +static void realloc_packet_buffer(struct hard_iface *hard_iface,
> +				  int new_len)
>   {
> -	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
> +	unsigned char *new_buff;
> +
> +	new_buff = kmalloc(new_len, GFP_ATOMIC);
> +
> +	/* keep old buffer if kmalloc should fail */
> +	if (new_buff) {
> +		memcpy(new_buff, hard_iface->packet_buff,
> +		       BATMAN_OGM_HLEN);
> +
> +		kfree(hard_iface->packet_buff);
> +		hard_iface->packet_buff = new_buff;
> +		hard_iface->packet_len = new_len;
> +	}
> +}
> +
> +/* when calling this function (hard_iface == primary_if) has to be true */
> +static int prepare_packet_buffer(struct bat_priv *bat_priv,
> +				  struct hard_iface *hard_iface)
> +{
> +	int new_len;
> +
> +	new_len = BATMAN_OGM_HLEN +
> +		  tt_len((uint8_t)atomic_read(&bat_priv->tt_local_changes));
> +
> +	/* if we have too many changes for one packet don't send any
> +	 * and wait for the tt table request which will be fragmented */

Better change that comment te end with */ on a newline, before sending to David :)

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net

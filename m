Return-Path: <martin@hundeboll.net>
Message-ID: <4F8E7ED1.2000904@hundeboll.net>
Date: Wed, 18 Apr 2012 10:44:01 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
	<1334701645-25862-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1334701645-25862-4-git-send-email-ordex@autistici.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: let
 tt_global_entry_has_orig() return the orig_entry or NULL instead of 1 or 0
 only
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

On 04/18/2012 12:27 AM, Antonio Quartulli wrote:
> Instead of returning only 1 or 0 this function has to return the found
> orig_entry (if any). In this way, operations that have to to modify the
> found orig_entry structure will not need to reiterate over the list again to
> find the wanted node.
>
> Signed-off-by: Antonio Quartulli<ordex@autistici.org>
> ---
>   translation-table.c |   16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/translation-table.c b/translation-table.c
> index e02fa90..cd6c2dd 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -543,26 +543,26 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
>   }
>
>   /* find out if an orig_node is already in the list of a tt_global_entry.
> - * returns 1 if found, 0 otherwise
> - */
> -static bool tt_global_entry_has_orig(const struct tt_global_entry *entry,
> -				     const struct orig_node *orig_node)
> + * returns NULL if not found, the pointer to the orig_entry otherwise */
> +static struct tt_orig_list_entry *tt_global_entry_has_orig(
> +					const struct tt_global_entry *entry,
> +					const struct orig_node *orig_node)
>   {
>   	struct tt_orig_list_entry *tmp_orig_entry;
>   	const struct hlist_head *head;
>   	struct hlist_node *node;
> -	bool found = false;
> +	struct tt_orig_list_entry *orig_entry = NULL;
>
>   	rcu_read_lock();
>   	head =&entry->orig_list;
>   	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
>   		if (tmp_orig_entry->orig_node == orig_node) {
> -			found = true;
> +			orig_entry = tmp_orig_entry;
>   			break;
>   		}
>   	}
>   	rcu_read_unlock();
> -	return found;
> +	return orig_entry;
>   }
>
>   static void tt_global_add_orig_entry(struct tt_global_entry *tt_global_entry,
> @@ -1262,7 +1262,7 @@ static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
>   	tt_global_entry = container_of(tt_common_entry, struct tt_global_entry,
>   				       common);
>
> -	return tt_global_entry_has_orig(tt_global_entry, orig_node);
> +	return (size_t)tt_global_entry_has_orig(tt_global_entry, orig_node);
>   }
>
>   static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,

Again, I notice the lack of reference counting, but I guess you already are aware of that, and have it on your never ending todo-list :)

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net

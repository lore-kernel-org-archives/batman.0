Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 00:55:40 +0800
References: <1366136165-5839-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366136165-5839-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304180055.41009.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use CRC32C instead of CRC16
	in TT code
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, April 17, 2013 02:16:05 Antonio Quartulli wrote:
> @@ -1376,13 +1376,11 @@ out:
>  static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
>                                      struct batadv_orig_node *orig_node)
>  {
> -       uint16_t total = 0, total_one;
>         struct batadv_hashtable *hash = bat_priv->tt.global_hash;
>         struct batadv_tt_common_entry *tt_common;
>         struct batadv_tt_global_entry *tt_global;
>         struct hlist_head *head;
> -       uint32_t i;
> -       int j;
> +       uint32_t i, crc = 0;
>  
>         for (i = 0; i < hash->size; i++) {
>                 head = &hash->table[i];

How about making the function to "static uint32_t" ?


>  /* Calculates the checksum of the local table */
>  static uint16_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
>  {
> -       uint16_t total = 0, total_one;
>         struct batadv_hashtable *hash = bat_priv->tt.local_hash;
>         struct batadv_tt_common_entry *tt_common;
>         struct hlist_head *head;
> -       uint32_t i;
> -       int j;
> +       uint32_t i, crc = 0;
>  
>         for (i = 0; i < hash->size; i++) {
>                 head = &hash->table[i];

Same here.


> @@ -1642,7 +1631,7 @@ out:
>  
>  static int batadv_send_tt_request(struct batadv_priv *bat_priv,
>                                   struct batadv_orig_node *dst_orig_node,
> -                                 uint8_t ttvn, uint16_t tt_crc,
> +                                 uint8_t ttvn, uint32_t tt_crc,
>                                   bool full_table)
>  {

Kernel doc ?  :)

Cheers,
Marek

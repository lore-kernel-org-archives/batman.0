Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 1 Nov 2011 11:47:12 +0100
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1320015072-10313-8-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320015072-10313-8-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111011147.12470.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 07/11] batman-adv: add broadcast duplicate
	check
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

On Sunday, October 30, 2011 23:51:08 Simon Wunderlich wrote:
> +struct bcast_duplist_entry {
> +       uint8_t orig[ETH_ALEN];
> +       uint16_t crc;
> +       unsigned long entrytime;
> +};
>  
>  struct bat_priv {
>         atomic_t mesh_state;
> @@ -185,6 +190,8 @@ struct bat_priv {
>         struct list_head tt_req_list; /* list of pending tt_requests */
>         struct list_head tt_roam_list;
>         struct hashtable_t *vis_hash;
> +       struct bcast_duplist_entry bcast_duplist[DUPLIST_SIZE];

These are 200 bytes you are adding here. Any specific reason not to allocate 
it?

Regards,
Marek

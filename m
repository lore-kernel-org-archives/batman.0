Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 10:34:55 +0200
Message-ID: <2761811.k3orNp26PZ@bentobox>
In-Reply-To: <1427037821-11565-1-git-send-email-sven@narfation.org>
References: <1427037821-11565-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove dynamically
	allocated hashtables
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Sunday 22 March 2015 16:23:40 Sven Eckelmann wrote:
> @@ -628,12 +638,13 @@ struct batadv_priv_tvlv {
>   * struct batadv_priv_dat - per mesh interface DAT private data
>   * @addr: node DAT address
>   * @hash: hashtable representing the local ARP cache
> + * @hash_lock: locks for each hashtable buckets
>   * @work: work queue callback item for cache purging
>   */
>  #ifdef CONFIG_BATMAN_ADV_DAT
>  struct batadv_priv_dat {
>  	batadv_dat_addr_t addr;
> -	struct batadv_hashtable *hash;
> +	struct batadv_hashbucket hash[1024];
>  	struct delayed_work work;
>  };
>  #endif

There is no hash_lock and thus this hash_lock comment should not be added.

Kind regards,
	Sven

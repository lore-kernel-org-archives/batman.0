Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Nov 2012 02:58:54 +0800
References: <1351982508-16991-1-git-send-email-sven@narfation.org>
In-Reply-To: <1351982508-16991-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211060258.54459.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Reorder structs to reduce
	padding
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

On Sunday, November 04, 2012 06:41:48 Sven Eckelmann wrote:
> -       struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
>  #ifdef CONFIG_BATMAN_ADV_DAT
>         batadv_dat_addr_t dat_addr;
>  #endif
> +       uint8_t flags;
> +       uint8_t gw_flags;
> +       struct batadv_neigh_node __rcu *router; /* rcu protected pointer */

Shouldn't we move batadv_dat_addr_t to the end of the struct to achieve the 
smallest possible struct regardless of whether DAT is compiled in or not ? Or 
does it have no effect ?

Cheers,
Marek

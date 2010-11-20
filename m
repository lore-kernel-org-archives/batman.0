Return-Path: <linus.luessing@web.de>
Date: Sat, 20 Nov 2010 19:27:01 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101120182701.GA16511@Sellars>
References: <201011170226.09739.lindner_marek@yahoo.de>
	<1289957194-5455-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1289957194-5455-1-git-send-email-lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: protect neighbor nodes
 with reference counters
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

Hi Marek,

> @@ -108,7 +110,12 @@ static void update_route(struct bat_priv *bat_priv,
>  			orig_node->router->addr);
>  	}
>  
> +	neigh_node_tmp = orig_node->router;
>  	orig_node->router = neigh_node;
> +	if (orig_node->router)
> +		kref_get(&orig_node->router->refcount);
> +	if (neigh_node_tmp)
> +		kref_put(&neigh_node->refcount, neigh_node_free_ref);
>  }
I guess you meant "kref_put(&neigh_node_tmp,... instead of
neigh_node (without tmp) here, as neigh_node_tmp won't be used anymore, not neigh_node,
right? Otherwise it also does not seem to make sense to first increase the refcount and
then decreasing it right again after the additional check.

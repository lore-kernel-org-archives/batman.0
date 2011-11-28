Return-Path: <andrew@lunn.ch>
Date: Mon, 28 Nov 2011 20:00:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111128190031.GD13600@lunn.ch>
References: <201111290028.01655.lindner_marek@yahoo.de>
	<1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: add infrastructure to
 change routing algorithm at runtime
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Hi Marek

> +static struct bat_algo *bat_algo_get(char *name)
> +{
> +	struct bat_algo *bat_algo = NULL, *bat_algo_tmp;
> +	struct hlist_node *node;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(bat_algo_tmp, node, &bat_algo_list, list) {
> +		if (strcmp(bat_algo_tmp->name, name) != 0)
> +			continue;
> +
> +		bat_algo = bat_algo_tmp;

You should have a try_module_get() here, to stop the module
implementing the algorithm from being unloaded.

	Andrew

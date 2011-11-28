Return-Path: <andrew@lunn.ch>
Date: Mon, 28 Nov 2011 20:02:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111128190245.GE13600@lunn.ch>
References: <201111290028.01655.lindner_marek@yahoo.de>
	<1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
	<1322497717-21268-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322497717-21268-2-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: convert batman iv
 algorithm to use dynamic infrastructure
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

> +static struct bat_algo bat_algo_iv __read_mostly = {
>  	.name = "BATMAN IV",
> +	.bat_ogm_init = bat_ogm_init,
> +	.bat_ogm_init_primary = bat_ogm_init_primary,
> +	.bat_ogm_update_mac = bat_ogm_update_mac,
> +	.bat_ogm_schedule = bat_ogm_schedule,
> +	.bat_ogm_emit = bat_ogm_emit,
> +	.bat_ogm_receive = bat_ogm_receive,
>  };

This needs an .owner = THIS_MODULE,

so you can do reference counting on the module.

   Andrew

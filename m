Return-Path: <davem@davemloft.net>
Date: Wed, 09 May 2012 20:42:11 -0400 (EDT)
Message-Id: <20120509.204211.1682541114536655093.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1336561976-16088-10-git-send-email-ordex@autistici.org>
References: <1336561976-16088-1-git-send-email-ordex@autistici.org>
	<1336561976-16088-10-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 09/14] batman-adv: refactoring API: find
 generalized name for bat_ogm_update_mac callback
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  9 May 2012 13:12:51 +0200

> +	/* (re-)init mac addresses of the protocol information
> +	 * belonging to this hard-interface */

Needs to be:

	/* (re-)init mac addresses of the protocol information
	 * belonging to this hard-interface
	 */

Return-Path: <joe@perches.com>
Message-ID: <1387789163.22671.62.camel@joe-AO722>
From: Joe Perches <joe@perches.com>
Date: Mon, 23 Dec 2013 00:59:23 -0800
In-Reply-To: <52B7F853.8050806@meshcoding.com>
References: <52B7C5C5.2050304@huawei.com> <52B7F853.8050806@meshcoding.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 09/21] batman-adv: slight optimization of
	addr compare
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Netdev <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ding Tianhong <dingtianhong@huawei.com>, "David S. Miller" <davem@davemloft.net>

On Mon, 2013-12-23 at 09:46 +0100, Antonio Quartulli wrote:
> On 23/12/13 06:10, Ding Tianhong wrote:
> 
> [...]
> 
> > --- a/net/batman-adv/originator.c
> > +++ b/net/batman-adv/originator.c
> > @@ -41,7 +41,7 @@ int batadv_compare_orig(const struct hlist_node *node, const void *data2)
> >  	const void *data1 = container_of(node, struct batadv_orig_node,
> >  					 hash_entry);
> >  
> > -	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
> > +	return ether_addr_equal_unaligned(data1, data2) ? 1 : 0;
> 
> ether_addr_equal_unaligned() returns a bool value which is implicitly
> converted to 1 or 0: there is no need for the ternary if anymore.

Should these use batadv_compare_eth?



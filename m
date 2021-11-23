Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 23 Nov 2021 13:33:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.4 0/3] batman-adv: Fixes for stable/linux-4.19.y
Message-ID: <YZzfgzhgkOM4Yypx@kroah.com>
References: <20211120124053.261156-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120124053.261156-1-sven@narfation.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: stable@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On Sat, Nov 20, 2021 at 01:40:50PM +0100, Sven Eckelmann wrote:
> Hi,
> 
> I went through  all changes in batman-adv since v4.19 with a Fixes: line
> and checked whether they were backported to the LTS kernels. The ones which
> weren't ported and applied to this branch are now part of this patch series.
> 
> For this kernel version, I only found following three patches:
> 
> * batman-adv: Consider fragmentation for needed_headroom
> * batman-adv: Reserve needed_*room for fragments
> * batman-adv: Don't always reallocate the fragmentation skb head
> 
> which could in some circumstances cause packet loss but which were created
> to fix high CPU load/low throughput problems. But I've added them here
> anyway because the corresponding VXLAN patches were also added to stable.
> And some stable kernels also got these fixes a while back.
> 
> Kind regards,
> 	Sven
> 
> Sven Eckelmann (3):
>   batman-adv: Consider fragmentation for needed_headroom
>   batman-adv: Reserve needed_*room for fragments
>   batman-adv: Don't always reallocate the fragmentation skb head

Now queued up, thanks.

greg k-h

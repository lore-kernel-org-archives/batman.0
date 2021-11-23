Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 23 Nov 2021 13:41:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/11] batman-adv: Fixes for stable/linux-4.4.y
Message-ID: <YZzhdAFXzHaNt5eQ@kroah.com>
References: <20211120123939.260723-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120123939.260723-1-sven@narfation.org>
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

On Sat, Nov 20, 2021 at 01:39:28PM +0100, Sven Eckelmann wrote:
> Hi,
> 
> I went through  all changes in batman-adv since v4.4 with a Fixes: line
> and checked whether they were backported to the LTS kernels. The ones which
> weren't ported and applied to this branch are now part of this patch series.
> 
> There are also following three patches included:
> 
> * batman-adv: Consider fragmentation for needed_headroom
> * batman-adv: Reserve needed_*room for fragments
> * batman-adv: Don't always reallocate the fragmentation skb head
> 
> which could in some circumstances cause packet loss but which were created
> to fix high CPU load/low throughput problems. But I've added them here
> anyway because the corresponding VXLAN patches were also added to stable.
> And some stable kernels also got these fixes a while back.

All patches and series now queued up, thanks!

greg k-h

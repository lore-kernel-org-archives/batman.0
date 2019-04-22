Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 22 Apr 2019 11:20:48 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190422092048.GG6201@otheros>
References: <20190422081214.8481-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422081214.8481-1-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Drop log subcommand
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

On Mon, Apr 22, 2019 at 10:12:14AM +0200, Sven Eckelmann wrote:
> The correct way to get a log of the activities of batman-adv is to use the
> standard kernel tracing infrastructure:
> 
>   $ trace-cmd stream -e batadv:batadv_dbg
> 
> The batman-adv specific log file will be removed in the future when the
> debugfs is dropped. And even for kernels without tracing support, most of
> the functionality (except mac address to bat_hosts translation) can be
> replaced by a simple:
> 
>   $ cat /sys/kernel/debug/batman_adv/bat0/log
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

The trace-cmd approach does not add/provide network namespace
support, does it?

If we were removing "batctl log" now we would probably need to readd it
later again when adding network namespace support, both for
either a netlink or IPv6 node-local multicast approach, right [0]?

(Although for the IPv6 node-local multicast 'socat' for instance would
work, too.)


[0]: 'Make "batctl log" usable with network namespaces'
     https://www.open-mesh.org/issues/339

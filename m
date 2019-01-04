Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 4 Jan 2019 03:29:16 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190104022916.GI21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-20-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207135846.6152-20-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 19/19] batman-adv: Trigger genl
 notification on sysfs config change
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

On Fri, Dec 07, 2018 at 02:58:46PM +0100, Sven Eckelmann wrote:
> The generic netlink code is expected to trigger notification messages when
> configuration might have been changed. But the configuration of batman-adv
> is most of the time still done using sysfs. So the sysfs interface should
> also trigger the corresponding netlink messages via the "config" multicast
> group.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

I'm wondering, before it was quite easy to add new sysfs
attributes with just a few lines thanks to macros. Now we
need to add code in four more places in netlink.c whenever we introduce a
new configuration option.

Would it be possible (and maybe even reduce code size?) if the
sysfs and netlink parts were wrapped into some (macro) functions and/or
structs, to still be able to add options from a central place and with
only a few lines?

Or would that become too ugly? Or not worth the effort for the few
options we have right now?

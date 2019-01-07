Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 7 Jan 2019 19:57:13 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190107185712.GD5399@otheros>
References: <20181207203209.22633-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207203209.22633-1-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/20] batctl: netlink restructuring,
 part 3
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

On Fri, Dec 07, 2018 at 09:31:49PM +0100, Sven Eckelmann wrote:
> As mentioned earlier, the netlink config restructuring in batctl will be
> splitted in multiple steps. The first step was already merged and the
> RFC changes for the netlink interface in batman-adv were just posted.
> 
> The batman-adv weren't directly rejected by Jiro and thus I've started
> to convert all settings to netlink while still allowing sysfs as fallback.
> 

Is "batctl if" supposed to use netlink to get the interface status
yet?

Currently, with the items in *_attr[] in sysfs.c in batman-adv
commented out, I get these errors:

---
root@Linus-Debian:~# batctl if
ens3: <error reading status>
ens5: <error reading status>
---

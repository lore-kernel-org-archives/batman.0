Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 31 Mar 2016 17:35:13 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160331153512.GA2989@otheros>
References: <56F5AF2F.6060904@t-online.de> <34764958.y3lWsCmXTL@prime>
 <20160330135842.GA19985@r2d2.s.lihas.de> <3605600.IEJkB4EzUh@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3605600.IEJkB4EzUh@prime>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

On Thu, Mar 31, 2016 at 02:11:19PM +0200, Simon Wunderlich wrote:
> 2.) TRANSITIVE flag as proposed by Linus
> 
>  + outside of batman-adv (no maintenance work)
>  + can be set by the user through sysfs, similar to settings of batman-adv
>  + semi-automation possible: Other software like VPNs, or network drivers 
> could set this flag without specifically need to integrate with batman-adv 
> (not sure if this would ever happen though)
>  - will take some time to be adopted: first it goes into the Linux kernel, 
> OpenWRT will have it when it updates to the new kernel. That could easily be 
> 1-2 years
>  - requires more work with on other components, don't know if the various 
> upstream projects will want that
>  - linux-net adoption unclear (but there are already ~18 flags, why not have 
> one more)
>  - Personally, I don't like the name TRANSITIVE. What we really want to say is 
> whether we expect all other nodes in a broadcast domain to receive broadcasts 
> sent by anyone. Maybe we could use a more clear/easier/common name?

Also:

+ can be used by other routing protocols, too
  (for instance BABEL and it's split-horizon switch - works similar
  to the no-rebroadcast sysfs thingy for batman-adv, but for protocol
  instead of broadcast/multicsat traffic
- can still break some setups if bridges on remote devices are involved
  (for instance bridge between ethernet and adhoc, like Adrian
  pointed out)

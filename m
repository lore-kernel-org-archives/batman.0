Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 21 Oct 2016 17:31:35 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161021153135.GC3607@otheros>
References: <mailman.126.1477060277.610.b.a.t.m.a.n@lists.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mailman.126.1477060277.610.b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: [B.A.T.M.A.N.] i found time delay is very high and there are
 more caution info , if possible , please give me some advisement
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Oct 21, 2016 at 04:31:20PM +0200, johnzeng via B.A.T.M.A.N wrote:
> Date: Fri, 21 Oct 2016 22:31:00 +0800
> From: johnzeng <johnzeng2013@yahoo.com>
> To: b.a.t.m.a.n@lists.open-mesh.org
> Subject: i found time delay is very high and there are more caution info  ,
>  if possible , please give me some advisement

If I remember correctly, then one typical issue for Arch Linux
users was, that Arch compiles batman-adv with network-coding, even
though it is marked as "Experimental". And that introduces high latency
and/or packetloss.

johnzeug, can you check whether network coding is enabled or
disabled and if it is enabled, whether disabling helps?

(batctl nc disable)

And like Sven asked, what batman-adv version are you using. Not
that long ago the network coding default was changed to disabled
by default even if the module is compiled with NC. Maybe you run
an older batman-adv release?

Regards, Linus

Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 27 Mar 2018 17:43:08 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180327154307.GA2052@otheros>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
 <20161029103301.GD1692@nanopsycho.orion>
 <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161029105628.GE1692@nanopsycho.orion>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
 mcast sysfs files to README
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>, netdev@vger.kernel.org, davem@davemloft.net

On Sat, Oct 29, 2016 at 12:56:28PM +0200, Jiri Pirko wrote:
> >> I strongly believe it is a huge mistake to use sysfs for things like
> >> this. This should be done via generic netlink api.
> >
> >This doesn't change the problem that it is already that way. This patch
> >only adds the list of available files to the README.
> 
> Sure. Just found out you did it like that. Therefore I commented. I
> suggest to rework the api to use genl entirely.

Hi Jiri,

Thanks for sharing your thoughts!

Could you explain a bit more on which disadvantages you see in
the usage of sysfs here?

Regards, Linus

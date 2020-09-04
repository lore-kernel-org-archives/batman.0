Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Fri, 4 Sep 2020 20:44:03 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Is it possible to send all batman-adv traffic through http proxy
 cache?
Message-ID: <20200904184403.GA2391@otheros>
References: <CA+RexfHNV+HY28OiuHKNy4Rn=MM4gxOU0xCiVG0z56dfnv_z6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+RexfHNV+HY28OiuHKNy4Rn=MM4gxOU0xCiVG0z56dfnv_z6g@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi, 

On Fri, Aug 28, 2020 at 06:00:59PM -0400, Chuck Ritola wrote:
> Is it possible to send all batman-adv ethernet traffic through an HTTP
> proxy cache such as Squid?

Not really, there are a bunch of headers too many for an HTTP
caching proxy to work with batman-adv.

I'm wondering, are HTTP caching proxies actually still useful these
days where all major sides have switched to HTTPS?

> Another consideration was ALFRED but it doesn't appear to be easily
> integratable with existing software.

Alfred is more useful for little bits of information, not really
for complete packet streams.


The "best" solution I could think of right now for limited uplink
bandwidths is hosting content within your mesh network instead.
Like setting up a Seafile or MediaGoblin, for instance.

Or using P2P technologies, like Bittorrent. Although you might
need to be careful with this particular one that it won't greedly
occupy the rest of the bandwidth your uplink has left, if content is
still mainly shared over the uplink and not within the mesh.

Regards, Linus

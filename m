Return-Path: <booray@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAxzKbSv9+vcOVCcoqg9FDOskuZd=_GK2pmq7jk4E4eAQbqWYg@mail.gmail.com>
References: <CAAxzKbSv9+vcOVCcoqg9FDOskuZd=_GK2pmq7jk4E4eAQbqWYg@mail.gmail.com>
Date: Wed, 26 Nov 2014 15:21:59 -0800
Message-ID: <CAA51LVoFGGgaefVXr01YXxJf+VnBFBGjjxr1ftKjkFkP9UMHHw@mail.gmail.com>
From: Ray Gibson <booray@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Bridging multiple mesh segments across WAN
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Nov 26, 2014 at 3:05 PM, tjhowse <tjhowse@gmail.com> wrote:

> I would like to join up the separate mesh segments, via the site
> network, such that a client to one segment can ping a client of
> another network, having the traffic transparently tunnel via the WAN.
> Has anyone looked at doing this in the past?

I've successfully added tap interfaces into bat0, with openvpn
connecting the sites in a ring, with no problems.  It took a little
while to get the MTU's right as each layer has its own overhead, but
it worked great and clients in one state acted as if they were on the
same switched network as clients in the other.

I can dig up some example configs if it's useful to you or the group.

Thanks,

Ray

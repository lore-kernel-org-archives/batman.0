Return-Path: <tjhowse@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA51LVoFGGgaefVXr01YXxJf+VnBFBGjjxr1ftKjkFkP9UMHHw@mail.gmail.com>
References: <CAAxzKbSv9+vcOVCcoqg9FDOskuZd=_GK2pmq7jk4E4eAQbqWYg@mail.gmail.com>
 <CAA51LVoFGGgaefVXr01YXxJf+VnBFBGjjxr1ftKjkFkP9UMHHw@mail.gmail.com>
From: tjhowse <tjhowse@gmail.com>
Date: Wed, 3 Dec 2014 08:37:51 +1000
Message-ID: <CAAxzKbSs+HGDsR1jacP1GWWzFDSHyDiCVJNBv=sabeRbupa0gw@mail.gmail.com>
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

Hi Ray,

That sounds like it would save me a lot of legwork. If you could post
something up that would be brilliant. Feel free to email me directly
if the list doesn't accept attachments.

Thanks,
Travis.

On 27 November 2014 at 09:21, Ray Gibson <booray@gmail.com> wrote:
> On Wed, Nov 26, 2014 at 3:05 PM, tjhowse <tjhowse@gmail.com> wrote:
>
>> I would like to join up the separate mesh segments, via the site
>> network, such that a client to one segment can ping a client of
>> another network, having the traffic transparently tunnel via the WAN.
>> Has anyone looked at doing this in the past?
>
> I've successfully added tap interfaces into bat0, with openvpn
> connecting the sites in a ring, with no problems.  It took a little
> while to get the MTU's right as each layer has its own overhead, but
> it worked great and clients in one state acted as if they were on the
> same switched network as clients in the other.
>
> I can dig up some example configs if it's useful to you or the group.
>
> Thanks,
>
> Ray

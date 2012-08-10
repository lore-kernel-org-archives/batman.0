Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120807104651.GA25568@pandem0nium>
References: <CAHD-aqJubnMBSuyjyS+aOXnS8FSQe=w8Aj2-SnaohNqXSs_xJg@mail.gmail.com>
 <20120807104651.GA25568@pandem0nium>
From: Gui Iribarren <gui@altermundi.net>
Date: Fri, 10 Aug 2012 16:27:13 -0300
Message-ID: <CAHD-aqLExJDuKfYE+TBtruth=YFwbH4PhzYfgWje6N+pxj93hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] propagate gw_mode over two mesh linked by
 ethernet with bla2
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

On Tue, Aug 7, 2012 at 7:46 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hello Guido,
>
>> OGMs flood the ethernet backbone again as expected; running "batctl o"
>> in mesh1 nodes show nodes from mesh2, and viceversa; i smiled!
>> unfortunately, trying to get a DHCP lease while connected to a mesh
>> node was again malfunctioning :(
>> a couple of quick "batctl td", and i thiiiink that looked like dhcp
>> request packets were being dropped at the backbone gateway, kinda like
>> the "check incoming type for bla" bug, but i didn't try to narrow it
>> down
>> instead reverted configs back to gw_mode=off and things started working again
>
> Mhm, we could track this further down if you want. So you have eth0 in your
> bridge and batman using a VLAN (e.g. eth0.1234) at the same time?

Case closed: i had gone lost in a myriad of different openwrt
revisions, compiled binaries, and patches, so I unknowingly "updated"
that part of the network to a more recent openwrt version, but that
didn't have the "check incoming type for bla" patch.
So it was a simple regression on my part. I just reflashed those
routers to a firmware confirmed to include the patch, and everything
is working again. (bla2+gw_mode+vlan)
Thanks a lot Marek for pushing that patch to openwrt batman-adv stable
package, it helped a lot in getting things straight :)

> Feel free to update the Wiki, although I'd suggest to add an FAQ to the
> user page and not on the technical documentation. :)

Done, added two entries to the FAQ rewording this thread :)

Thanks as always,

Gui

Return-Path: <x@muc.ccc.de>
Message-ID: <4B84E3B1.9010702@muc.ccc.de>
Date: Wed, 24 Feb 2010 09:30:41 +0100
From: x@muc.ccc.de
MIME-Version: 1.0
References: <84e340bd1002232218k6238a13flf790f9e72f2fba9d@mail.gmail.com>
In-Reply-To: <84e340bd1002232218k6238a13flf790f9e72f2fba9d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv r1575 on openwrt 8.09.2 no originators
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

hi!

> I have Batman-adv r1575 on openwrt 8.09.2, but i can't find any originators.

hm, would be nice to know on what architecture... :)

> On a clean install of openwrt with batman:
> Enable wifi
> Set channel to 1
> set mode to ahdemo
> restart
> 
> Is there something I missed?

you should set the mtu to batman-interface-mtu + 24 (so usually 1524) - but i doubt that originator messages are dumped because of this.

it reminds me of initial tries with mixed batman 0.1 and batman 0.2 nodes. the protocol obviously isn't compatible between those.

otherwise it would be interesting to know whether your wifi interface and the batman interface are UP, and what /proc/net/batman-adv/interfaces says (wifi interface should be listed as active).

a tcpdump on your wifi interface should show whether any/originator messages are sent or received via the radio interface.

regards,

	Chris

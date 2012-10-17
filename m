Return-Path: <sophana78@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADP5dB4pSgbAMu9yUSwp_fqnanN=wS2Mgz6qdKLqqLNwn7FgWQ@mail.gmail.com>
References: <CADP5dB6JgRxvUK_3OzC8E9tpBXxwzPPC5uh31QDpEjozEdf7_w@mail.gmail.com>
 <CAHD-aq+sdGMx67Wq4QFW==EBoWifHvCC_HgUHWFPsC0e2Ox8dg@mail.gmail.com>
 <CADP5dB44Or62qRPptw-J0MC4tTD92GupZeB5dgXyeJg4ycjAow@mail.gmail.com>
 <CAHD-aq+4FiT1Na7KiErHFujEetFSKOppDKu8HBf0ueOiTa4nvQ@mail.gmail.com>
 <CAHD-aqLqQB=r9070Zv3tFoK-JBDBK7358mGqKZCGhrYc0Bcwbg@mail.gmail.com>
 <CADP5dB4pSgbAMu9yUSwp_fqnanN=wS2Mgz6qdKLqqLNwn7FgWQ@mail.gmail.com>
Date: Wed, 17 Oct 2012 23:14:50 +0200
Message-ID: <CADP5dB6YJjcDDchkP5pYQ=d+xVn9X=Sm3U4zmQaF+43ED=QfbA@mail.gmail.com>
From: Sophana K <sophana78@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] How to detect gateway mode in openwrt?
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

I may have found a possible solution by parsing the output of batctl
transglobal, and look for the gateway mac address. If the gateway is
in the transglobal table, it is accessed through the mesh, and it is
probably not connected directly to the router.

If 2 nodes are connected to the same wired ethernet network, there
will be 2 "gateways", and I will have to do something to detect this,
maybe using some broadcast?

On Wed, Oct 17, 2012 at 9:31 AM, Sophana K <sophana78@gmail.com> wrote:
> On Tue, Oct 16, 2012 at 10:44 PM, Gui Iribarren <gui@altermundi.net> wrote:
>
>> i think i don't fully understand your setup. could you care to
>> describe it a little bit further?
>
> The setup I would like is quite simple.
> I would like a mesh exporting 2 ssid.
> The private one would be a transparent bridge to the WAN network,
> because I don't want the mesh nodes to handle the routing thing, and
> let the existing network as it is. Here, the WAN network is in fact
> the existing LAN.
> The second network would be a public network, with coova-chilli
> handling the whole network. There would be a single hotspot controller
> in the gateway node. This is why I would need to know which node is
> connected to internet.
> I know the "gateway" node is not really a gateway as it is bridged.
>
>> Here you go,
>>
>> http://openwrt.altermundi.net/snapshots/r33399/ar71xx/batman-ipv6/
>
> Thanks.
> ipv6 in the name means that it is compatible with ipv6? or does it need ipv6?
>
> Do you have a link to somewhere explaining all the features of your
> firmware? You may create a readme file somewhere explaining all this,
> including the network achitecture?

Return-Path: <ajeetbbr@gmail.com>
MIME-Version: 1.0
Date: Thu, 12 Sep 2013 19:06:52 +0530
Message-ID: <CAHQ_bghKkrNisgdgTQk2+MScz0BwAF2ESBKLjn90AHACdMKJ2g@mail.gmail.com>
From: ajeet singh <ajeetbbr@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Network Coding testing.
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello All,

I am trying to test network coding functionality of batman-adv. I am
facing some problems.

Please find my topology information,

I created network with three nodes ( ad-hoc),

Node A --- Node B --- Node C

I did following settings,

--- Complied latest batman-adv. with NC enabled.
--- I did all setting form
http://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding
--- Kept all nodes in promiscuous mode. (Nodes are working properly in
this mode).

When I started iperf (TCP) from node A to node C, Node B stopped
responding after few seconds. B is not sending OGM to A and C.

When I tested without NC everything work fine.

Is there any additional settings required for NC test?

Please let me know if anyone faced similar issues.


Thanks

Ajeet



On Thu, Sep 12, 2013 at 3:30 PM,
<b.a.t.m.a.n-request@lists.open-mesh.org> wrote:
> Send B.A.T.M.A.N mailing list submissions to
>         b.a.t.m.a.n@lists.open-mesh.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
> or, via email, send a message with subject or body 'help' to
>         b.a.t.m.a.n-request@lists.open-mesh.org
>
> You can reach the person managing the list at
>         b.a.t.m.a.n-owner@lists.open-mesh.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of B.A.T.M.A.N digest..."
>
>
> Today's Topics:
>
>    1. Fwd: Re:  Hamburg freifunk geekend02 (Nicol?s Ech?niz)
>    2. fool batman by simulating a layer3 mesh (Bastian Bittorf)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 11 Sep 2013 20:47:54 -0300
> From: Nicol?s Ech?niz <nicoechaniz@altermundi.net>
> To: The list for a Better Approach To Mobile Ad-hoc Networking
>         <b.a.t.m.a.n@lists.open-mesh.org>
> Subject: [B.A.T.M.A.N.] Fwd: Re:  Hamburg freifunk geekend02
> Message-ID: <5231012A.60709@altermundi.net>
> Content-Type: text/plain; charset=UTF-8
>
> I'm forwarding this e-mail to the list per request of Andre.
>
>
> -------- Mensaje original --------
> Asunto:         Re: [B.A.T.M.A.N.] Hamburg freifunk geekend02
> Fecha:  Wed, 11 Sep 2013 10:18:09 +0200
> De:     Andre Schmidt <m.andre.schmidt@me.com>
> A:      nicoechaniz@altermundi.net <nicoechaniz@altermundi.net>
>
>
>
> A filter on the list rejects my answer, so I can only answer to you.
> Maybe you can forward it to the list, in case others care as well. thanks
>
>
> Hi Nico,
>
> By physically connected you mean wireless mesh and by VPN you mean
> cable-based VPN over the internet?
> Mostly the latter, but it is mixed. You can check out our node graph [0]
> to get an impression of the topology.
>
> See you in Berlin,
> andre
>
> [0] http://knotengraph.de <http://knotengraph.de>
>
>
> Am 11.09.2013 um 10:00 schrieb Nicol?s Ech?niz
> <nicoechaniz@altermundi.net <mailto:nicoechaniz@altermundi.net>>:
>
>> El 07/09/13 06:38, Andre Schmidt escribi?:
>>> Hi there,
>>>
>>> Sep. 27.-29., 2013, we'll meet up for geekend02 [0] at B?rgerhaus
>>> Hamburg-Eidelstedt, Germany. This is going to be a great opportunity
>>> to meet AFK. Naturally, you can bring your own keyboard, so it's all
>>> good, don't worry.
>>>
>>> Since Hamburg is probably one of the larger B.A.T.M.A.N. networks on
>>> this planet w/ 300+ routers constantly online and still growing
>>> rapidly, we do fear that we'll run into scaling problems sooner or
>>> later. Therefore, your expertise on how to counteract is very
>>> welcome.
>>
>> sounds very interesting, please document :)
>>
>> are this 300+ routers physically connected or is it mostly VPN?
>>
>> hope to meet some of you during the summit in Berlin and to hear more
>> about your conclusions regarding scalability.
>>
>>
>> cheers,
>> Nico
>>
>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 12 Sep 2013 11:36:41 +0200
> From: Bastian Bittorf <bittorf@bluebottle.com>
> To: b.a.t.m.a.n@lists.open-mesh.org
> Subject: [B.A.T.M.A.N.] fool batman by simulating a layer3 mesh
> Message-ID: <20130912093641.GX1558@medion.lan>
> Content-Type: text/plain; charset=us-ascii
>
> discussed in IRC, i'am searched for a better way to
> load-balance a batman network. not the whole shaping/splashing
> should run on one (central) node, so we needed something to stick it
> to the node/AP which the user is connected to. than we have also
> the ability to show a good page when the network is b0rken.
>
> short overview:
>
> NODE-1 (master/gateway)
> ipv4: 192.168.1.1/16
> dhcp: 192.168.1.x / gateway: 192.168.0.1
> gateway: e.g. pppoe
>
> NODE-2
> ipv4: 192.168.2.1/16
> dhcp: 192.168.2.x / gateway: 192.168.0.1
> gateway: 192.168.1.1
>
> NODE-3
> ipv4: 192.168.3.1/16
> dhcp: 192.168.3.x / gateway: 192.168.0.1
> gateway: 192.168.1.1
>
> the trick is, that every node offers DHCP which
> does not interfere with other nodes AND offers a
> gateway which is always the same: 192.168.0.1
>
> if a user roams he simply moves on layer 1/2 and
> its further working ok. important: the MAC of the
> gateway should not change otherwise it's not working
> for some seconds till the ARP times out. this can
> be circumvented via kmod-macvlan:
>
> ip link add link br-mybridge gateway0 address '02:00:c0:ca:c0:1a' type macvlan
> ip address add 192.168.0.1/16 dev gateway0
> ip link set dev gateway0 up
>
> then the IP 192.168.0.1 is always reachable with the same MAC.
> thats it. we can use the "normal" iptables/tc stuff like in
> olsrd-networks...
>
> giving out such dhcp-leases needs a fix to /etc/init.d/dhcp
> which is available soon on OpenWrt mailinglist.
>
> bye, bastian
>
> PS:
> thanks for the discussion and help, escpecially to T_X, ordex and marec
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.org
> https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
>
>
> ------------------------------
>
> End of B.A.T.M.A.N Digest, Vol 81, Issue 25
> *******************************************



-- 
Thanks
Ajeet

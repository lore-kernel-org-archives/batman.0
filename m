Return-Path: <sophana78@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHD-aq+sdGMx67Wq4QFW==EBoWifHvCC_HgUHWFPsC0e2Ox8dg@mail.gmail.com>
References: <CADP5dB6JgRxvUK_3OzC8E9tpBXxwzPPC5uh31QDpEjozEdf7_w@mail.gmail.com>
 <CAHD-aq+sdGMx67Wq4QFW==EBoWifHvCC_HgUHWFPsC0e2Ox8dg@mail.gmail.com>
Date: Tue, 16 Oct 2012 21:18:00 +0200
Message-ID: <CADP5dB44Or62qRPptw-J0MC4tTD92GupZeB5dgXyeJg4ycjAow@mail.gmail.com>
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

On Mon, Oct 15, 2012 at 5:33 PM, Gui Iribarren <gui@altermundi.net> wrote:
> Hey Sophana,
> Don't bridge the wan, as you won't be able to route then.

I would like to explicitely bridge the wan, as it is the private
network. Just like a transparent wifi access point would do.
Routing is not always what you want if you connect to your private LAN.

> we solved that "missing piece" with a few scripts
>
> https://bitbucket.org/guidoi/batmesh/src/tip/packages/batman-adv-auto-gw-mode
> https://bitbucket.org/guidoi/batmesh/src/tip/packages/watchping
>

Thanks a lot for sharing your code. I took some time to understand how it works.
If I understand correctly, you are using the batman-adv gateway feature.
watchping is a script that simply uses ping on a specific interface to
determine wether you are connected to the internet.
When connected, you launch a dhcp server. When not, you launch a dhcp client.

Using dhcp means that you are routed.

As I would like to be bridged, this looks like it is not really a
solution for me.
The only solution I see is to start with the wan not bridged, test
internet connection for a certain amount of time, then definitively
decide if we are gateway or not.

When you are bridged, is there is solution to ping only the WAN port?

I still have to test your solution. Do I have to install all the
batmesh packages? It seems that the whole configuration is made in
batmesh-autoconf?
Too bad you don't have all default ar71xx router images ready to flash.

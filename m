Return-Path: <sophana78@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHD-aqKiZGOHmAnzZxF2T8G_HSAf6KW-UWQ62apUN0fus1k5jQ@mail.gmail.com>
References: <CADP5dB6JgRxvUK_3OzC8E9tpBXxwzPPC5uh31QDpEjozEdf7_w@mail.gmail.com>
 <CAHD-aq+sdGMx67Wq4QFW==EBoWifHvCC_HgUHWFPsC0e2Ox8dg@mail.gmail.com>
 <CADP5dB44Or62qRPptw-J0MC4tTD92GupZeB5dgXyeJg4ycjAow@mail.gmail.com>
 <CAHD-aq+4FiT1Na7KiErHFujEetFSKOppDKu8HBf0ueOiTa4nvQ@mail.gmail.com>
 <CAHD-aqLqQB=r9070Zv3tFoK-JBDBK7358mGqKZCGhrYc0Bcwbg@mail.gmail.com>
 <CADP5dB4pSgbAMu9yUSwp_fqnanN=wS2Mgz6qdKLqqLNwn7FgWQ@mail.gmail.com>
 <CADP5dB6YJjcDDchkP5pYQ=d+xVn9X=Sm3U4zmQaF+43ED=QfbA@mail.gmail.com>
 <CAHD-aqKiZGOHmAnzZxF2T8G_HSAf6KW-UWQ62apUN0fus1k5jQ@mail.gmail.com>
Date: Fri, 19 Oct 2012 10:32:12 +0200
Message-ID: <CADP5dB5XOqFncK34xg7-+jrqQH3qEeZnpoj-92LQjk-HUO3_WA@mail.gmail.com>
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

With this solution (if it works), both the WAN(private) and
LAN(public) network would always remain bridged to the mesh and LAN
and WAN ethernet ports.

The script has to determine if it is the gateway, mainly because there
must be only one coova-chilli hotspot instance which manages the LAN
network. This coova-chilli IS the gateway for the LAN (public)
network.
Note that it seems that coova-chilli has a cluster mode which is not
documented, and seems to allows multiple hotspot instances to work in
failover mode. (have to test it)

About translocal and transglobal tables, if I understood correctly,
translocal shows only mesh nodes, while transglobal shows all the mac
addresses in the arp table?


On Fri, Oct 19, 2012 at 6:45 AM, Gui Iribarren <gui@altermundi.net> wrote:

> It's more.. robust.. if you parse translocal table instead. BUT...
>
> Why not just connect the gateway to the LAN switch (or permanently
> bridge the WAN, which is equivalent)?
> Why do you want to "break" the bridge? Under what circumstances does
> that make sense (or why is it a problem to leave the WAN bridged when
> the gateway is not directly connected)?

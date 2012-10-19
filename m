Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CADP5dB6YJjcDDchkP5pYQ=d+xVn9X=Sm3U4zmQaF+43ED=QfbA@mail.gmail.com>
References: <CADP5dB6JgRxvUK_3OzC8E9tpBXxwzPPC5uh31QDpEjozEdf7_w@mail.gmail.com>
 <CAHD-aq+sdGMx67Wq4QFW==EBoWifHvCC_HgUHWFPsC0e2Ox8dg@mail.gmail.com>
 <CADP5dB44Or62qRPptw-J0MC4tTD92GupZeB5dgXyeJg4ycjAow@mail.gmail.com>
 <CAHD-aq+4FiT1Na7KiErHFujEetFSKOppDKu8HBf0ueOiTa4nvQ@mail.gmail.com>
 <CAHD-aqLqQB=r9070Zv3tFoK-JBDBK7358mGqKZCGhrYc0Bcwbg@mail.gmail.com>
 <CADP5dB4pSgbAMu9yUSwp_fqnanN=wS2Mgz6qdKLqqLNwn7FgWQ@mail.gmail.com>
 <CADP5dB6YJjcDDchkP5pYQ=d+xVn9X=Sm3U4zmQaF+43ED=QfbA@mail.gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Date: Fri, 19 Oct 2012 01:45:53 -0300
Message-ID: <CAHD-aqKiZGOHmAnzZxF2T8G_HSAf6KW-UWQ62apUN0fus1k5jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On Wed, Oct 17, 2012 at 6:14 PM, Sophana K <sophana78@gmail.com> wrote:
> I may have found a possible solution by parsing the output of batctl
> transglobal, and look for the gateway mac address. If the gateway is
> in the transglobal table, it is accessed through the mesh, and it is
> probably not connected directly to the router.
It's more.. robust.. if you parse translocal table instead. BUT...

Why not just connect the gateway to the LAN switch (or permanently
bridge the WAN, which is equivalent)?
Why do you want to "break" the bridge? Under what circumstances does
that make sense (or why is it a problem to leave the WAN bridged when
the gateway is not directly connected)?

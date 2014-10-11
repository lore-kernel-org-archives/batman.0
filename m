Return-Path: <dirkvanderwalt@gmail.com>
MIME-Version: 1.0
Date: Sat, 11 Oct 2014 09:07:20 +0200
Message-ID: <CACgQMVKxKvYoo1TY_Cz7iAxD1VYMhC+77ZZ+a5ZsNohp8k5huA@mail.gmail.com>
From: Dirk van der Walt <dirkvanderwalt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] help for batman-adv with monitor WiFi card
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

Hi Jammy,

I can also confirm what Antonio replied.

When I was building firmware for MESHdesk using the then trunk
(Barrier Breaker) I nearly gave up on the Dragino hardware (AR9331)
because the adhoc connections between nodes refused to connect beyond
1Mbps unless you restart the WiFi a one or more times.

Other Atheros based hardware like the OM2P's did not have the same issue though.

On advise from Steve Song (Village Telco) I tried Attitude Adjustment
and all that problems disappeared and there is now proper speed
between the adhoc connections.

I haven't tried again on Barrier Breaker, but will probably in the
near future do another attempt and see if the problem still exists now
that it has been released.

Cheers

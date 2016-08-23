Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 23 Aug 2016 03:31:00 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160823013100.GC27083@otheros>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
 <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
 <2069472.CH1chEaXG0@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2069472.CH1chEaXG0@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Snoop DHCPACKs for DAT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Jul 10, 2016 at 01:42:32PM +0200, Sven Eckelmann wrote:
> It sounds like the patch didn't help. So I will postpone my review.

Right. As discussed with Antonio on IRC, we might go with
Andreas's original patch to snoop IP traffic - but only to update
already existing, local DAT entries. So some changes still needed
in that patch there.

The approach is similar to what the Linux IP stack does for it's own
neighbor tables already.

Then we will see how much ARP traffic is still left afterwards.

I'm marking this patch as "Defered" in patchwork.


Further revelations, test results, ideas and progress will be
probably be tracked here:

https://www.open-mesh.org/issues/291

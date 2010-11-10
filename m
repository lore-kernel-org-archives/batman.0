Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Wed, 10 Nov 2010 01:48:12 +0100
Message-Id: <1289350093-5782-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] batman-adv promisc mode,
	further notes and recomendations
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

After some discussions on IRC we've decided to skip the sequence
number checking for now and to not care about forwarding a packet
to the higher layers more than once. Usually, higher layer protocols
are in charge and should be capable of detecting and coping not only
with lost, but also duplicate packets. I'm not aware of any protocol
which might have any difficulties with this (if you know one, please
let me know). If you have special, "custom" protocol which is not able
to cope with it, then you're adviced to not activate the promisc-mode
on that node's interface.

I also did some further testing on how usable such a feature on
embedded devices is. Smaller, less powerful devices like the Fonera
2.0 can have some performance decreases in a very busy, noisy mesh
neighborhood. All other scenarios and more performant devices should
be fine with the promisc mode, however feel free to do your own
measurments to find out if this promisc-mode feature is suitable
and benefitial for you (and share your experiences :) ).

Cheers,
Linus

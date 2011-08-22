Return-Path: <javier@cozybit.com>
MIME-Version: 1.0
From: Javier Cardona <javier@cozybit.com>
Date: Mon, 22 Aug 2011 16:30:56 -0700
Message-ID: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] A case for batman-11s
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
Cc: devel@lists.open80211s.org, Clara Gnos <clara.gnos@googlemail.com>

Hi batman developers,

Clara Gnos suggested that I write to the list to make a case for
batman + 802.11s integration.  As you probably know, 802.11s is the
upcoming wireless mesh standard from IEEE.  The current version of the
draft was approved by the IEEE 802 Executive Committee in July and
will be ratified next month.  open80211s (http://o11s.org) is an open
implementation of 802.11s that's in the kernel mainline since 2.6.26.

802.11s uses HWMP as its default routing (path selection, in
11s-speak) protocol.  All 11s implementations must support this
default, and this is what's implemented in open80211s.  The 11s spec
also defines an extensible framework to support other path selection
protocols and custom metrics.  open80211s supports these by providing
userspace hooks for custom path selection daemons.

Which brings me to the main point of my e-mail:  is anyone out there
interested in porting batman's path selection algorithm into
open80211s?
The benefits:

1. By being based on a standard, you'll know you won't be colliding
with other layer 2 technologies (for instance, no need to define your
own ethertype)
2. You can leverage most of open80211s, from test tools to wireshark patches.
3. By being integrated in the kernel's 802.11 stack, you can take
advantage of the development that's taking place there, from encrypted
management frames to HT support.
4. You can reach out to a larger development community and raise
awareness about batman.
5. A big problem in mesh adoption on Linux is not the mesh protocol
itself but the absence of simple to use configuration tools (e.g. no
mesh support in ConnMan, NetworkManager, etc.).  By providing a
unified wireless mesh framework we increase the likelihood of having
some support at the distro level.
and last, but not least...
6. You'll be able to say authoritatively that batman is X times more
efficient than HWMP (pick any X greater than 1 :)

Anyway, that was just a thought.  If anyone is interested let me know.

Cheers,

Javier

-- 
Javier Cardona
cozybit Inc.
http://www.cozybit.com

Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Date: Fri, 11 Jun 2010 20:32:51 +0200
Message-ID: <874oh9o1ws.fsf@pirx.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] WBMv3: a Babel perspective
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
To: battlemesh@ml.ninux.org, babel-users@lists.alioth.debian.org, olsr-users@lists.olsr.org, tmplab@lists.tmplab.org, b.a.t.m.a.n@open-mesh.net

Hi,

Many of us spent last week-end at the third edition of the Wireless
BattleMesh in Bracciano, north of Rome, experimenting with wireless mesh
routing technologies.  Here's a quick summary of the events, from the
perspective of the Babel routing protocol.


1. The main event
*****************

The main goal of the meeting was to evaluate the real-world behaviour of
a bunch of wireless mesh routing protocols.  Five protocols were
evaluated: OLSR, Babel, and three variants of BATMAN.

The protocol were tested in three static topologies: a broken network,
a network with massive packet loss, and a network with high but
reasonable packet loss.  Elektra has written up a summary of the results
(thanks!) of which I've put a copy on

  http://www.pps.jussieu.fr/~jch/software/babel/wbmv3-elektra.pdf

In short:

 (1) when the network is broken, Babel is the first to collapse;
 (2) Babel behaves well when the network is usable;
 (3) Babel generates too many small packets on broken networks.

I believe that (1) is normal: Babel reacts faster than the other
protocols to mobility, and therefore tends to be less stable than the
others in broken networks.

Point (3) is due to the route request mechanism: a Babel node in
a broken network is trying too hard to discover new routes.  I'm not
sure whether that can be fixed without losing Babel's fast reaction to
mobility.


2. Helicopters with webcams and sharks with lasers
**************************************************

In addition to the main event, described above, there were a few
interesting side events.  The Roman crowd (ninux.org) have been working
on running Linux on a model helicopter equipped with Wifi and a webcam;
the goal would have been to stream video from the over a Babel mesh.
Which got me excited like a child before Christmas.

Unfortunately, they didn't have time to complete the experiment (due to
issues with ffmpeg, as far as I understand), which is a huge pity.
Let's hope we hear from the webcam-equipped helicopter soon.

There were no sharks equipped with lasers, whether running Linux or
otherwise.


3. Diversity-aware routing
**************************

Zoobab and myself have been trying to work on diversity-aware routing
protocols.  There is now a branch of babeld (known as babelz) which
performs diversity-aware routing, and appears to work.  However, due to
wine, beer, grappa and other factors outside of our control, we haven't
managed to obtain any useful measurements from babelz.

Babelz should be made public as soon as I find some time to finish
debugging it.  In the meantime, let me know if you want a copy.


4. Babel for OpenBSD
********************

Dermiste has finished the Babel port to OpenBSD, and we've been able to
do some debugging -- it appears to work now.  This implies that Babel
should be easy to port to other Kame stacks (notably FreeBSD and Darwin).

The code hasn't been merged into the trunk yet.


5. Time-lapse video
*******************

Somebody (who?) has been experimenting with time-lapse video.  The
results are quite amusing -- search Youtube for "BattleMeshV3".

My only regret the time-lapse video has been made on DRM'd hardware
running proprietary software.  (Folks, we need hackable digital cameras
-- CHDK is not enough.)


6. Other stuff
**************

I've had a lot of extremely interesting discussions with a lot of
extremely interesting people.  In no particular order, I've learnt a lot
about automatic tunnelling of IPv4 in v6, The Pirate Party, solar cells,
BMX, Liquid Democracy, MOSFETs, Ugo Foscolo, rural exodus in the Greek
islands, wireless networking in Catalogna and groundsheets.

My liver has almost recovered.


7. Thanks
*********

Yes, thanks.


                                        Juliusz

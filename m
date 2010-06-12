Return-Path: <aaron@lo-res.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <874oh9o1ws.fsf@pirx.pps.jussieu.fr>
Date: Sat, 12 Jun 2010 07:36:01 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FE97F6D-EAF6-4E7D-BB15-1917CBB2813E@lo-res.org>
References: <874oh9o1ws.fsf@pirx.pps.jussieu.fr>
Subject: Re: [B.A.T.M.A.N.] WBMv3: a Babel perspective
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: tmplab@lists.tmplab.org, olsr-users@lists.olsr.org, battlemesh@ml.ninux.org, babel-users@lists.alioth.debian.org


On Jun 11, 2010, at 2:32 PM, Juliusz Chroboczek wrote:

> Hi,
>=20
> Many of us spent last week-end at the third edition of the Wireless
> BattleMesh in Bracciano, north of Rome, experimenting with wireless =
mesh
> routing technologies.  Here's a quick summary of the events, from the
> perspective of the Babel routing protocol.
>=20
>=20
> 1. The main event
> *****************
>=20
> The main goal of the meeting was to evaluate the real-world behaviour =
of
> a bunch of wireless mesh routing protocols.  Five protocols were
> evaluated: OLSR, Babel, and three variants of BATMAN.
>=20
> The protocol were tested in three static topologies: a broken network,
> a network with massive packet loss, and a network with high but
> reasonable packet loss.  Elektra has written up a summary of the =
results
> (thanks!) of which I've put a copy on
>=20
>  http://www.pps.jussieu.fr/~jch/software/babel/wbmv3-elektra.pdf
>=20
> In short:
>=20
> (1) when the network is broken, Babel is the first to collapse;
> (2) Babel behaves well when the network is usable;
Could you be a bit more specific with "usable"?? What does that mean =
regarding=20
packetloss?
The interesting problem with Wi-Fi networks is that we have usually way =
too much=20
packet loss. (remember: that was also the main critique against the MPR =
approach)


> (3) Babel generates too many small packets on broken networks.
>=20
Which creates more collisions in the air I assume ;-)

> I believe that (1) is normal: Babel reacts faster than the other
> protocols to mobility, and therefore tends to be less stable than the
> others in broken networks.
>=20
> Point (3) is due to the route request mechanism: a Babel node in
> a broken network is trying too hard to discover new routes.  I'm not
> sure whether that can be fixed without losing Babel's fast reaction to
> mobility.
>=20
>=20
> 2. Helicopters with webcams and sharks with lasers
> **************************************************
>=20
yeah ;-) Wish I had been there..

> In addition to the main event, described above, there were a few
> interesting side events.  The Roman crowd (ninux.org) have been =
working
> on running Linux on a model helicopter equipped with Wifi and a =
webcam;
> the goal would have been to stream video from the over a Babel mesh.
> Which got me excited like a child before Christmas.
>=20
> Unfortunately, they didn't have time to complete the experiment (due =
to
> issues with ffmpeg, as far as I understand), which is a huge pity.
> Let's hope we hear from the webcam-equipped helicopter soon.
>=20
> There were no sharks equipped with lasers, whether running Linux or
> otherwise.
>=20
>=20
> 3. Diversity-aware routing
> **************************
>=20
> Zoobab and myself have been trying to work on diversity-aware routing
> protocols.  There is now a branch of babeld (known as babelz) which
> performs diversity-aware routing, and appears to work.  However, due =
to
> wine, beer, grappa and other factors outside of our control, we =
haven't
> managed to obtain any useful measurements from babelz.
>=20
;-)

> Babelz should be made public as soon as I find some time to finish
> debugging it.  In the meantime, let me know if you want a copy.
>=20
>=20
> 4. Babel for OpenBSD
> ********************
>=20
> Dermiste has finished the Babel port to OpenBSD, and we've been able =
to
> do some debugging -- it appears to work now.  This implies that Babel
> should be easy to port to other Kame stacks (notably FreeBSD and =
Darwin).
>=20
> The code hasn't been merged into the trunk yet.
>=20
>=20
> 5. Time-lapse video
> *******************
>=20
> Somebody (who?) has been experimenting with time-lapse video.  The
> results are quite amusing -- search Youtube for "BattleMeshV3".
>=20
> My only regret the time-lapse video has been made on DRM'd hardware
> running proprietary software.  (Folks, we need hackable digital =
cameras
> -- CHDK is not enough.)
>=20
>=20
> 6. Other stuff
> **************
>=20
> I've had a lot of extremely interesting discussions with a lot of
> extremely interesting people.  In no particular order, I've learnt a =
lot
> about automatic tunnelling of IPv4 in v6, The Pirate Party, solar =
cells,
> BMX, Liquid Democracy, MOSFETs, Ugo Foscolo, rural exodus in the Greek
> islands, wireless networking in Catalogna and groundsheets.
>=20
> My liver has almost recovered.
>=20
;-)

Thanks for the write up...


>=20
> 7. Thanks
> *********
>=20
> Yes, thanks.
>=20
>=20
>                                        Juliusz
>=20


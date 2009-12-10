Return-Path: <Ishwara.bhat@honeywell.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Dec 2009 10:25:29 +0530
Message-ID: <1106299A6DFA0E4D8E13CFD83A7611F00344632F@IE10EV813.global.ds.honeywell.com>
In-Reply-To: <200912101233.13945.lindner_marek@yahoo.de>
References: <771195.22552.qm@web111610.mail.gq1.yahoo.com>
	<200912101200.33322.lindner_marek@yahoo.de>
	<1106299A6DFA0E4D8E13CFD83A7611F0034462BA@IE10EV813.global.ds.honeywell.com>
	<200912101233.13945.lindner_marek@yahoo.de>
From: "Bhat, Ishwara" <Ishwara.bhat@honeywell.com>
Subject: Re: [B.A.T.M.A.N.] [Olsr-users] point me to some OSI layer
	diagramsif possible ?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: olsr list users mailing <olsr-users@lists.olsr.org>, b.a.t.m.a.n@lists.open-mesh.net


You are right.
Sorry about the confusion. It is more of wireless stack layering issue.

-----Original Message-----
From: Marek Lindner [mailto:lindner_marek@yahoo.de]=20
Sent: Thursday, December 10, 2009 10:03 AM
To: Bhat, Ishwara
Cc: b.a.t.m.a.n@lists.open-mesh.net; olsr list users mailing
Subject: Re: [Olsr-users] [B.A.T.M.A.N.] point me to some OSI layer
diagramsif possible ?

On Thursday 10 December 2009 12:28:37 you wrote:
> I thought 802.11s need not be strictly layer 2. Open source 11s driver
> is on top of MAC drivers that comply with mac80211 framework.
>=20
> http://open80211s.com/trac
>=20
> So it can be either layer 2 or 2.5.

I'm no expert on this driver because I never really used it (just had a
quick=20
look through the code) but why do you think it is layer 2.5 ?

The page you provided clearly says:
open80211s is based on the mac80211 wireless stack and should run on any
of=20
the wireless cards that mac80211 supports.

Seems it does not run over ethernet/VPNs/other_layer2 ...

Maybe you confused it with the layers inside of the linux wifi stack ?

Regards,
Marek

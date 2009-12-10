Return-Path: <Ishwara.bhat@honeywell.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Dec 2009 09:58:37 +0530
Message-ID: <1106299A6DFA0E4D8E13CFD83A7611F0034462BA@IE10EV813.global.ds.honeywell.com>
In-Reply-To: <200912101200.33322.lindner_marek@yahoo.de>
References: <771195.22552.qm@web111610.mail.gq1.yahoo.com><15EDF7F5-2A4A-4A77-87F4-193AFAA1B7CD@lo-res.org>
	<200912101200.33322.lindner_marek@yahoo.de>
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
To: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net
Cc: olsr list users mailing <olsr-users@lists.olsr.org>


I thought 802.11s need not be strictly layer 2. Open source 11s driver
is on top of MAC drivers that comply with mac80211 framework.=20

http://open80211s.com/trac

So it can be either layer 2 or 2.5.

Regards,
Ishwar

-----Original Message-----
From: olsr-users-bounces@lists.olsr.org
[mailto:olsr-users-bounces@lists.olsr.org] On Behalf Of Marek Lindner
Sent: Thursday, December 10, 2009 9:31 AM
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: olsr list users mailing
Subject: Re: [Olsr-users] [B.A.T.M.A.N.] point me to some OSI layer
diagramsif possible ?

On Thursday 10 December 2009 07:40:53 L. Aaron Kaplan wrote:
> | link, 802.11s, B.A.T.M.A.N  layer 2 version, OLPC's  802.11s|  2
the
> | HWMP and all the 80.211s stuff resides here. 802.11a/b/g/n resides
here.
> | Madwifi, ath5k and ath9k reside here.=20

Sorry, but that is not (entirely) correct. It is no problem calling
batman-adv=20
a layer 2 protocol for the sake of simplicity (it deals with MAC
addresses=20
instead of IP addresses, etc ..). But if you mention batman-adv and=20
802.11s/ath5k/etc in the same sentence you have to be more precise as
they do=20
not operate on the same layer.

batman-adv is layer 2.5 and runs on top of all ethernet based layer 2=20
protocols which means you can run it over wireless=20
(managed/adhoc/mesh/whatever mode), plain ethernet cable, VPNs and so
on.

However, 802.11s is "true" layer 2 and as such is limited to the medium=20
(wireless) as well as to the hardware & drivers.=20


Regards,
Marek

--=20
Olsr-users mailing list
Olsr-users@lists.olsr.org
http://lists.olsr.org/mailman/listinfo/olsr-users

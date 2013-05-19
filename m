Return-Path: <ff@jluehr.de>
Message-ID: <5198D34B.5050307@jluehr.de>
Date: Sun, 19 May 2013 15:27:39 +0200
From: Jan Luehr <ff@jluehr.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010404030902030302060600"
Subject: [B.A.T.M.A.N.] Fwd: Re: [Freifunk.luebeck-devel] [Freifunk-Bonn]
 On	compat version 15 in the Freifunk-KBU network
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

This is a multi-part message in MIME format.
--------------010404030902030302060600
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hello,

sorry for forwarding - mail got filtered...

Betreff: 	Re: [Freifunk.luebeck-devel] [Freifunk-Bonn] [B.A.T.M.A.N.] On=20
compat version 15 in the Freifunk-KBU network
Datum: 	Sun, 19 May 2013 14:49:45 +0200
Von: 	Jan L=FChr <ff@jluehr.de>
An: 	"Allgemeine Mailingliste zum Freifunk K=F6ln, Bonn und Umgebung"=20
<freifunk-bonn@lists.bonn.freifunk.net>
CC: 	The list for a Better Approach To Mobile Ad-hoc Networking=20
<b.a.t.m.a.n@lists.open-mesh.org>,=20
freifunk.luebeck-devel@asta.uni-luebeck.de



Hello,

Am 19.05.2013 um 12:40 schrieb Simon Wunderlich:

>  Hello yanosz,
>
>  On Sun, May 19, 2013 at 10:52:01AM +0200, Jan L=FChr wrote:
>>  Hello folks,
>>
>>  I'd like to give some thought's for the upcoming batman-adv release, es=
pecially on compat version 15. This somewhat summarizes my discussion with =
T_X on the wireless community weekend (WCW -- 2013-05-10 - 2013-05-12).
(...)
>>  It's not my intention to bash on batman-adv in general or to start flam=
e-wars (like: batman-adv vs. olsr or something else) - I'd like to provide =
some statement on the impact of the upcoming protocol changes.
>
>  Thanks for your feedback. Yes, we are preparing a compat bump (actually =
for a long time now) and it's good to discuss it. :)

Thanks for your detailed answer - I'll cut some parts for better readabilit=
y.

>
>>
>>  1. The upcoming protocol change appears to be painful - we have no suit=
able migration strategy.
(...)
>>  13 nodes in the next months - by that, we'll probably have some compat =
13 ones for at least 1/2 year. There is no way of telling newer nodes to us=
e compat version 13. Since some "supernodes" (dedicated servers) are part o=
f the batman-adv cloud, we need twice the servers as well.
>>  Upgrading to compat version 15 will require a huge amount of work: New =
infrastructure (servers) must be deployed and nodes meshing with each other=
 must be upgraded in parallel.
>
>
>  Btw, it's interesting that you use compat version 13  - only one release=
 had that included, and we are
>  on compat 14 for quite some time ...
>  [1] http://www.open-mesh.org/projects/batman-adv/wiki/Compatversion

(...) - yes, I know. Theses nodes are quite old. I guess this somewhat illu=
strates the upcoming situation.

>>
>>  2. Backwards-compatilibilty doesn't seem to be a design target.
>
>  Actually, that is one of the main design targets. We are aware that with=
 our current packet type design,
>  we cannot change even parts of the protocol without breaking compatibili=
ty. This has bothered us for quite
>  some time and we have worked on solutions to prevent compat bumps as goo=
d as possible. We have introduced
>  different means [2,3] to be able to add new features, change features, l=
et sub-features update their
>  protocols (by using TVLVs) without breaking the rest and ensure compatib=
ility on their own [3], route even
>  yet unknown packets on their own [2], ... Actually the TVLV thing is pre=
tty similar to other protocols
>  (e.g. IEEE 802.11) which use that to ensure backwards compatiblity for y=
ears. The goal is to keep the
>  compat bump stable for at least a decade now, if not longer. No guarante=
es of course, but this compat
>  bump is made to CREATE backwards compatiblity. :)
>
>  Note that the compat bump is not released yet but still only in our deve=
lopment branch.
>
>  [2] http://www.open-mesh.org/projects/batman-adv/wiki/Packet-types
>  [3] http://www.open-mesh.org/projects/batman-adv/wiki/TVLV

Thanks for the details. I understand your reasons for changing the protocol=
 - and I'm perfectly fine with that. I know that manets are an area of acti=
ve research.
Bit this won't be a problem at all, if upcoming batman-adv versions are cap=
able if "speaking" older compat versions. If done so, we (as in Freifunk-KB=
U) would be able to simple "choose" the compat version for our network - an=
d pick a newer one if needed.

>>  Since batman-adv depends on the kernel (old batman-adv versions won't b=
uild with recent kernels) using 14 will not be an option in a few months: I=
f some router hardware requires recent Kernel / OpenWRT releases version 14=
 might no longer be used.
>
>  I think it would be possible to maintain older releases of batman-adv an=
d add compatibility code for
>  newer kernels. We are doing the same now to provide compatibility for ol=
der kernels [4]. We would
>  be happy if someone (you?) would take over that job, I guess it would mo=
stly mean to test new kernels
>  and add a little bit of compat code like we do for the old kernels. You =
are welcome to contribute
>  such "stable" versions. :)
>
>  [4] http://git.open-mesh.org/batman-adv.git/blob/refs/heads/master:/comp=
at.h

Hmm... well, I'm not into kernel development, but I could maintain some CI =
services for testing. I'll ask some our folks on our next community meeting.
>
>>  ->  We're aware, that we cannot use version 14 in some months
>>  ->  At the point, when 14 becomes unusable (introduced into OpenWRT Ker=
nels / release we need -- or Debian), we will almost certainly discontinue =
batman-adv and go one with sth. else. (Due to kernel deps it's easier to ru=
n batman-adv / olsr in parallel than two different version of batman-adv)
>
>  I don't see that by releasing batman-adv with the new compat version, su=
ddenly your network breaks
>  - in Debian you usually keep the same kernel for YEARS, and in OpenWRT y=
ou can just keep the batman-adv
>  package at the desired version number. The only problem you might run in=
to is that newer kernels might
>  not work, as stated above.

Actually, it has consequences: About 5-8 months ago (don't remember the det=
ails). 2011.2 didn't build on Attitude Adjustment (12.09) (OpenWRT issue? K=
ernel Issue? I don't remember ...), while newer TP Link 1043nd models neede=
d 12.09 (brick, otherwise). At that time we're eager of deploying compat 14=
 releases - succeeding about 3,5 months ago.
But in the aftermath of it, we noticed that we did not succeed in upgrading=
 the whole network - since upgrading some nodes is still impossible because=
 of organizational issues. Some people complained about the effort needed -=
 for valid reasons, imho (although we provided free vodka at our release pa=
rty ;-) )

To be honest: I don't like to be stuck at this, again. With compat 15 on th=
e horizon, we're in the need of finding adequate strategies.
Do you have something in your mind?

>>  ->  Maybe, some future version of batman-adv addresses backwards-compat=
ibility. Maybe, in 2018 we will have a look at batman-adv again - noticing,=
 that batman-adv remained stable (or migratable) over the last years and st=
art using it again. Maybe, batman-adv will fit our needs, then.
>
>  You are free to use whatever you want. I think I've made a clear point t=
hat this compat bump is designed
>  to address the compat issues we had. What you roll out then is up to you=
 (personally I'd be interested
>  what you'll use instead) - but I guess you'll miss a lot of very nice fe=
atures of batman-adv. ;)

Yeah - I guess I'll miss some features - and there is no decision yet (not =
even candidates).
However - in retrospect - kernel-dependencies will be taken into account th=
is time.

Greetz,
yanosz





--------------010404030902030302060600
Content-Type: text/plain;
 name="Nachrichtenteil als Anhang"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Nachrichtenteil als Anhang"

_______________________________________________
Freifunk.luebeck-devel mailing list
Freifunk.luebeck-devel@asta.uni-luebeck.de
http://lists.asta.uni-luebeck.de/mailman/listinfo/freifunk.luebeck-devel


--------------010404030902030302060600--

Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201203121555.03282.lindner_marek@yahoo.de>
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
	<201203121541.04403.lindner_marek@yahoo.de>
	<CAG7VhQS9gJpSrpTL3K9w6K=tVo7fBm988SYA_io8YbNO9FYbeg@mail.gmail.com>
	<201203121555.03282.lindner_marek@yahoo.de>
Date: Mon, 12 Mar 2012 09:23:30 +0100
Message-ID: <CAG7VhQTT-x3WKXahkN5LCbEqFQnhT=0a5ZvX_JA=CRsfS1KdOA@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: avoid temporary routing
 loops by being strict on forwarded OGMs
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

2012/3/12 Marek Lindner <lindner_marek@yahoo.de>:
> On Monday, March 12, 2012 15:49:26 Daniele Furlan wrote:
>> > I don't quite understand what you are proposing. Are you saying removi=
ng
>> > the averaging mechanism makes this patch obsolete and allows replacing
>> > the TTL/TQ values as the code does now (without the patch) ?
>>
>> No no this patch is good, the removing of TQ average can be a following
>> step as now average is not forwarded anymore, but only used as a
>> comparative value between path in another point of the source code.
>
> This follow-up step needs a volunteer. It is a bigger operation to remove=
 the
> averaging and ensure everything still works. =A0:-)
>
I can try  to send some patch next week to start this operation.. :)

> Do you mind explaining in simple words how the averaging could cause rout=
ing
> havoc together with the strict OGM forwarding patch ? I did not understan=
d.
> Or are you in favor of removing the averaging for style / performance rea=
sons?
>
Actually the average as it is calculated in the current version
(without "considering"
lost OGMs) is not monotonically decreasing. This cause routing loops when i=
t is
forwarded so with this patch the problem does not happen.
Remain the fact of non monotonicity and this could cause loop anyway
in some corner
situation.

Surely if we guarantee monotonicity we obtain LOOP-FRENESS IN ANY CASE and
this is an important feature I think!!

Also maintaing only the latest TQ guarantee to have a more updated informat=
ion
about the path. Furthermore an average is already done at every link TQ
calculation so it is superfluous to have another window. This reduce also m=
emory
and computational requirements.

> Cheers,
> Marek
>



--=20
Daniele Furlan

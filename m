Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 Jan 2012 04:49:25 +0800
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<20120127191334.GF27169@lunn.ch>
	<20120128141253.GF15766@ritirata.org>
In-Reply-To: <20120128141253.GF15766@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201201290449.25923.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
	shorter routes by changing the default hop penalty
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

> In my honest opinion we are mixing two different issues:
> 1) current hop penalty value not really significant
> 2) OGM link quality measurements do not reflect the metric we'd like it to
> be
> 
> 
> problem 2 is not going to be solved by hacking the hop penalty. It needs
> further investigation/research and NDP is probably a good starting point
> towards a possible solution (I think we all agree on this).

you are right - these are 2 different issues.


> For what concern the hop penalty, as far as I understood, it is in charge
> of making batman prefer a shorter route in case of equal TQs over the
> traversed links. Instead of hacking the value...what about redesigning the
> way the hop penalty affects the TQ value of forwarded OGMs? Maybe using a
> different function (poly of deg>1 or exp) instead of a simple linear
> decreasing? May this help all the scenarios we mentioned?

The hop penalty is not as linear as you think. The formula is:
tq * (TQ_MAX_VALUE - hop_penalty)) / (TQ_MAX_VALUE

With a hop penalty of 10 you get the following results:
tq = 255, penalty = 10, resulting tq = 245
tq = 200, penalty = 8, resulting tq = 192
tq = 150, penalty = 6, resulting tq = 144
tq = 100, penalty = 4, resulting tq = 96
tq = 50, penalty = 2, resulting tq = 48

As you can see the more the tq goes down the less influence the hop penalty 
has.

Regards,
Marek

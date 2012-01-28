Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 Jan 2012 05:03:37 +0800
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<201201272354.26055.lindner_marek@yahoo.de>
	<CAG7VhQRZ462=-eRiKPvQAOpruq-vWmmkrY-_qnUHsp5nBy2fKw@mail.gmail.com>
In-Reply-To: <CAG7VhQRZ462=-eRiKPvQAOpruq-vWmmkrY-_qnUHsp5nBy2fKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201290503.37808.lindner_marek@yahoo.de>
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

> I have experencied the same situation in some tests, and I agree with
> Andrew when he says that some form of justification is necessary.

you also have seen that a hop penalty of 10 is too high ? Can you explain your 
setup a bit more ?


> The problems of TQ emerges when the rate of devices increase, because
> especially in mixed b,g,n networks TQ does not distinguish between fast
> and slow link. We all know that brodcast losses does not say almost
> nothing about link speed or load.
> 
> The only way to improve the TQ metric is a cross-layer implementation as
> already experienced (considering only bandwidth) in my tests. Obviously
> this means breaking the "universal" compatibility with network interfaces,
> the use of mac80211 and cfg80211 in any case can limit this problem in my
> opinion.

I am certain that you great ideas and that you spend a lot of time on working 
with batman / meshing. However, it is somewhat difficult to review / discuss / 
adapt your work since we have a hard time understanding your concepts without 
proper explications / documentation. Would it possible for you to talk/write a 
bit more about your stuff ?

The WBMv5 is a good opportunity to chat because you get all of us in one 
place.  ;-)

Cheers,
Marek

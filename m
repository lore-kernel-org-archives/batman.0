Return-Path: <zoobab@gmail.com>
MIME-Version: 1.0
Sender: zoobab@gmail.com
In-Reply-To: <201203092236.51812.lindner_marek@yahoo.de>
References: <201203070156.51341.lindner_marek@yahoo.de>
	<74A4488FAEEC56408507A6FECA69099101221874@SC000647.CHASCOM.INT>
	<CANjd3nczdfd5XvNevVUtWJCP4J=ieUseSX85DVPrZcHV2ZExKg@mail.gmail.com>
	<201203092236.51812.lindner_marek@yahoo.de>
Date: Fri, 9 Mar 2012 16:25:03 +0100
Message-ID: <CANjd3ndFCA8LqJt1Un70zjv_OV3ye3kqiOoab1vCh73qd33+Pg@mail.gmail.com>
From: Benjamin Henrion <bh@udev.org>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [Battlemesh]  Diversity in BATMAN
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
To: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Fri, Mar 9, 2012 at 3:36 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> On Friday, March 09, 2012 22:07:37 Benjamin Henrion wrote:
>> > C=S will probably have a better TQ if it is not getting as much
>> > interference due to collisions. A will get to know about this in the
>> > path TQ. Better still, B-C will also probably have a better TQ, since
>> > the link C=S is not interfering with it. So the path TQ is even better.
>> > A gets all this.
>>
>> How do you compute the TQ?
>
> I suggest reading chapter 3.1 (specifically 3.1.3) of the excellent network
> coding paper[1] written by our catwoman specialists. It is very well written
> and contains the most comprehensive general overview about batman-adv in
> existence.

TQ is based on packet-loss only, so it is doomed to fail to detect
fast interfaces.

With such metric, you don't make any difference between a 56K
telephone line and a 10Ge NIC.

If you 10Ge has 5pc packet loss and your 56K line has 0pc, your TQ
will be prefer the 56k link.

--
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-3500762
"In July 2005, after several failed attempts to legalise software
patents in Europe, the patent establishment changed its strategy.
Instead of explicitly seeking to sanction the patentability of
software, they are now seeking to create a central European patent
court, which would establish and enforce patentability rules in their
favor, without any possibility of correction by competing courts or
democratically elected legislators."

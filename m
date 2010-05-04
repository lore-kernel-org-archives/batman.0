Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 4 May 2010 09:59:43 +0800
References: <Pine.LNX.3.95.1100503165208.1466E-100000@nei>
In-Reply-To: <Pine.LNX.3.95.1100503165208.1466E-100000@nei>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005040959.43700.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] real-time link monitor (was: updated README)
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


Hi,

>    I *DO* have it running on a pair of Meraki minis with villagetelco
> software. Seems to work *VERY* well.

glad to hear that !


>    I always seem to be looking for a real-time quality monitor so I can
> adjust antennas, check range, watch radios change by themselves, etc.
> i.e.- A real-time chart recorder widget. Thus my suggestion.

You are not the first one with such a feature request but let me point out that 
batman is not the right tool for the job. If you want to finetune antennas 
batman is way too slow and imprecise, since all it does is measuring packet 
loss within a certain time frame. Deriving antenna directions from that is 
more magic than real sience.

I'd rather suggest a tool like "horst" (Highly Optimized Radio Scanning Tool - 
http://br1.einfach.org/tech/horst/) which hooks into your wifi driver to 
retrieve real-time data about the link quality to your neighbors. Of course, 
such a tool is highly dependend on the wifi driver and probably does not 
support all the drivers in the world but I'm sure it can be extended.

Regards,
Marek

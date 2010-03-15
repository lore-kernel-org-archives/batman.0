Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Mar 2010 19:44:27 +0800
References: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
	<20100314204138.GA6096@Linus-Debian>
	<59537C95-BCEC-4E94-9E59-E0E96D289776@me.com>
In-Reply-To: <59537C95-BCEC-4E94-9E59-E0E96D289776@me.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201003151944.27711.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Suitability for MAGIC 2010
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

> Well I don't remember mentioning MAGIC 2010, but you are   correct, the
>  project is MAGIC 2010. Good investigatory work! :) 

the email's subject contained the necessary hints.  ;-)


> Furthermore, message passing may not necessarily be done with the use of a
> middleware. Realtime unreliable data such as GPS and telemetry information
> may simply be pushed onto the network in UDP packets. I would prefer to  
> use a nice middleware that performs well in MANET environments and I  
> am still evaluating the possibility of this. If you have any  
> recommendations that would be good!

What exactly are you looking for ("middleware" is a pretty broad term) ? An 
application that can send GPS data through the network ?


> Further on the topic of using BSS. We do expect wifi dead-spots and we  
> must absolutely try to minimize these. So the multi-hop nature of  
> something like B.A.T.M.A.N (i was hoping) would help in that regard.

Yes, batman can help you "extending" the network. But the biggest troublemaker 
will be the wifi driver because adhoc mode isn't that well supported. 99% of 
the users want infrastructure mode, therefore developers work on that first. 
Adhoc mode comes later (if at all), is often buggy and not well tested. The 
wifi communities get around this issue by focussing on hardware which either 
comes with an open driver (e.g. atheros chips) or have a working adhoc mode 
implementation. Depending on how much freedom of hardware choice you have I'd 
suggest you carefully pick your wifi chips.


> I can't guarantee that we will use B.A.T.M.A.N but I will try to  
> evaluate it in the field eventually.

Please, share the results of these tests with us. Even if you don't choose 
batman we would be very interested to find out what we can improve.  :-)

Cheers,
Marek

